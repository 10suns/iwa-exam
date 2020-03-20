# frozen_string_literal: true

require 'open-uri'

class ExtractDetailService < ApplicationService
  attr_reader :uri

  def initialize(url)
    @uri = URI(url)
    @uri = URI::HTTP.build(host: @uri.to_s) if @uri.instance_of?(URI::Generic)
  end

  def execute
    data = Readability::Document.new(source.read).content
    ServiceResult.let_success('Extract successfully', data)
  end

  private

  def source
    @source ||= uri.open
  end
end
