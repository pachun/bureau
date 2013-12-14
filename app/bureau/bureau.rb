module Bureau
  class Bureau < UIViewController
    attr_accessor :table

    def init
      InitializationError.need_hash
    end

    def initialize(format)
      unless format.has_key? :structure
        InitializationError.need_structure_key
      end

      if format[:structure].class != Array
        StructureError.structure_must_be_array
      end

      format[:structure].each do |section|
        StructureError.sections_must_be_hashes(section) if section.class != Hash
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

    def tableView(_, numberOfRowsInSection:_)
      0
    end

    def tableView(_, cellForRowAtIndexPath:_)
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault,
                                          reuseIdentifier: BureauCell)
    end
  end
end

module Bureau
  class BureauCell; end
end
