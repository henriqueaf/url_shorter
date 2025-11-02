redis_host = ENV.fetch('URL_SHORTER_REDIS_HOST') || 'redis'
redis_port = ENV.fetch('URL_SHORTER_REDIS_PORT') || 6379

REDIS = Redis.new(host: redis_host, port: redis_port.to_i)
