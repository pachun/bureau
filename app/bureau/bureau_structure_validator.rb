module Bureau
  class StructureValidator
    def self.instance
      @@instance ||= StructureValidator.new
    end

    def validate(structure)
      if structure.class != Array
        StructureError.structure_must_be_array
      end
      validate_sections(structure)
    end

    private
    def validate_sections(structure)
      structure.each do |section|
        if section.class != Hash
          StructureError.bad_section(section)
        else
          validate_drawers(section[:drawers]) unless section[:drawers].nil?
        end
      end
    end

    def validate_drawers(drawer_list)
      if drawer_list.class != Array
        StructureError.bad_drawer_list(drawer_list)
      else
        validate_each_drawer(drawer_list)
      end
    end

    def validate_each_drawer(drawers)
      # test - each drawer is a hash
      drawers.each do |drawer|
        if drawer.class != Hash
          StructureError.bad_drawer(drawer)
        end
      end
    end
  end
end
