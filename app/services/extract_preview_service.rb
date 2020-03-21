# frozen_string_literal: true

require 'open-uri'

class ExtractPreviewService < ApplicationService
  include Concerns::BuildUrl

  attr_reader :uri

  Preview = Struct.new(:link, :image, :excerpt)

  def initialize(url)
    @uri = build_uri(url)
  end

  def execute
    preview = Preview.new(uri.to_s, image, excerpt)
    ServiceResult.let_success('Extract successfully', preview)
  end

  private

  def doc
    @doc ||= Nokogiri::HTML(uri.open)
  rescue StandardError => e
    Rails.logger.error(e)
    @doc = ''
  end

  def excerpt
    return "" unless doc.present?

    doc.xpath('//meta[@property="og:description"]|//meta[@name="description"]').first.try(:[], 'content')
  end

  def image
    return default_image unless doc.present?

    url = doc.xpath('//meta[@property="og:image"]').first.try(:[], 'content')
    # decode url to avoid messing with # character
    url.present? ? URI.decode(build_uri(url, host: uri.host).to_s) : default_image
  end

  def default_image
    ActionController::Base.helpers.asset_path('default-hacker-news.png')
  end
end
