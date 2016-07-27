feature '#viewing_links' do
  scenario 'user views link on homepage' do
    Link.create(title: 'google', url: 'www.google.com' )

    visit '/links'
    expect(page.status_code).to eq 200

    within('ul#links') do
      expect(page).to have_content 'google'
    end
  end

  scenario "Filter by bubbles tags" do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'education')])
    Link.create(url: 'http://www.zombo.com', title: 'This is Zombocom', tags: [Tag.first_or_create(name: 'bubbles')])
    visit '/tags/bubbles'
    within "ul#links" do
      expect(page).not_to have_content("Makers Academy")
      expect(page).to have_content("This is Zombocom")
    end
  end
end
