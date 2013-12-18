describe "A Bureau Instance Initializing its Menu" do
  before do
    @bureau = Bureau::Bureau.new(structure:[])
  end

  it 'creates a table' do
    @bureau.table.class.should == UITableView
  end

  it "fullscreens the table under the status bar" do
    table_frame = @bureau.table.frame
    table_frame.origin.x.should == 0
    table_frame.origin.y.should == 20

    screen = UIScreen.mainScreen.bounds.size
    table_frame.size.width.should == screen.width
    table_frame.size.height.should == screen.height
  end

  it "sets the table's delegate to itself" do
    @bureau.table.delegate.should == @bureau
  end

  it "sets the table's data source to itself" do
    @bureau.table.dataSource.should == @bureau
  end

  it "adds the table as a subview" do
    @bureau.view.subviews.include?(@bureau.table).should == true
  end

  it "implements required table data source callback methods" do
    defined?(@bureau.tableView(:x, numberOfRowsInSection: :y)).should == "method"
    defined?(@bureau.tableView(:x, cellForRowAtIndexPath: :y)).should == "method"
    # These test private methods;
    #   comment out the private keyword to uncomment these
    # @bureau.tableView(:x, numberOfRowsInSection: :y).class.should == Fixnum
    # @bureau.tableView(:x, cellForRowAtIndexPath: :y).class.should == UITableViewCell
  end
end
