require 'test_helper'

class HackerFlowsTest < ActionDispatch::IntegrationTest
  setup do
    login :jorge
  end

  test "jorge claim that he played with tdd" do
    assert has_content? 'jorge'

    within 'tbody tr', text: 'tdd' do
      assert has_content? 'competent'
      click_on 'claim'
    end

    assert has_content?('Now you know tdd'), 'display a flash message'

    within 'tbody' do
      refute has_content? 'tdd'
    end
  end

  test "jorge wants to see other hacker dashboard" do
    click_link 'HACKERS LIST'
    click_link 'rodrigo'

    assert has_content? 'rodrigo'

    within 'tbody tr', text: 'tdd' do
      assert has_content? 'beginner'
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
