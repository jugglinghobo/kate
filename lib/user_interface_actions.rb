module Kate
  module UserInterface
    module Actions

      class Base

        attr_reader :results

        def initialize(results = nil)
          @results = results
        end

        def perform(args)
          if !args
            STDOUT.puts "You must specify an item"
            return
          end
        end

        def to_s
          name.sub /#{identifier}/, "[#{identifier}]"
        end

        def name
          self.class.name.gsub(/^.*::/, '').downcase
        end

      end

      class Save < Base
        FILE_PATH = "/Users/simon/Desktop/list.txt"
        def identifier
          "s"
        end

        def perform(args)
          super
          File.open FILE_PATH, 'a' do |f|
            f.write args
          end
        end
      end

      class Download < Base
        def identifier
          "d"
        end

        def perform(args)
          super
        end
      end

      class Reload < Base
        def identifier
          'r'
        end

        def perform(args)
          super
        end
      end

      class Exit < Base
        def identifier
          "x"
        end

        def perform(args)
          exit
        end
      end
    end
  end
end
