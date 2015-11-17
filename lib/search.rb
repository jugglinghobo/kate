require 'kat'

module Kate
  class Search

    include Kate::UserInterface::Components
    include Kate::UserInterface::Actions

    attr_accessor :interest, :category, :results

    def initialize(interest, options)
      @interest = interest
      @category = options.fetch :category, :movies
    end

    def perform
      kat = Kat.search interest, :category => category
      kat.search
      @results = kat.results[0].map { |result| Kate::SearchResult.new(result) }
    end

    def displayed_columns
      [
        Column.new(1, :title),
        Column.new(2, :size, :alignment => :right),
        Column.new(3, :seeds, :alignment => :right),
        Column.new(4, :leeches, :alignment => :right)
      ]
    end

    def available_actions
      [
        UserInterface::Actions::Save,
        UserInterface::Actions::Download
      ]
    end
  end

  class SearchResult

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

    def to_s
      "#{title}|#{size}|#{seeds}|#{leeches}"
    end
  end
end
