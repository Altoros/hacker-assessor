require 'test_helper'

class HackerFlowsTest < ActionDispatch::IntegrationTest

  test "jorge wants to check what he needs to learn" do
    login :jorge

    assert has_content?(/Junior\+.*Semi-Senior/), 'seniority'

    within 'tbody tr', text: 'tdd' do
      assert has_content?('beginner'), 'current level'
      assert has_content?('competent'), 'required level'
    end
  end

  test 'Leo assess that jorge knows tdd to reach to Semi-Senior' do
    login :leo
    click_on 'HACKERS LIST'
    click_on 'jorge'
    within 'tbody tr', text: 'tdd' do
      assert has_content?('beginner'), 'current level'
      assert has_content?('competent'), 'required level'
    end
  end

  def login hacker
    visit root_path
    fill_in :email, with: hackers(hacker).email
    fill_in :password, with: hackers(hacker).name
    click_button 'SIGN IN'
    assert page.has_content? "Successfully logged in"
  end

end
