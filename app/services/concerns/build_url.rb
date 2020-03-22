# frozen_string_literal: true

module Concerns::BuildUrl
  extend ActiveSupport::Concern

  def build_uri(str, **options)
    str = URI.encode(str)
    uri = URI(str)
    return uri unless uri.instance_of?(URI::Generic)

    host = options[:host]
    path = adjust_path(str)
    URI::HTTP.build(host: host, path: path)
  end

  private

  def adjust_path(str)
    str[0] == '/' ? str : str.insert(0, '/')
  end
end
