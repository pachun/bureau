StatusBarHeight = 20

module Bureau
  DefaultState = :closed
  DefaultDrawerHeight = 50
  DefaultHeaderHeight = 60
  DefaultSlideWidth = 300
  DefaultSlideDuration = 0.3
  DefaultDrawerSeparators = true
  DefaultActiveCellColor = UIColor.lightGrayColor
  DefaultStatusBarColor = UIColor.whiteColor
  DefaultDrawerFont = UIFont.systemFontOfSize(12)
  DefaultDrawerTextColor = UIColor.blackColor
  MenuScrolling = :no
  HasShadow = :no
  Orientations = [1,3,4]

  class Bureau < UIViewController
    include Menu
    attr_accessor :table, :structure,
      :state, :drawer_height, :header_height,
      :slide_width, :slide_duration, :status_bar_bg,
      :drawer_separators, :active_cell_color,
      :drawer_font, :drawer_text_color, :menu_scrolling,
      :has_shadow, :shadow_view, :orientations

    def init
      InitializationError.need_hash
    end

    def initialize(options)
      validate_and_save(options[:structure])
      save_options(options)
      setup_table
      add_shadow if @has_shadow == :yes
      setup_controllers
      # open(open_drawer) unless open_drawer.nil?
      orientate unless open_drawer.nil?
    end

    private
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
      @header_height = options[:header_height] || DefaultHeaderHeight
      @slide_width = options[:slide_width] || DefaultSlideWidth
      @slide_duration = options[:slide_duration] || DefaultSlideDuration
      @drawer_separators = options[:drawer_separators] || DefaultDrawerSeparators
      @active_cell_color = options[:active_cell_color] || DefaultActiveCellColor
      @drawer_font = options[:drawer_font] || DefaultDrawerFont
      @drawer_text_color = options[:drawer_text_color] || DefaultDrawerTextColor
      @menu_scrolling = options[:menu_scrolling] || MenuScrolling
      @has_shadow = options[:has_shadow] || HasShadow
      @orientations = options[:orientations] || Orientations
      setup_status_bar(options[:status_bar_color] || DefaultStatusBarColor)
    end

    def add_shadow
      shadow_frame = (@state == :open ? Frame.open_shadow(@slide_width) : Frame.closed_shadow)
      @shadow_view = UIView.alloc.initWithFrame(shadow_frame).tap do |view|
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 2
        view.layer.shadowOffset = CGSizeMake(-5, 0)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.6
        view.backgroundColor = UIColor.whiteColor
      end
      view.addSubview(@shadow_view)
    end

    def setup_status_bar(bg_color)
      device_width = @slide_width
      dimensions = CGRectMake(0,0,device_width,StatusBarHeight)
      @status_bar_bg = UIView.alloc.initWithFrame(dimensions)
      @status_bar_bg.backgroundColor = bg_color
      view.addSubview(@status_bar_bg)
    end

    def setup_table
      @table = UITableView.alloc.initWithFrame(Frame::menu(@slide_width), style:UITableViewStylePlain)
      @table.separatorStyle = UITableViewCellSeparatorStyleNone if @drawer_separators == :none
      @table.scrollEnabled = @menu_scrolling == :no ? false : true
      @table.delegate = self
      @table.dataSource = self
      view.addSubview(@table)
    end

    def setup_controllers
      all_drawers.each do |drawer|
        if drawer.has_key?(:controller)
          drawer[:controller].bureau = self unless drawer[:controller].class == Class
        end
      end
    end

    def orientate
      UIDevice.currentDevice.beginGeneratingDeviceOrientationNotifications
      NSNotificationCenter.defaultCenter.addObserver(self,
                                                     selector: :launch_orientation_discovered,
                                                     name: UIDeviceOrientationDidChangeNotification,
                                                     object:nil)
    end

    def launch_orientation_discovered
      NSNotificationCenter.defaultCenter.removeObserver(self)
      open(open_drawer)
    end
  end
end
