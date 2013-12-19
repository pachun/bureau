module Bureau
  class InitializationError < StandardError
    def self.need_hash
      raise(self, "Bureau.new({}) requires a hash on initialization")
    end

    def self.need_structure_key
      raise(self, "Bureau.new({})'s initialization hash requires a :structure key")
    end
  end

  class StructureError < StandardError
    def self.structure_must_be_array
      raise(self, "structure must be an array")
    end

    def self.bad_section(non_hash_section)
      non_hash_section = non_hash_section.to_s
      raise(self,
        "structures can only contain hashes (one for each table section) (#{non_hash_section}.class != Hash)")
    end

    def self.bad_drawer_list(non_array_drawer_list)
      non_array_drawer_list = non_array_drawer_list.to_s
      raise(self,
        "a section's :drawers key must have an array value if it is present (#{non_array_drawer_list}.class != Array)")
    end

    def self.bad_drawer(non_hash_drawer)
      non_hash_drawer = non_hash_drawer.to_s
      raise(self, 
        "all elements of section[:drawers] must be a hash (each representing a menu row) (#{non_hash_drawer}.class != Hash)")
    end
  end
end

