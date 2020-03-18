# frozen_string_literal: true

require 'open-uri'

class ExtractNewsListService < ApplicationService
  attr_reader :url

  News = Struct.new(:link, :title)

  def initialize(url)
    @url = url
  end

  def execute
    doc.each do |e|
      news_list << News.new(get_link(e.attributes['href'].value), e.content)
    end
    ServiceResult.let_success('Extract successfully', news_list)
  end

  private

  def doc
    @doc = Nokogiri::HTML(URI.parse(url).open).xpath('//tr[@class="athing"]/td[@class="title"]/a')
  end

  def news_list
    @news_list ||= []
  end

  def get_link(link)
    ::URI.parse(link).host.present? ? link : "https://https://news.ycombinator.com/#{link}"
  end
end
