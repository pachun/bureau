describe "A Bureau Instance Initializing its Menu" do
  before do
    @bureau = Bureau::Bureau.new(structure:[])
  end

  it 'creates a table' do
    @bureau.table.class.should == UITableView
  end

  it "frames the table under the status bar and the width of the slide animation" do
    table_frame = @bureau.table.frame
    table_frame.origin.x.should == 0
    table_frame.origin.y.should == StatusBarHeight

    screen = UIScreen.mainScreen.bounds.size
    table_frame.size.width.should == @bureau.slide_width
    table_frame.size.height.should == screen.height - StatusBarHeight
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
  end

  it "turns off the separator when set to" do
    @bureau.table.separatorStyle.should == UITableViewCellSeparatorStyleSingleLine
    bureau = Bureau::Bureau.new(structure:[], drawer_separators: :none)
    bureau.table.separatorStyle.should == UITableViewCellSeparatorStyleNone
  end

  it "turns off table scrolling when set to" do
    @bureau.table.scrollEnabled?.should == false
    bureau = Bureau::Bureau.new(structure:[], menu_scrolling: :yes)
    bureau.table.scrollEnabled?.should == true
  end
end
