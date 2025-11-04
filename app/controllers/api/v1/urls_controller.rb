class Api::V1::UrlsController < ApplicationController
  def create
    original_url = params.expect(:url)
    url_object = Url.new(long_url: original_url)

    if url_object.save
      render json: { short_url: url_for(action: :redirect, short_code: url_object.short_code, only_path: false) }, status: :created
    else
      render json: { error: "Failed to create URL" }, status: :unprocessable_entity
    end
  end

  def redirect
    url = Url.find_by!(short_code: params.expect(:short_code))
    redirect_to url.long_url, allow_other_host: true, status: :found
  rescue ActiveRecord::RecordNotFound
    render json: { error: "URL not found" }, status: :not_found
  end
end
