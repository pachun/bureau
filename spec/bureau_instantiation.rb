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

  it "sensibly defaults menu options" do
    bureau = Bureau::Bureau.new(structure:[])
    bureau.state.should == :closed
    bureau.drawer_height.should == 50
    bureau.slide_width.should == 300
    bureau.slide_duration.should == 0.3
  end

  it "can manually set options in the init hash" do
    state = :open
    drawer_height = 60
    slide_width = 280
    slide_duration = 1.0
    options = {
      structure: [],
      state: state,
      drawer_height: drawer_height,
      slide_width: slide_width,
      slide_duration: slide_duration,
    }
    bureau = Bureau::Bureau.new(options)
    bureau.state.should == state
    bureau.drawer_height.should == drawer_height
    bureau.slide_width.should == slide_width
    bureau.slide_duration.should == slide_duration
  end
end
