# frozen_string_literal: true

require 'open-uri'

class ExtractNewsListService < ApplicationService
  attr_reader :url

  News = Struct.new(:link, :title)

  def initialize(url)
    @url = url
  end

  def execute
    articles = list_items.map { |e| News.new(get_link(e.attributes['href'].value), e.content) }
    data = { link_next_page: link_next_page, articles: articles }
    ServiceResult.let_success('Extract successfully', data)
  end

  private

  def source
    @source ||= Nokogiri::HTML(URI.parse(url).open)
  end

  def list_items
    @list_items ||= source.xpath('//tr[@class="athing"]/td[@class="title"]/a')
  end

  def link_next_page
    attributes = source.xpath('//a[@class="morelink"]').first.try(:attributes)
    @link_next_page ||= attributes.nil? ? nil : get_link(attributes.try(:[], 'href').value)
  end

  def news_list
    @news_list ||= []
  end

  def get_link(link)
    ::URI.parse(link).host.present? ? link : "https://news.ycombinator.com/#{link}"
  end
end
