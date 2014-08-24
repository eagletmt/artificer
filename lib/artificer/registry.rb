require 'artificer/blueprint'

module Artificer
  class Registry
    attr_accessor :blueprint_dir

    def initialize
      @blueprints = {}
      @blueprint_dir = nil
    end

    def fetch(name)
      @blueprints[name] || create(name)
    end

    def define(name, block)
      @blueprints[name] = evaluate_blueprint(block)
    end

    private

    def create(name)
      load_blueprint(name)
      unless @blueprints.has_key?(name)
        raise ConfigurationError.new("#{blueprint_path(name)} is loaded but not defined by #{name}.blueprint")
      end
      @blueprints[name]
    end

    def load_blueprint(name)
      path = blueprint_path(name)
      load path
    rescue LoadError
      raise ConfigurationError.new("Cannot load blueprint file for #{name}: #{path}")
    end

    def blueprint_path(name)
      "#{File.join(blueprint_dir, name.underscore)}.rb"
    end

    class Recorder
      attr_reader :__attributes__

      def initialize
        @__attributes__ = {}
      end

      def respond_to_missing?(method_name, include_private = false)
        true
      end

      def method_missing(method_name, *args, &block)
        unless args.empty?
          raise ArgumentError.new("#{method_name}: wrong number of arguments (#{args.size} for 0)")
        end
        unless block
          raise ArgumentError.new("#{method_name}: no block given")
        end
        @__attributes__[method_name] = block
      end
    end

    def evaluate_blueprint(block)
      recorder = Recorder.new
      recorder.instance_eval(&block)
      Blueprint.new(recorder.__attributes__)
    end
  end
end
