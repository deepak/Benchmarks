require 'yaml'

config = YAML.load_file(File.expand_path('../gupshup.yml', __FILE__))["development"]
Kernel.const_set(:WEBSITE_URL_YAML, config["website_url"])
