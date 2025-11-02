require "test_helper"

class GenerateUrlShortcodeTest < ActiveSupport::TestCase
  test "generates a unique short code" do
    short_code = UrlServices::GenerateUrlShortcode.call

    assert short_code.is_a?(String)
    assert_not_empty short_code
    assert short_code.length >= 4
  end
end
