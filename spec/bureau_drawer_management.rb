describe "A Bureau Managing It's Drawers" do
  before do
    class UIViewController < UIResponder
      include Bureau::Controller
    end
    @x = UIViewController.new
    @y = UIViewController.new
    @structure = [
      {
        drawers:
        [
          {target: nil, action: :something},
          {controller: @x},
        ]
      },
      {
        drawers:
        [
          {target: nil, action: :something_else},
          {controller: @y, open: true},
        ]
      },
    ]
  end

  it "can find the open drawer" do
    bureau = Bureau::Bureau.new(structure:@structure)
    bureau.open_drawer.should == @structure.last[:drawers].last
  end

  it "opens the first drawer with a controller if one isn't already open" do
    @structure.last[:drawers].last[:open] = false
    bureau = Bureau::Bureau.new(structure:@structure)
    bureau.open_drawer.should == @structure.first[:drawers].last
  end

  it "adds the open drawer's view controller and view" do
    bureau = Bureau::Bureau.new(structure:@structure)
    drawer = @structure.last[:drawers].last
    bureau.childViewControllers.should.include drawer[:controller]
    bureau.view.subviews.should.include drawer[:controller].view
  end

  it "does not error if there is no possible drawer to open" do
    @structure.first[:drawers].last.delete(:controller)
    @structure.last[:drawers].last.delete(:controller)
    @structure.last[:drawers].last.delete(:open)
    lambda do
      Bureau::Bureau.new(structure:@structure)
    end.should.not.raise StandardError
  end

  it "initializes the open drawers view frame based on the menu state (open or closed)" do
    screen = UIScreen.mainScreen.bounds

    open_bureau = Bureau::Bureau.new(structure:@structure, state: :open)
    open_state_frame = CGRectMake(open_bureau.slide_width, 0, screen.size.width, screen.size.height)
    open_bureau.open_drawer[:controller].view.frame.should == open_state_frame

    closed_bureau = Bureau::Bureau.new(structure:@structure, state: :closed)
    closed_bureau.open_drawer[:controller].view.frame.should == screen
  end
end
