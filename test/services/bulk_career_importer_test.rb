require 'test_helper'

class BulkCareerImporterTest < ActiveSupport::TestCase

  def bulk_upload career_name, requirements = 'tdd,0,0,0,0,0,0,5,5,5,5'
    requirements_with_headers = [
      BulkCareerImporter::ENFORCED_HEADERS.join(','),
      requirements].join("\n")
    BulkCareerImporter.new career_name, requirements_with_headers
  end

  test 'create a new career with the given name' do
    bulk_upload 'DevOps'
    assert_equal 3, Career.count
    assert_equal 'dev_ops', Career.last.name
  end

  test 'overwrite an existing career with that name' do
    bulk_upload 'ruby'
    assert_equal 2, Career.count
  end

  test 'adds the given requirements to the career' do
    bulk_upload 'ruby', <<-CSV.strip_heredoc
       tdd,0,0,0,0,0,0,5,5,5,5
       javascript,,,1,1,1,1,1,1,1,1
       CSV
    built_requirements = careers(:ruby).requirements
    assert_equal 3, built_requirements.size
    assert_equal 2, built_requirements.where(skill: skills(:tdd)).size
    assert_equal 1, built_requirements.where(skill: skills(:javascript)).size
  end

  test 'bulk upload with a missing skill will change nothing' do
    bulk_upload 'ruby', <<-CSV.strip_heredoc
       tdd,0,1,2,3,3,4,5,5,5,5
       invalid,0,1,2,3,3,4,5,5,5,5
       CSV
    assert_equal 1, careers(:ruby).requirements.size
  end

  test 'bulk upload with a missing skill have errors' do
    bulk = bulk_upload 'ruby', <<-CSV.strip_heredoc
       tdd,0,1,2,3,3,4,5,5,5,5
       scrumming,0,1,2,3,3,4,5,5,5,5
       CSV
    assert_equal 1, careers(:ruby).requirements.size
    assert_includes bulk.errors.full_messages,
      'Requirements includes non existing skill "scrumming"'
  end

  test 'bulk upload with requirements with nils' do
    bulk_upload 'ruby', <<-CSV.strip_heredoc
       tdd,,,,1,,3,,,,
       CSV
    assert_equal 2, careers(:ruby).requirements.size
    assert_equal 3, careers(:ruby).requirements.order(:level).first[:seniority]
  end

end
