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
    'https://news.ycombinator.com/best'
  end
end
