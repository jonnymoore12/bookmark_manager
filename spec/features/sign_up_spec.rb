require 'capybara/rspec'

feature 'Sign up' do

  scenario 'user count increases when a user signs up' do
    expect{ sign_up }.to change(User, :count).by 1
    expect(page).to have_content "Welcome, RoiRoi@gmail.com"
    expect(User.first.email).to eq "RoiRoi@gmail.com"
  end

  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_repeat: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq '/users/new'
    expect(page).to have_content 'Password digest does not match the confirmation'
  end

  scenario 'user cannot sign up without an email address' do
    expect { sign_up(email:"") }.not_to change(User, :count)
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'user cannot sign up with an invalid email address' do
      expect { sign_up(email: 'email@wrong') }.not_to change(User, :count)
      expect(page).to have_content 'Email has an invalid format'
  end

  scenario 'user cannot sign up with an existing email address' do
    sign_up(email: 'pogba@manchesterunited.com')
    expect{ sign_up(email: 'pogba@manchesterunited.com') }.not_to change(User, :count)
    expect(page).to have_content 'Email is already taken'
  end
end
