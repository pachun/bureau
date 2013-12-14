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

      # test - structure is an array
      if format[:structure].class != Array
        StructureError.structure_must_be_array
      end

      # test - each section is a hash
      format[:structure].each do |section|
        if section.class != Hash
          StructureError.bad_section(section)
        else

          # test - :drawers is an array
          drawer_list = section[:drawers]
          unless drawer_list.nil?
            if drawer_list.class != Array
              StructureError.bad_drawer_list(drawer_list)
            else

              # test - each drawer is a hash
              drawer_list.each do |drawer|
                if drawer.class != Hash
                  StructureError.bad_drawer(drawer)
                end
              end
            end
          end
        end
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
