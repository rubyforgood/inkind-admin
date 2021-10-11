describe "admin experience", type: :system, js: true do
  xit "creates student" do
    admin = create(:admin)
    sign_in(admin)
    visit new_admin_student_path

    fill_in "First name", with: "Jill"
    fill_in "Last name", with: "Jones"
    click_button "Create Student"

    expect(page).to have_content "Successfully created student!"
  end

  it "creates volunteer"
  it "associates student with volunteer"
end
