require 'yaml'
class ApiData
    include HTTParty
    configs = YAML.load_file('config/data_connection.yml').with_indifferent_access
    base_uri "#{configs[:URL]}"
    http_proxy(configs[:proxy][:URL],configs[:proxy][:port],configs[:proxy][:username],configs[:proxy][:password]) if configs[:use_proxy]

    def get_data
        self.class.get("")
    end
end
