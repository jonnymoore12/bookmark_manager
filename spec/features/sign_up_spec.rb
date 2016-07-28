require "web_helper"

# We don't actually test that password matches confirmation:
feature "Signing up" do
  scenario "signs up a new user with passwords entered correctly" do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, example@email.com")
    user = User.first
    expect(user.email).to eq("example@email.com")
  end

  scenario "No new users created for mismatching passwords" do
    expect { sign_up(password_confirmation: 'wrong_pasword') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Password does not match the confirmation")
  end

  scenario "Cannot sign up without an email address" do
    expect { sign_up(email: nil) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Email must not be blank")
  end

  scenario "Cannot sign up with invalid email address" do
    expect {sign_up(email: "invalid@email") }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Email has an invalid format")
  end

  scenario "Cannot sign up with an already registered email address" do
    sign_up
    expect { sign_up }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Email is already taken")
  end
end
