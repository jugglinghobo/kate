module Kate
  class SearchInterface
    include UserInterface


    attr_accessor :search, :results

    def initialize(search)
      @search = search
      @results = search.results
    end

    def headings
      columns.map { |col| col[:name] || col[:attribute].to_s.capitalize }
    end

    def columns
      [
        {:name => "No.", :align => :right},
        {:attribute => :title},
        {:attribute => :size, :align => :right},
        {:attribute => :seeds, :align => :right},
        {:attribute => :leeches, :align => :right}
      ]
    end

    def result_rows
      results.each_with_index.map do |result, index|
        columns.map do |column|
          if (attribute = column[:attribute])
            value = result[attribute]
          else
            value = index
          end
          { :value => value, :alignment => column[:align] }
        end
      end
    end

    def actions
      [Actions::Save, Actions::Download]
    end

    def table
      @table ||= Terminal::Table.new(
        :headings => headings,
        :rows => result_rows
      )
    end
  end

  class Result

    ATTRIBUTES = [
      :title,
      :path,
      :size,
      :magnet,
      :download,
      :files,
      :age,
      :seeds,
      :leeches
    ]

    attr_accessor *ATTRIBUTES

    def initialize(args = {})
      ATTRIBUTES.each { |attr| self.send("#{attr}=", args.fetch(attr)) }
    end

    def to_row
      []
    end

    def to_s
      "#{title}|#{size}|#{seeds}|#{leeches}"
    end
  end
end
