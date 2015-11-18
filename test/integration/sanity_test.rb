require 'test_helper'

class SanityTest < ActiveSupport::TestCase
  test "seeds can be run" do
    load Rails.root.join('db', 'seeds.rb')
  end

  test "fixtures are valid" do
    models = ActiveRecord::Base.descendants
    refute_empty models
    models.each do |model|
      next if model.name == 'ActiveRecord::SchemaMigration'
      model.find_each do |m|
        assert m.valid?, "#{ m.inspect } is invalid"
      end
    end
  end
end
