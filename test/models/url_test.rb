require "test_helper"

class UrlTest < ActiveSupport::TestCase
  test "fixture is valid" do
    url = urls(:one)

    assert url.valid?
    assert url.save!
  end

  test "short_code cannot be null" do
    url = urls(:one)
    url.short_code = nil

    assert url.invalid?
  end

  test "long_url cannot be null" do
    url = urls(:one)
    url.long_url = nil

    assert url.invalid?
  end

  test "short_code should be unique" do
    existing_url = urls(:one)
    existing_url.save
    new_url = Url.new(short_code: existing_url.short_code, long_url: "http://duplicate.com")

    exception = assert_raise(ActiveRecord::RecordNotUnique) { new_url.save! }
    assert_match(/duplicate key value violates unique constraint \"urls_pkey\"/, exception.message)
  end
end
