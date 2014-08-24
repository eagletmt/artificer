module DatabaseHelper
  class Migration < ActiveRecord::Migration
    def change
      create_table :books do |t|
        t.string :title, null: false
        t.integer :page_count, null: false
        t.references :publisher, null: false
        t.timestamps
        t.index :publisher_id
      end

      create_table :publishers do |t|
        t.string :name
        t.timestamps
      end
    end
  end

  module_function

  def setup
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
    Migration.migrate(:up)
  end
end
