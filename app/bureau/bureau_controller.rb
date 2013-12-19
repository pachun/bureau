module Bureau
  module Controller
    attr_accessor :bureau

    def toggle_bureau
      @bureau.toggle_menu_state
    end
  end
end
