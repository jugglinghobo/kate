module Kate
  class Downloader
    HOME = "#{Dir.home}/.kate"
    LOG_PATH = "#{HOME}/downloads.log"
    DOWNLOADS_PATH = "~/Downloads"

    attr_reader :items

    def initialize(items)
      @items = items
      unless system('which aria2c')
        puts "please install aria2 first:\nbrew install aria2"
        exit
      end
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
        " -l #{LOG_PATH}" \
        " -d #{DOWNLOADS_PATH} #{item[:magnet]}"
    end
  end
end
