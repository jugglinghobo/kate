require 'kat'

module Kate
  class Search

    attr_accessor :interest, :category

    def initialize(interest, options)
      @interest = interest
      @category = options.fetch :category, :movies
    end

    def perform
      kat = Kat.search interest, :category => category
      kat.search
      kat.results[0]
    end
  end

end
