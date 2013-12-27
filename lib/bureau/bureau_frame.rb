module Bureau
  module Frame
    def self.menu(width)
      screen = UIScreen.mainScreen.bounds.size
      CGRectMake(0, StatusBarHeight, width, screen.height-StatusBarHeight)
    end

    def self.for_state(state, sliding:width, orientations:orientations, last_frame:last_frame)
      if state == :open
        open(width, orientations, last_frame)
      else
        UIScreen.mainScreen.bounds
      end
    end

    def self.open(slide_width, orientations, last_frame)
      if orientations.include?(UIDevice.currentDevice.orientation)
        screen_frame(slide_width, 0)
      else
        slide_right(last_frame, slide_width)
      end
    end

    def self.closed(orientations, last_frame)
      if orientations.include?(UIDevice.currentDevice.orientation)
        screen_frame(0,0)
      else
        slide_left(last_frame)
      end
    end

    def self.slide_left(frame)
      CGRectMake(0,0,frame.size.width,frame.size.height)
    end

    def self.slide_right(frame, distance)
      CGRectMake(distance,0,frame.size.width,frame.size.height)
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
