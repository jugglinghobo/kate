require 'terminal-table'
module Kate
  class UserInterface
    attr_accessor :items, :columns, :table, :actions

    def initialize(items, columns, actions = default_actions)
      @items = items
      @columns = columns.sort_by &:index
      @table = initialize_table
      @actions = actions
    end

    def run
      loop do
        print_table
        input = prompt
      end
    end

    private

    def headings
      columns.map(&:title).unshift ""
    end

    def print_table
      system 'clear'
      STDOUT.puts table
    end

    def initialize_table
      @table = Terminal::Table.new(
        :headings => headings,
        :rows => item_rows
      )
      columns.each do |column|
        table.align_column column.index, column.alignment
      end
      table
    end

    def item_rows
      items.each_with_index.map do |item, index|
        columns.map { |column| item.send(column.method) }.unshift(index)
      end
    end

    def prompt
      print "#{actions.values.join ", "}: "
      STDIN.gets.chomp
    end

    def default_actions
      {}
    end
  end

end
