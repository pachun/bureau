describe 'The Bureau Class' do
  it 'is defined' do
    defined?(Bureau::Bureau).should == "constant"
  end

  it 'is a subclass of UIViewController' do
    # this test used to work until i included the Menu module in the Bureau::Bureau class... Very, very weird
    # Bureau::Bureau.superclass.should == UIViewController

    Bureau::Bureau.superclass.new.class.should == UIViewController
  end
end
