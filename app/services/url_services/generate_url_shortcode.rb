class UrlServices::GenerateUrlShortcode
  REDIS_COUNTER_KEY = "url_shorter:counter".freeze

  def self.call
    new().call
  end

  def initialize
    @increment_number_service = REDIS
    @hashids_service = HASHIDS
  end

  def call
    counter = @increment_number_service.incr(REDIS_COUNTER_KEY)
    @hashids_service.encode(counter)
  end
end
