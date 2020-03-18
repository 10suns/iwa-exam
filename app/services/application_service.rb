# frozen_string_literal: true

class ApplicationService
  def initialize(*args, &block); end

  def execute
    raise NotImplementedError
  end

  def self.execute(*args, &block)
    service = new(*args, &block)
    service.execute
  end
end
