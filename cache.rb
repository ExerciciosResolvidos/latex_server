require "redis"
require "yaml"
require 'digest/sha1'


class Cache

  def initialize env
    @redis = Redis.new( YAML::load_file("./config/redis.yaml")[env] )
  end

  def get key
    @redis.get Digest::SHA1.hexdigest(key)
  end

  def set key, value, seconds=60*60*24
    puts @redis.setex Digest::SHA1.hexdigest(key), seconds, value
  end
end