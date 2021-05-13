describe 'admin experience', type: :system, js: true do
  it 'creates student' do
    sign_in create(:user)

    get '/students/new'

    fill_in 'Name', with: 'Some Name'

    click_on 'Save'

    expect(page).to have_content 'Successfully created student!'
  end

  it 'creates volunteer'
  it 'associates student with volunteer'
end
