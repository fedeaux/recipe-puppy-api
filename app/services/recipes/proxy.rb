# Services::Recipes::Proxy.new()

module Services
  module Recipes
    class Proxy
      def fetch(query, pages: 2)
        results = []

        pages.times do |page|
          thread = Thread.new do
            result = HTTParty.get recipe_puppy_url(query, page + 1)
            results.push JSON.parse(result.body)['results']
          end

          thread.join
        end

        results.flatten
      end

      def recipe_puppy_url(query, page)
        params = { q: query, p: page }
        "http://www.recipepuppy.com/api?#{params.to_param}"
      end
    end
  end
end
