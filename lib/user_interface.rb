require 'terminal-table'
require 'user_interface_actions'
module Kate

  # Provides basic user interface functionality.
  module UserInterface

    def run
      loop do
        print_table
        input = prompt
        perform_action(input)
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

    def perform_action(input)
      identifier, args = input.split " "
      action = available_actions.find { |action| action.identifier == identifier }
      if action
        action.perform(args)
      else
        print_table
      end
    end

    def available_actions
      actions | default_actions
    end

    def default_actions
      [Actions::Exit.new]
    end
  end


end
