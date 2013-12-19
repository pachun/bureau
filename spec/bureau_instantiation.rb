describe "A Bureau Being Instantiated" do
  it "shows a descriptive error if a hash isn't given to #new" do
    exception = lambda{ Bureau::Bureau.new }.should.raise(Bureau::InitializationError)
    exception.message.should == "Bureau.new({}) requires a hash on initialization"
  end

  it "errors if the hash given to #new doesn't have a :structure key" do
    exception = lambda{ Bureau::Bureau.new({}) }.should.raise(Bureau::InitializationError)
    exception.message.should == "Bureau.new({})'s initialization hash requires a :structure key"
  end

  it "raises no errors if #new receives a hash containing a :structure key" do
    lambda{ Bureau::Bureau.new(structure:[]) }.should.not.raise Bacon::Error
  end

  it "creates a status bar background" do
    bureau = Bureau::Bureau.new(structure:[])
    bureau.status_bar_bg.should.be.instance_of UIView
    bureau.status_bar_bg.superview.should == bureau.view
  end

  it "sensibly defaults menu options" do
    bureau = Bureau::Bureau.new(structure:[])
    bureau.state.should == :closed
    bureau.drawer_height.should == 50
    bureau.slide_width.should == 300
    bureau.slide_duration.should == 0.3
    bureau.status_bar_bg.backgroundColor.should == UIColor.whiteColor
  end

  it "can manually set options in the init hash" do
    state = :open
    drawer_height = 60
    slide_width = 280
    slide_duration = 1.0
    status_bar_color = UIColor.yellowColor
    options = {
      structure: [],
      state: state,
      drawer_height: drawer_height,
      slide_width: slide_width,
      slide_duration: slide_duration,
      status_bar_color: status_bar_color,
    }
    bureau = Bureau::Bureau.new(options)
    bureau.state.should == state
    bureau.drawer_height.should == drawer_height
    bureau.slide_width.should == slide_width
    bureau.slide_duration.should == slide_duration
    bureau.status_bar_bg.backgroundColor.should == status_bar_color
  end

  it "puts the open drawer's view over the menu and status bar views" do
    controller = UIViewController.alloc.init
    structure = [
      {
        drawers: [
          {controller: controller}
        ]
      }
    ]
    bureau = Bureau::Bureau.new(structure:structure)
    views = bureau.view.subviews
    views.index(controller.view).should.be > views.index(bureau.status_bar_bg)
    views.index(controller.view).should.be > views.index(bureau.table)
  end
end
