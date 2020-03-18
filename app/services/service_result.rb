# frozen_string_literal: true

class ServiceResult
  attr_accessor :message, :status, :data

  def initialize(message, status, data)
    @message = message
    @status = status
    @data = data
  end

  def success?
    status == true
  end

  class << self
    def let_success(message = nil, data = nil)
      ServiceResult.new(message, true, data)
    end

    def let_fail(message = nil, data = nil)
      ServiceResult.new(message, false, data)
    end
  end
end
