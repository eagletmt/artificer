require 'artificer/registry'

module Artificer
  module Model
    def make(attributes = {})
      blueprint = Artificer.fetch_blueprint(self.name)
      create!(blueprint.make.merge(attributes))
    end

    def blueprint(&block)
      Artificer.define_blueprint(self.name, block)
    end
  end
end
