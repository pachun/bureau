describe "A Bureau in the Open State" do
  before do
    @x = UIViewController.new
    @y = UIViewController.new
    class X
      attr_accessor :num
      def initialize; @num = 5; end
      def do_nothing; end
      def change_num; @num = 10; end
    end
    @z = X.new
    @structure = [
      {
        drawers:
        [
          {target: @z, action: :do_nothing},
          {controller: @x},
        ]
      },
      {
        drawers:
        [
          {target: @z, action: :change_num},
          {controller: @y, open: true},
        ]
      },
    ]
    @bureau = Bureau::Bureau.new(structure:@structure, state: :open)
  end

  it "removes the previously open drawer when a new one with a controller is tapped" do
    new_active_path = NSIndexPath.indexPathForRow(1, inSection:0)
    @bureau.tableView(@bureau.table, didSelectRowAtIndexPath:new_active_path)
    @bureau.structure.last[:drawers].last[:open].should.not == true
    @bureau.childViewControllers.should.not.include @y
    @bureau.view.subviews.should.not.include @y.view
  end

  it "does not remove the previously open drawer when a new one without a controller is tapped" do
    new_active_path = NSIndexPath.indexPathForRow(0, inSection:0)
    @bureau.tableView(@bureau.table, didSelectRowAtIndexPath:new_active_path)
    @bureau.structure.last[:drawers].last[:open].should == true
    @bureau.childViewControllers.should.include @y
    @bureau.view.subviews.should.include @y.view
  end

  it "opens the touched drawer when a new one with a controller is tapped" do
    new_active_path = NSIndexPath.indexPathForRow(1, inSection:0)
    @bureau.tableView(@bureau.table, didSelectRowAtIndexPath:new_active_path)
    @bureau.structure[0][:drawers][1][:open].should == true
    @bureau.childViewControllers.should.include @x
    @bureau.view.subviews.should.include @x.view
    @x.view.frame.should == Bureau::Frame::open(@bureau.slide_width)
  end

  it "executes the action of a target/action drawer when one is tapped" do
    tapped_path = NSIndexPath.indexPathForRow(0, inSection:1)
    @z.num.should == 5
    @bureau.tableView(@bureau.table, didSelectRowAtIndexPath:tapped_path)
    @z.num.should == 10
  end
end
