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

    def self.sections_must_be_hashes(not_a_hash)
      not_a_hash = not_a_hash.to_s
      raise(self, 
        "structures can only contain hashes (one for each table section) (#{not_a_hash}.class != Hash)")
    end
  end
end

