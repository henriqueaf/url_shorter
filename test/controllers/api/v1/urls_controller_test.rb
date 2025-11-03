require "test_helper"

class Api::V1::UrlsControllerTest < ActionDispatch::IntegrationTest
  # CREATE action tests
  test "successfully creates a URL" do
    post api_v1_urls_path, params: { url: "https://www.example.com/some/long/path" }

    assert_response :created
    assert_queries_count(1) { Url.count }

    json_response = JSON.parse(@response.body)
    created_url = Url.last
    assert_match %r{http://www.example.com/#{created_url.short_code}}, json_response["short_url"]
  end

  test "fails to create a URL with url parameters blank" do
    post api_v1_urls_path, params: { url: "" }

    assert_response :bad_request
  end

  # REDIRECT action tests
  test "successfully redirects to the long_url attribute" do
    url = create(:url, long_url: "https://www.example.com/some/long/path")

    get redirect_url_path(short_code: url.short_code)

    assert_response :found
    assert_equal "https://www.example.com/some/long/path", response.location
  end

  test "returns 404 for non-existent short code" do
    get redirect_url_path(short_code: "nonexistent")

    assert_response :not_found
    json_response = JSON.parse(@response.body)
    assert_equal "URL not found", json_response["error"]
  end
end
