describe 'The Bureau Class' do
  it 'is defined' do
    defined?(Bureau::Bureau).should == "constant"
  end

  it 'is a subclass of UIViewController' do
    Bureau::Bureau.superclass.should == UIViewController
  end
end
