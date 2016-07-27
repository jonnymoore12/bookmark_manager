feature "#add_tag" do
  scenario "User adds a tag to link" do
    visit "/links/new"
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tags', with: 'education'
    click_button 'Create link'

    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end
    scenario "Adding multiple tags to a new link" do
      visit "/links/new"
      fill_in "title", with: "Makers Academy"
      fill_in "url", with: "http://www.makersacademy.com/"
      fill_in "tags", with: "education ruby"
      click_button "Create link"
      link = Link.first
      expect(link.tags.map(&:name)).to include("education", "ruby")
    end
end
