require 'artificer/configuration_error'

module Artificer
  class Blueprint
    def initialize(attributes)
      @attributes = attributes
    end

    def make
      attrs = {}
      @attributes.each do |attr, block|
        attrs[attr] = block.call
      end
      attrs
    end
  end
end
