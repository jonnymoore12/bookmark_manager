require "./app/models/link"

feature "save links" do
  scenario "adds a site's address to the list of links" do

    visit '/links/new'
    fill_in 'new_link', with:'http://www.github.com'
    fill_in 'title', with: 'Github'

    click_button "Submit"

    within 'ul#links' do
      expect(page).to have_content('Github')
    end


  end
  
end
