describe 'A Bureau Populating its Menu' do
  before do
    @structure = [
      {
        title: 'Section 1',
        drawers:
        [
          {
            title: 'Option 1.1',
            accessory: UITableViewCellAccessoryCheckmark,
          },
          {
            title: 'Option 1.2',
            subtitle: 'Quiet Note',
            icon: UIImage.imageNamed('martini.png'),
            accessory: UIView.alloc.initWithFrame(CGRectMake(0,0,28,28)),
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
    @bureau = Bureau::Bureau.new(structure:@structure)
  end

  it 'should have the correct number of sections' do
    @bureau.numberOfSectionsInTableView(@bureau.table).should == @structure.count
  end

  it 'should have the correct number of rows' do
    @structure.each_with_index do |section, position|
      if section.has_key? :drawers
        num_rows = section[:drawers].count
      else
        num_rows = 0
      end
      @bureau.tableView(@bureau.table, numberOfRowsInSection:position).should == num_rows
    end
  end

  it 'should title the sections correctly' do
    @structure.each_with_index do |section, position|
      title = section[:title] || ''
      @bureau.tableView(@bureau.table, titleForHeaderInSection:position).should == title
    end
  end

  it 'should populate the cell\'s title, subtitle, icon, and accessory correctly ' do
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
end

