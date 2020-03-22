# frozen_string_literal: true

require 'open-uri'

class ExtractDetailService < ApplicationService
  include Concerns::BuildUrl

  attr_reader :uri

  def initialize(url)
    @uri = build_uri(url)
  end

  def execute
    data = { content: readability.content, title: title, image: image }
    ServiceResult.let_success('Extract successfully', data)
  end

  private

  def image
    Rails.cache.fetch("#{uri}_image", expires_in: 3.hour) do
      return default_image unless doc.present?

      url = doc.xpath('//meta[@property="og:image"]').first.try(:[], 'content')
      # decode url to avoid messing with # character
      url.present? ? URI.decode(build_uri(url, host: uri.host).to_s) : default_image
    end
  end

  def title
    Rails.cache.fetch("#{uri}_title", expires_in: 3.hour) do
      return unless doc.present?

      doc.xpath('//head/title').first.content
    end
  end

  def readability
    @readability ||= Readability::Document.new(source.read)
  end

  def doc
    @doc ||= Nokogiri::HTML(uri.open)
  end

  def source
    @source ||= uri.open
  end
end
