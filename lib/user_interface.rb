require 'terminal-table'
require 'user_interface_actions'
module Kate

  # Provides basic user interface functionality.
  module UserInterface

    def run
      loop do
        print_table
        input = prompt
        Actions.perform(input)
      end
    end

    def table
      raise NotImplementedError
    end

    def actions
      raise NotImplementedError
    end

    private

    def print_table
      system 'clear'
      STDOUT.puts table
    end

    def prompt
      print "#{available_actions.map(&:to_s).join(", ")}: "
      STDIN.gets.chomp
    end

    def available_actions
      actions | default_actions
    end

    def default_actions
      [Actions::Exit]
    end
  end


end
