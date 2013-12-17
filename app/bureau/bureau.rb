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

    def initialize(format)
      if format.has_key? :structure
        StructureValidator.instance.validate(format[:structure])
        @structure = format[:structure]
      else
        InitializationError.need_structure_key
      end
      @state = format[:state] || DefaultState
      @drawer_height = format[:drawer_height] || DefaultDrawerHeight
      @slide_width = format[:slide_width] || DefaultSlideWidth
      @slide_duration = format[:slide_duration] || DefaultSlideDuration
      setup_table
    end

    private
    def setup_table
      @table = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds,
                                                style:UITableViewStylePlain)
      @table.delegate = self
      @table.dataSource = self
      view.addSubview(@table)
    end
  end
end
