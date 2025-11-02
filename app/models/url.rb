class Url < ApplicationRecord
  validates :short_code, :long_url, presence: true
end
