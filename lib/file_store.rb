require 'yaml'
module Kate
  class FileStore
    HOME = "#{Dir.home}/.kate/"
    FILE_PATH = "#{HOME}/list.yml"

    def self.load(options = {})
      YAML.load_file(FILE_PATH).each do |hash|
        hash.keys.each do
          |key| hash[key.to_sym] = hash.delete(key)
        end
      end
    end

    # writes a single entry to the list
    def self.write(list_item)
      items = self.load
      items << list_item
      File.open(FILE_PATH, 'w') do |file|
        file.write items.to_yaml
      end
    end
  end
end
