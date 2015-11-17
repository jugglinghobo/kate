require 'terminal-table'
require 'user_interface_components'
require 'user_interface_actions'
module Kate
  class UserInterface

    attr_accessor :items, :columns, :table, :actions

    def initialize(items, columns, actions = default_actions)
      @items = items
      @columns = columns.sort_by &:index
      @table = initialize_table
      @actions = actions | default_actions
    end

    def run
      loop do
        print_table
        input = prompt
        Actions.perform(input)
      end
    end

    private

    def print_table
      system 'clear'
      STDOUT.puts table
    end

    def headings
      columns.map(&:name).unshift ""
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
      print "#{actions.map(&:to_s).join(", ")}: "
      STDIN.gets.chomp
    end

    def default_actions
      [Actions::Exit]
    end
  end


end
