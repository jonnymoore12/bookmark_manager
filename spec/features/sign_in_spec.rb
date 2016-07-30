require 'capybara/rspec'

feature 'Sign in' do

  let!(:user) do
    User.create(email: "RoiRoi@gmail.com",
                password: 'secret1234',
                password_repeat: 'secret1234')
  end

  scenario 'User signs with correct credentials' do
    sign_in(email: user.email, password: user.password)
    expect(current_path).to eq '/links'
    expect(page).to have_content "Welcome, #{user.email}"
  end

  def sign_in(email:, password:)
    visit '/users/login'
    fill_in 'email', with: email
    fill_in 'password', with: password
    click_button 'Sign in'
  end

end
