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

    def self.open(width)
      screen = UIScreen.mainScreen.bounds.size
      CGRectMake(width, 0, screen.width, screen.height)
    end

    def self.closed
      UIScreen.mainScreen.bounds
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
