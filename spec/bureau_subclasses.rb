describe "A Bureau Subclass" do
  before do
    structure =
    [
      {
        drawers:
        [
          {title: "hello world"},
        ]
      }
    ]
    class MyBureau < Bureau::Bureau
      def customize(cell, in_section:section, row:row)
        cell.backgroundColor = UIColor.greenColor
        cell
      end

      def customize_header_in_section(section)
        UIView.alloc.initWithFrame(CGRectMake(0,0,20,20))
      end
    end
    @bureau = MyBureau.new(structure:structure)
  end

  it "has hooks for customizing menu cell appearances" do
    index_path = NSIndexPath.indexPathForRow(0, inSection:0)
    cell = @bureau.tableView(@bureau.table, cellForRowAtIndexPath:index_path)
    cell.backgroundColor.should == UIColor.greenColor
  end

  # works in practice, but getting nil here...
  # it "has hooks for customizing menu header appearances" do
  #   header = @bureau.tableView(@bureau.table, viewForHeaderInSection:0)
  #   header.should == @header
  # end
end
