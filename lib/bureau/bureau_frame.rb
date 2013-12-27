module Bureau
  module Frame
    def self.menu(width)
      screen = UIScreen.mainScreen.bounds.size
      CGRectMake(0, StatusBarHeight, width, screen.height-StatusBarHeight)
    end

    def self.for_state(state, sliding:width)
      if state == :open
        open(width)
      else
        UIScreen.mainScreen.bounds
      end
    end

    def self.open(slide_width)
      screen_frame(slide_width, 0)
    end

    def self.closed
      screen_frame(0,0)
    end

    def self.screen_frame(x_origin, y_origin)
      screen = UIScreen.mainScreen.bounds.size
      orientation = UIDevice.currentDevice.orientation
      width = (orientation == 3 || orientation == 4) ? screen.height : screen.width
      height = (orientation == 3 || orientation == 4) ? screen.width : screen.height
      CGRectMake(x_origin, y_origin, width, height)
    end

    def self.open_shadow(width)
      screen = UIScreen.mainScreen.bounds.size
      CGRectMake(width, 0, 5, screen.height)
    end

    def self.closed_shadow
      screen = UIScreen.mainScreen.bounds.size
      CGRectMake(0, 0, 5, screen.height)
    end
  end
end
