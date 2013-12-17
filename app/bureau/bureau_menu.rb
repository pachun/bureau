module Bureau
  module Menu
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
                                          reuseIdentifier: Cell)
      row = @structure[index_path.section][:drawers][index_path.row]
      decorate(cell, content:row)
      cell
    end

    private
    def decorate(cell, content:row)
      cell.textLabel.text = row[:title] || ''
      cell.detailTextLabel.text = row[:subtitle] || ''
      cell.imageView.image = row[:icon]
      set(cell, accessory:row[:accessory]) if row.has_key?(:accessory)
    end

    def set(cell, accessory:accessory)
      if accessory.class == UIView
        cell.accessoryView = accessory
      else
        cell.accessoryType = accessory
      end
    end
  end

  class Cell; end
end
