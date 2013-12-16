module Bureau
  class Bureau < UIViewController
    attr_accessor :table, :structure

    def init
      InitializationError.need_hash
    end

    def initialize(format)
      if format.has_key? :structure
        StructureValidator.instance.validate(format[:structure])
        @structure = format[:structure]
      else
        InitializationError.need_structure_key
      end
      setup_table
    end

    # private
    #   dont think these can be private
    def numberOfSectionsInTableView(_)
      @structure.count
    end

    def tableView(_, numberOfRowsInSection:section)
      if @structure[section].has_key? :drawers
        @structure[section][:drawers].count
      else
        0
      end
    end

    def tableView(_, titleForHeaderInSection:section)
      if @structure[section].has_key? :title
        @structure[section][:title]
      else
        ''
      end
    end

    def tableView(_, cellForRowAtIndexPath:index_path)
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle,
                                          reuseIdentifier: BureauCell)
      row = @structure[index_path.section][:drawers][index_path.row]
      cell.textLabel.text = row[:title] || ''
      cell.detailTextLabel.text = row[:subtitle] || ''
      cell.imageView.image = row[:icon]
      if row.has_key? :accessory
        if row[:accessory].class == UIView
          cell.accessoryView = row[:accessory]
        else
          cell.accessoryType = row[:accessory]
        end
      end
      cell
    end

    private
    def setup_table
      @table = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds,
                                                style:UITableViewStylePlain)
      @table.delegate = self
      @table.dataSource = self
      view.addSubview(@table)
    end
  end

  class BureauCell; end
end
