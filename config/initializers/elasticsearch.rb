ENV["ELASTICSEARCH_URL"] = "http://admin:admin@localhost:9200"

##SEARCHKICK_OPTIONS = YAML.load_file("config/searchkick.yml")[Rails.env].deep_symbolize_keys.with_indifferent_access