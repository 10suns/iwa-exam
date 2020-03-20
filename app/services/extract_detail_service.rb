# frozen_string_literal: true

require 'open-uri'

class ExtractDetailService < ApplicationService
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def execute
    data = Readability::Document.new(source.read).content
    ServiceResult.let_success('Extract successfully', data)
  end

  private

  def source
    @source ||= URI.parse(url).open
  end
end
