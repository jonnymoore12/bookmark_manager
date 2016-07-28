require "web_helper"

# We don't actually test that password matches confirmation:
feature "Signing up" do
  scenario "signs up a new user with passwords entered correctly" do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, example@email.com")
    user = User.first
    expect(user.email).to eq("example@email.com")
  end

  scenario "no new users created for mismatching passwords" do
    expect { sign_up(password_confirmation: 'wrong_pasword') }.not_to change(User, :count)
  end
end
