class Url < ApplicationRecord
  validates :short_code, :long_url, presence: true

  before_validation :generate_short_code

  private

  def generate_short_code
    if short_code.blank? && long_url.present? && self.new_record?
      self.short_code = UrlServices::GenerateUrlShortcode.call(self)
    end
  end
end
