module Bureau
  class Bureau < UIViewController
    include Menu
    attr_accessor :table, :structure

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
