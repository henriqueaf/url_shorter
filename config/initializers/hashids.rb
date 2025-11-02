hashids_salt = ENV.fetch("HASHIDS_SALT") { "hashids_secret_key" }
hashids_min_length = ENV.fetch("HASHIDS_MIN_LENGTH") { 4 }.to_i
hashids_alphabet = ENV.fetch("HASHIDS_ALPHABET") { "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" }

HASHIDS = Hashids.new(hashids_salt, hashids_min_length, hashids_alphabet)
