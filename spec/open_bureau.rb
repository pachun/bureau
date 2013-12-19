describe "A Bureau in the Open State" do
  before do
    class UIViewController < UIResponder
      include Bureau::Controller
    end
    class SomeController < UIViewController; end
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
          {controller: SomeController},
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
    @x.view.frame.should == Bureau::Frame::closed
  end

  it "executes the action of a target/action drawer when one is tapped" do
    tapped_path = NSIndexPath.indexPathForRow(0, inSection:2)
    @z.num.should == 5
    @bureau.tableView(@bureau.table, didSelectRowAtIndexPath:tapped_path)
    @z.num.should == 10
  end

  it "instantiates controllers set as classes when tapped" do
    tapped_path = NSIndexPath.indexPathForRow(0, inSection:1)
    @bureau.tableView(@bureau.table, didSelectRowAtIndexPath:tapped_path)
    @bureau.open_drawer[:controller_instance].should.be.instance_of SomeController
  end

  it "re-instantiates controllers set as classes when tapped" do
    first_tapped_path = NSIndexPath.indexPathForRow(0, inSection:1)
    @bureau.tableView(@bureau.table, didSelectRowAtIndexPath:first_tapped_path)
    old_instance = @bureau.open_drawer[:controller_instance]
    second_tapped_path = NSIndexPath.indexPathForRow(1, inSection:0)
    @bureau.tableView(@bureau.table, didSelectRowAtIndexPath:second_tapped_path)
    @bureau.tableView(@bureau.table, didSelectRowAtIndexPath:first_tapped_path)
    new_instance = @bureau.open_drawer[:controller_instance]
    new_instance.should.not == old_instance
  end
end
