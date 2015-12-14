require 'yaml'
module Kate
  class FileStore
    HOME = Dir.home
    FILE_PATH = "#{HOME}/.kate/list.yml"

    def self.load(options = {})
      YAML.load_file(FILE_PATH).values.each do |hash|
        hash.keys.each do
          |key| hash[key.to_sym] = hash.delete(key)
        end
      end
    end

    # writes a single entry to the list
    def self.write(list_item)
      items = self.load
      items[items.size + 1] = list_item
      File.open(FILE_PATH, 'w') do |file|
        file.write items.to_yaml
      end
    end
  end
end
