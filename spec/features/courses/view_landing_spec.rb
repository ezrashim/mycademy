require 'rails_helper'

feature 'anyone visiting a root_path will view the landing page', %{
  As an anonymous user,
  I should be able to view the landing page,
  So I can learn what Mycademy is all about.
} do
  # ACCEPTANCE CRITERIA
  # * As an anonymous user, I can view the landing page upon visitng root path.

  scenario 'user can view the landing page' do
    visit root_path

    expect(page).to have_content("Welcome to Mycademy")
    expect(page).to have_css('#join-mycademy')
  end
end
