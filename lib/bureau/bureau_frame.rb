module Bureau
  module Frame
    def self.menu
      screen = UIScreen.mainScreen.bounds.size
      CGRectMake(0, StatusBarHeight, screen.width, screen.height-StatusBarHeight)
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
  end
end
