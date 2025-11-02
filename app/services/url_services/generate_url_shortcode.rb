class UrlServices::GenerateUrlShortcode
  REDIS_COUNTER_KEY = 'url_shorter:counter'.freeze

  def self.call(url)
    new(url).call
  end

  def initialize(url)
    @url = url
  end

  def call
    counter = REDIS.incr(REDIS_COUNTER_KEY)
    HASHIDS.encode(counter)
  end
end
