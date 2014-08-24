require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/lazy_load_hooks'
require 'artificer/registry'
require 'artificer/version'

module Artificer
  cattr_accessor :registry
  self.registry = Registry.new

  def self.blueprint_dir
    registry.blueprint_dir
  end

  def self.blueprint_dir=(path)
    registry.blueprint_dir = path
  end

  def self.fetch_blueprint(name)
    registry.fetch(name)
  end

  def self.define_blueprint(name, block)
    registry.define(name, block)
  end
end

ActiveSupport.on_load(:active_record) do
  require 'artificer/model'
  ActiveRecord::Base.extend(Artificer::Model)
end
