require 'test_helper'

class HackerFlowsTest < ActionDispatch::IntegrationTest
  test "jorge see a table with missing skills" do
    login :jorge

    assert has_content? 'jorge'

    within 'tbody tr', text: 'tdd' do
      assert has_content? '✘'
    end
  end

  test "admin wants to see other hacker dashboard" do
    login :admin

    click_link 'rodrigo'

    assert has_content? 'rodrigo'

    within 'tbody tr', text: 'tdd' do
      assert has_content? '✘'
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
