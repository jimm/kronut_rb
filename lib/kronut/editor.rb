module Kronut
  class Editor
    def initialize(format)
      @format = format
    end

    def load_set_list(path)
      set_list = SetList.new
      IO.readlines(path) do |line|
      end
      set_list
    end

    def save_set_list(n, path)
    end
  end
end
