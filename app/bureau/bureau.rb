StatusBarHeight = 20

module Bureau
  DefaultState = :closed
  DefaultDrawerHeight = 50
  DefaultSlideWidth = 300
  DefaultSlideDuration = 0.3

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
  end

  class Bureau < UIViewController
    include Menu
    attr_accessor :table, :structure,
      :state, :drawer_height, :slide_width, :slide_duration, :status_bar_bg

    def init
      InitializationError.need_hash
    end

    def initialize(options)
      @status_bar_bg = UIView.alloc.initWithFrame(CGRectMake(0,0,320,20))
      view.addSubview(@status_bar_bg)
      validate_and_save(options[:structure])
      save_options(options)

      open = open_drawer
      unless open.nil?
        addChildViewController(open[:controller])
        drawer_view = open[:controller].view
        drawer_view.frame = Frame::for_state(@state, sliding:@slide_width)
        view.addSubview(drawer_view)
      end
      setup_table
    end

    def open_drawer
      open = all_drawers.select{ |d| d[:open] == true }.first
      if open.nil?
        open = all_drawers.select{ |d| d.has_key?(:controller) }.first
        open[:open] = true unless open.nil?
      end
      open
    end

    private
    def all_drawers
      @structure.inject([]) do |list, section|
        section.has_key?(:drawers) ? list + section[:drawers] : list
      end
    end

    def validate_and_save(structure)
      if structure
        StructureValidator.instance.validate(structure)
        @structure = structure
      else
        InitializationError.need_structure_key
      end
    end

    def save_options(options)
      @state = options[:state] || DefaultState
      @drawer_height = options[:drawer_height] || DefaultDrawerHeight
      @slide_width = options[:slide_width] || DefaultSlideWidth
      @slide_duration = options[:slide_duration] || DefaultSlideDuration
      @status_bar_bg.backgroundColor = options[:status_bar_color] || UIColor.whiteColor
    end

    def setup_table
      @table = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds,
                                                style:UITableViewStylePlain)
      @table.frame = Frame::menu
      @table.delegate = self
      @table.dataSource = self
      view.addSubview(@table)
    end
  end
end
