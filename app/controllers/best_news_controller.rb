# frozen_string_literal: true

class BestNewsController < ApplicationController
  def index
    render 'layouts/application'
  end

  def news
    result = ExtractNewsListService.execute(fetch_url)
    json = if result.success?
             { success: true, data: result.data }
           else
             { success: false }
           end
    render json: json
  end

  def preview
    result = ExtractPreviewService.execute(params[:url])
    json = if result.success?
             { success: true, data: result.data }
           else
             { success: false }
           end
    render json: json
  end

  def detail
    result = ExtractDetailService.execute(params[:url])
    json = if result.success?
             { success: true, data: result.data }
           else
             { success: false }
           end
    render json: json
  end

  private

  def fetch_url
    URI::HTTPS.build(host: "news.ycombinator.com", path: "/best", query: { p: params[:page]}.to_query).to_s
  end
end
