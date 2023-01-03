class SearchController<ApplicationController
    def search
        puts params[:search]
        
        #test=["title", "body"]
        #@results=Post.search(test,fields: ["title", "body"])

        queries = []
        #test = []
        #test.push(params:search)
        #test.push("software")
        test=[params[:search]]
        puts test
        
        test.each do |value|
            print value+"*** FROM ARRAY**\n"
            queries.push({
              match:
                {
                  "title":
                    {
                      query: value,
                      boost: 10,
                      operator: "and",
                      analyzer: "synonym_analyzer_keyword_updateable"
                    }
                }
            })
        end
        where_filters = Searchkick::Query.new(Post).send(:where_filters, params)
        query_filters = {
          query: {
            
                bool: {
                  should: [
                    {
                      dis_max: {
                        queries: queries
                      }
                    }
                  ]
                }
              
          },
          size: 1234
        }

        #puts (query_filters)
        print(where_filters)
        



        #@results=query_filters
        @results =Post.search(body:query_filters)
        print "Hello ------------"
        @results.each do |post|
            print "Inside ------------" 
            print post.title
        end   
        


       # render turbo_stream:
        #    turbo_stream.update('posts',
        #                        partial:'posts/posts',
        #                        locals:{posts:@results})

    end
end