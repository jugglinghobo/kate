module Kate
  module UserInterfaceMethods
    def displayed_columns
      raise "MethodNotImplemented: displayed_columns"
    end

    def available_actions
      raise "MethodNotImplemented: available_actions"
    end

    class Column
      attr_accessor :index, :title, :method, :alignment
      def initialize(index, method, options = {})
        @index = index
        @method = method
        @title = options.fetch :title, method.to_s.capitalize
        @alignment = options.fetch :alignment, :left
      end
    end
  end
end
