require 'terminal-table'
require 'kate_downloader'
module Kate

  # Provides basic user interface functionality.
  class UserInterface
    MARK = '+'

    attr_accessor :items

    def initialize(items)
      @items = items
    end

    # Abstract method
    def actions
      raise NotImplementedError
    end

    def run
      print_table
      input = prompt
      perform_action(input)
    end

    def perform_action(input)
      case input
      when /(\d+)/
        index = input.to_i
        if items[index]
          if items[index][:marked] == MARK
            items[index][:marked] = ''
          else
            items[index][:marked] = MARK
          end
        end
        run
      when /d/i
        download_marked_items
      when /x/i
        exit
      end
    end

    def marked_items
      items.select { |i| i[:marked] }
    end

    def download_marked_items
      Downloader.new(marked_items).start_download
    end

    private

    def columns
      [
        { :name => "", :align => :right },
        { :name => MARK, :attribute => :marked },
        { :attribute => :title },
        { :attribute => :size, :align => :right },
        { :attribute => :seeds, :align => :right },
        { :attribute => :leeches, :align => :right },
      ]
    end

    def headings
      columns.map { |col| col[:name] || col[:attribute].to_s.capitalize }
    end

    def item_list
      list = items.each_with_index.map do |result, index|
        columns.map do |column|
          if (attribute = column[:attribute])
            value = result[attribute]
          else
            value = index
          end
          value = value.to_s
          value = truncate(value) if value.length > 70
          { :value => value, :alignment => column[:align] }
        end
      end
      list
    end

    def truncate(string)
      string.slice(0, 70).gsub(/\s\w+\s*$/, '...')
    end

    def table
      return "No Items to display" unless items
      Terminal::Table.new(
        :headings => headings,
        :rows => item_list
      )
    end

    def print_table
      system 'clear'
      STDOUT.puts table
    end

    def prompt
      print "\nmark items by their number, then [d]ownload or e[x]it\n> "
      STDIN.gets.chomp
    end
  end
end
