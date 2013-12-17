describe "A Bureau Managing It's Drawers" do
  before do
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
end
