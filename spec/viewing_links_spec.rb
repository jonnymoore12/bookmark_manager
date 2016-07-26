feature 'Viewing links' do
  scenario 'Links page displays a list of existing links' do

    visit '/links'
    List.create(url: "http://www.makersacademy.com", title: "Makers Academy")

    # sanity check (remove later):
    expect(page.status_code).to eq 200

    within 'ul#links' do
      expect(page).to have_content "Makers Academy"
    end
  end
end
