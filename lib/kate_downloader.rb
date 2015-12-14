module Kate
  class Downloader
    attr_reader :items

    def initialize(items)
      @items = items
    end

    def start_download
      system 'clear'
      STDOUT.puts 'beginning download'
      items.each do |item|
        download(item)
      end
    end

    def download(item)
      system "aria2c" \
        " --seed-time=0" \
        " -l /Users/simon/.kate/downloads.log" \
        " -d /Users/simon/Downloads #{item[:magnet]}"
    end
  end
end
