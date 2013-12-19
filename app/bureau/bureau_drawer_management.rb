module Bureau
  class Bureau < UIViewController
    def open_drawer
      open = all_drawers.select{ |d| d[:open] == true }.first
      if open.nil?
        open = all_drawers.select{ |d| d.has_key?(:controller) }.first
        open[:open] = true unless open.nil?
      end
      open
    end

    def toggle_menu_state
      if @state == :open
        animate_closed
      else
        animate_open
      end
    end

    private

    def all_drawers
      @structure.inject([]) do |list, section|
        section.has_key?(:drawers) ? list + section[:drawers] : list
      end
    end

    def open(drawer)
      drawer[:open] = true
      controller = new_controller_for(drawer)
      addChildViewController(controller)
      drawer_view = controller.view
      drawer_view.frame = Frame::for_state(@state, sliding:@slide_width)
      view.addSubview(drawer_view)
    end

    def close_open_drawer
      open = open_drawer
      open[:open] = false
      open_controller = current_controller_for(open)
      open_controller.removeFromParentViewController
      open_controller.view.removeFromSuperview
    end

    def animate_open
      UIView.animateWithDuration(@slide_duration, delay:0, options:0, animations: lambda do
        current_controller_for(open_drawer).view.frame = Frame::open(@slide_width)
      end, completion: nil)
      @state = :open
    end

    def animate_closed
      UIView.animateWithDuration(@slide_duration, delay:0, options:0, animations: lambda do
        current_controller_for(open_drawer).view.frame = Frame::closed
      end, completion: nil)
      @state = :closed
    end

    def new_controller_for(drawer)
      if drawer[:controller].class == Class
        drawer[:controller_instance] = drawer[:controller].new
        drawer[:controller_instance].bureau = self
        drawer[:controller_instance]
      else
        drawer[:controller]
      end
    end

    def current_controller_for(drawer)
      if drawer[:controller].class == Class
        drawer[:controller_instance]
      else
        drawer[:controller]
      end
    end
  end
end
