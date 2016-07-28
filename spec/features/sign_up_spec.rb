require "web_helper"

feature "signing up" do
  scenario "signing up as a new user" do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, example@email.com")
    user = User.first
    expect(user.email).to eq("example@email.com")
  end
end
