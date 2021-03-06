describe 'A Bureau Populating its Menu' do
  before do
    class UIViewController < UIResponder
      include Bureau::Controller
    end
    @structure = [
      {
        drawers:
        [
          {
            title: 'Option 1.1',
            accessory: UITableViewCellAccessoryCheckmark,
            controller: UIViewController.new,
            active: true,
          },
          {
            title: 'Option 1.2',
            subtitle: 'Quiet Note',
            icon: UIImage.imageNamed('martini.png'),
            accessory: UIView.alloc.initWithFrame(CGRectMake(0,0,28,28)),
            controller: UIViewController.new,
          },
        ],
      },
      {
        drawers:[{ title: 'Option 2.1' }],
      },
      {
        title: 'Section 3'
      },
    ]
    @drawer_height = 80
    @header_height = 100
    @drawer_font = UIFont.systemFontOfSize(16)
    @header_font = UIFont.boldSystemFontOfSize(20)
    @drawer_text_color = UIColor.yellowColor
    @bureau = Bureau::Bureau.new(
      structure:@structure,
      drawer_height:@drawer_height,
      header_height:@header_height,
      drawer_font: @drawer_font,
      header_font: @header_font,
      drawer_text_color: @drawer_text_color,
    )
  end

  it 'has the correct number of sections' do
    @bureau.numberOfSectionsInTableView(@bureau.table).should == @structure.count
  end

  it 'has the correct number of rows' do
    @structure.each_with_index do |section, position|
      if section.has_key? :drawers
        num_rows = section[:drawers].count
      else
        num_rows = 0
      end
      @bureau.tableView(@bureau.table, numberOfRowsInSection:position).should == num_rows
    end
  end

  it 'titles the sections' do
    @structure.each_with_index do |section, position|
      title = section[:title] || ''
      @bureau.tableView(@bureau.table, titleForHeaderInSection:position).should == title
    end
  end

  it 'populates the cell\'s title, subtitle, icon, and accessory' do
    @structure.each_with_index do |section, section_num|
      if section.has_key? :drawers
        section[:drawers].each_with_index do |row, row_num|
          index_path = NSIndexPath.indexPathForRow(row_num, inSection:section_num)
          cell = @bureau.tableView(@bureau.table, cellForRowAtIndexPath:index_path)
          cell.textLabel.text.should == (row[:title] || '')
          cell.detailTextLabel.text.should == (row[:subtitle] || '')
          cell.imageView.image.should == row[:icon]
          if row.has_key? :accessory
            if row[:accessory].class == UIView
              cell.accessoryView.should == row[:accessory]
            else
              cell.accessoryType.should == row[:accessory]
            end
          else
          end
        end
      end
    end
  end

  it "sets drawer heights" do
    index_path = NSIndexPath.indexPathForRow(0, inSection:0)
    height = @bureau.tableView(@bureau.table, heightForRowAtIndexPath:index_path)
    height.should == @drawer_height
  end

  it "sets header heights" do
    height = @bureau.tableView(@bureau.table, heightForHeaderInSection:0)
    height.should == @header_height
  end

  it "sets drawer fonts" do
    index_path = NSIndexPath.indexPathForRow(0, inSection:0)
    cell = @bureau.tableView(@bureau.table, cellForRowAtIndexPath:index_path)
    cell.textLabel.font.should == @drawer_font
  end

  it "sets drawer font colors" do
    index_path = NSIndexPath.indexPathForRow(0, inSection:0)
    cell = @bureau.tableView(@bureau.table, cellForRowAtIndexPath:index_path)
    cell.textLabel.textColor.should == @drawer_text_color
  end
end
