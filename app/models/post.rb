class Post < ActiveRecord::Base
    
    # search_synonyms: "/analysis/synonyms.txt"
    print("Hello")
    puts(YAML.load_file("config/searchkick.yml")[Rails.env].deep_symbolize_keys.with_indifferent_access)
    SEARCHKICK_OPTIONS = YAML.load_file("config/searchkick.yml")[Rails.env].deep_symbolize_keys.with_indifferent_access
    puts(SEARCHKICK_OPTIONS[model_name.plural])
    #searchkick settings: SEARCHKICK_OPTIONS["Posts"]
    #print

    searchkick merge_mappings: true,settings: {
        index: {
            analysis: {
                filter: {                    
                    synonym_filter_keyword_updateable: {
                        type: "synonym",
                        synonyms_path: "analysis/synonyms.txt",
                        updateable: "true"
                    }
                    
                },
                analyzer: {                    
                    synonym_analyzer_keyword_updateable: {
                    tokenizer: "keyword",
                    filter: ["lowercase", "synonym_filter_keyword_updateable"]
                    },
                    synonym_analyzer_keyword: {
                    tokenizer: "keyword",
                    filter: ["lowercase"]
                    }
                  }
               }
        }
    },mappings: {
            properties: {
              title: { 
                type: "text",
                analyzer: "synonym_analyzer_keyword",
                search_analyzer: "synonym_analyzer_keyword_updateable"
              }
            }
    }

    
end
