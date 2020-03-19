# frozen_string_literal: true

require 'open-uri'

class ExtractPreviewService < ApplicationService
  attr_reader :url

  Preview = Struct.new(:link, :image, :excerpt)

  def initialize(url)
    @url = url
  end

  def execute
    preview = Preview.new(url, image, excerpt)
    ServiceResult.let_success('Extract successfully', preview)
  end

  private

  def doc
    @doc ||= Nokogiri::HTML(URI.parse(url).open)
  end

  def excerpt
    doc.xpath('//meta[@property="og:description"]').first["content"]
  end

  def image
    doc.xpath('//meta[@property="og:image"]').first["content"]
  end
end
