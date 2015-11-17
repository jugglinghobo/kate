module Kate
  module UserInterface
    module Actions
      def self.actions
        return @actions if @actions
        descendants = ObjectSpace.each_object(Class).select { |klass| klass < Base }
        @actions = descendants.map { |klass| [klass.identifier, klass] }.to_h
      end

      def self.perform(identifier)
        actions[identifier].perform
      end

      class Base
        def self.to_s
          class_name.sub /#{identifier}/, "[#{identifier}]"
        end

        def self.class_name
          name.gsub(/^.*::/, '').downcase
        end
      end

      class Exit < Base
        def self.identifier
          "x"
        end

        def self.perform
          exit
        end
      end

      class Save < Base
        def self.identifier
          "s"
        end

        def self.perform
          require 'pry'; binding.pry
        end
      end

      class Download < Base
        def self.identifier
          "d"
        end

        def self.perform
          require 'pry'; binding.pry
        end
      end
    end
  end
end
