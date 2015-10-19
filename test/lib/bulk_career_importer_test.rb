require 'test_helper'
require 'bulk_career_importer'

class BulkCareerImporterTest < ActiveSupport::TestCase

  test 'create a new career with the given name' do
    BulkCareerImporter.new('DevOps', '')
    assert_equal 3, Career.count
    assert_equal 'dev_ops', Career.last.name
  end

  test 'overwrite an existing career with that name' do
    BulkCareerImporter.new('ruby', '')
    assert_equal 2, Career.count
  end

  test 'adds the given requirements to the career' do
    BulkCareerImporter.new('ruby', <<-CSV.strip_heredoc)
       tdd,0,1,2,3,3,4,5,5,5,5
       CSV
    built_requirements = careers(:ruby).requirements
      .where(skill: skills(:tdd))
    assert_equal 6, built_requirements.size
  end

  test 'bulk upload with a missing skill will change nothing' do
    BulkCareerImporter.new('ruby', <<-CSV.strip_heredoc)
       tdd,0,1,2,3,3,4,5,5,5,5
       invalid,0,1,2,3,3,4,5,5,5,5
       CSV
    assert_equal 1, careers(:ruby).requirements.size
  end

  test 'bulk upload with a missing skill have errors' do
    bulk = BulkCareerImporter.new('ruby', <<-CSV.strip_heredoc)
       tdd,0,1,2,3,3,4,5,5,5,5
       scrumming,0,1,2,3,3,4,5,5,5,5
       CSV
    assert_equal 1, careers(:ruby).requirements.size
    assert_includes bulk.errors.full_messages,
      'Requirements includes non existing skill "scrumming"'
  end

end