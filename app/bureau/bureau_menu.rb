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
      drawer = @structure[index_path.section][:drawers][index_path.row]
      decorate(cell, content:drawer)
      cell
    end

    def tableView(_, didSelectRowAtIndexPath:index_path)
      section = index_path.section
      drawer_position = index_path.row
      tapped_drawer = @structure[section][:drawers][drawer_position]
      tapped(tapped_drawer)
    end

    private
    def tapped(tapped_drawer)
      if tapped_drawer.has_key?(:controller)
        close_open_drawer
        open(tapped_drawer)
        toggle_menu_state
      elsif tapped_drawer.has_key?(:target)
        tapped_drawer[:target].send(tapped_drawer[:action])
      end
    end

    def decorate(cell, content:drawer)
      cell.textLabel.text = drawer[:title] || ''
      cell.detailTextLabel.text = drawer[:subtitle] || ''
      cell.imageView.image = drawer[:icon]
      set(cell, accessory:drawer[:accessory]) if drawer.has_key?(:accessory)
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
