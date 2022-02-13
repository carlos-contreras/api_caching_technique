require 'redis'

# RUN REDIS SERVICE WITH:
# docker run -d -p 6379:6379 --name redis redis:latest

class ApiResponseCache
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def get_recorsds(size, offset)
    data = redis.lrange(key, offset, offset + size - 1)
    data.map { |d| JSON.parse(d) }
  end

  def save_records(records)
    redis.rpush(key, records.map(&:to_json))
  end

  private

  def redis
    @redis = Redis.new
  end
end
