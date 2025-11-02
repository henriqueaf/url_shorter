require "test_helper"

class UrlTest < ActiveSupport::TestCase
  test "fixture is valid" do
    url = build(:url)
    assert url.save!
  end

  test "long_url cannot be null" do
    url = build(:url, long_url: nil)

    assert url.invalid?
    assert_includes url.errors[:long_url], "can't be blank"
  end

  test "short_code is generated before validation" do
    new_url = build(:url, short_code: nil)
    assert new_url.save!
    assert new_url.short_code.present?
  end

  test "short_code should be unique" do
    existing_url = create(:url)
    new_url = build(:url, short_code: existing_url.short_code)

    exception = assert_raise(ActiveRecord::RecordNotUnique) { new_url.save! }
    assert_match(/duplicate key value violates unique constraint \"urls_pkey\"/, exception.message)
  end
end
