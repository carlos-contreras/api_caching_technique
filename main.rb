def require_all(_dir)
  Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each do |file|
      require file
  end
end

require 'pry'
require_all('./src')

# DEPENDENCIES: redis gem, faker gem 
# RUN THIS FILE WITH
# ruby .\main.rb

class Main
  # Given a page(int) an a per_page(int (from 10  to 100)) return the cached items
  # If there are no cached items, try to fetch them from the API
  # If the api response with no more items then return the available results
  def self.call(key, page = 0, per_page = 10)
    instance = new(key)
    cached_records = []
    i = 0

    loop do
      cached_records = instance.cache.get_recorsds(per_page, (page * per_page))
      break if cached_records.length == per_page
      api_response = ApiMock.call(page, per_page)
      break if api_response.empty?
      filtered_items = ApiFilter.call(api_response)
      instance.cache.save_records(filtered_items)
      break if api_response.length < per_page
      i += 1
      print '.'
      break if i > 100
    end
    puts ''
    cached_records
  end

  attr_reader :key

  def initialize(key)
    @key = key
  end

  def cache
    ApiResponseCache.new(key)
  end
end

Redis.new.del('test-key')

puts Main.call('test-key', 10, 15).inspect
