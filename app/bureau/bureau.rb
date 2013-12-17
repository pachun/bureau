module Bureau

  DefaultState = :closed
  DefaultDrawerHeight = 50
  DefaultSlideWidth = 300
  DefaultSlideDuration = 0.3

  class Bureau < UIViewController
    include Menu
    attr_accessor :table, :structure,
      :state, :drawer_height, :slide_width, :slide_duration

    def init
      InitializationError.need_hash
    end

    def initialize(options)
      validate_and_save(options[:structure])
      save_options(options)
      setup_table
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
      @slide_width = options[:slide_width] || DefaultSlideWidth
      @slide_duration = options[:slide_duration] || DefaultSlideDuration
    end

    def setup_table
      @table = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds,
                                                style:UITableViewStylePlain)
      @table.delegate = self
      @table.dataSource = self
      view.addSubview(@table)
    end
  end
end
