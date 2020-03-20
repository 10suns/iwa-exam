# frozen_string_literal: true

module Concerns::BuildUrl
  extend ActiveSupport::Concern

  def build_uri(str, **options)
    str = CGI.escape(str)
    uri = URI(str)
    return uri unless uri.instance_of?(URI::Generic)

    partitions = str.partition('/')
    host = options[:host] || partitions.first
    path = adjust_path(options[:host].present? ? partitions.last : str)
    URI::HTTP.build(host: host, path: path)
  end

  private

  def adjust_path(str)
    str[0] == '/' ? str : str.insert(0, '/')
  end

  def uri(str); end
end
