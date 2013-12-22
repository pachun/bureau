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

    def tableView(_, heightForHeaderInSection:section)
      @header_height
    end

    def tableView(_, titleForHeaderInSection:section)
      if @structure[section].has_key? :title
        @structure[section][:title]
      else
        ''
      end
    end

    def tableView(_, viewForHeaderInSection:section)
      if @structure[section].has_key?(:title)
        nil
      else
        customize_header_in_section(section)
      end
    end

    def tableView(_, cellForRowAtIndexPath:index_path)
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: Cell)
      drawer = @structure[index_path.section][:drawers][index_path.row]
      apply_active_color(cell, drawer, index_path)
      decorate(cell, content:drawer)
      customize(cell, in_section:index_path.section, row:index_path.row)
      cell
    end

    def tableView(_, heightForRowAtIndexPath:_)
      @drawer_height
    end

    def tableView(_, didSelectRowAtIndexPath:index_path)
      section = index_path.section
      drawer_position = index_path.row
      tapped_drawer = @structure[section][:drawers][drawer_position]
      tapped(tapped_drawer)
    end

    def customize(cell, in_section:_, row:_)
      cell
    end

    def customize_header_in_section(section)
      screen_width = UIScreen.mainScreen.bounds.size.width
      UIView.alloc.initWithFrame(CGRectMake(0,0,screen_width,@header_height))
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

    def apply_active_color(cell, drawer, index_path)
      set_active_cell_color_on(cell)
      if drawer[:open]
        @table.selectRowAtIndexPath(index_path, animated:false, scrollPosition:UITableViewScrollPositionNone)
      end
    end

    def set_active_cell_color_on(cell)
      selected_bg_view = UIView.alloc.init
      selected_bg_view.backgroundColor = @active_cell_color
      selected_bg_view.layer.masksToBounds = true
      cell.selectedBackgroundView = selected_bg_view
    end

    def decorate(cell, content:drawer)
      cell.textLabel.font = @drawer_font
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
