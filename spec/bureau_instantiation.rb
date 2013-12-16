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
end
