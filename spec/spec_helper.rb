require 'simplecov'

SimpleCov.start do
  add_filter File.dirname(__FILE__)
end

require 'artificer'
require 'active_record'

require 'support/database_helper'

Artificer.blueprint_dir = 'spec/blueprints'

class Book < ActiveRecord::Base
  belongs_to :publisher
end

class Publisher < ActiveRecord::Base
  has_many :books
end

class User < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
end

RSpec.configure do |config|
  config.expose_dsl_globally = false

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random
  Kernel.srand config.seed

  config.before(:suite) do
    DatabaseHelper.setup
  end
end
