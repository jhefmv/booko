require "rails_helper"

RSpec.describe "ISBN Conversion Page", type: :system, js: true do
  let(:convert_url) { "/pages/isbn-convert" }

  it "presents a form" do
    visit convert_url

    expect(page).to have_field("ISBN")
    expect(page).to have_field("Converted", disabled: true)
    expect(page).to have_button("Convert")
  end

  it "validates the form" do
    visit convert_url
    click_button "Convert"

    expect(page).to have_field("ISBN", class: "is-invalid")
    expect(page).to have_content("ISBN is required")
  end

  it "validates the ISBN input" do
    visit convert_url
    fill_in "ISBN", with: "978-1-891830-85-1"
    click_button "Convert"

    expect(page).to have_field("ISBN", class: "is-invalid")
    expect(page).to have_content("ISBN is invalid")
  end

  it "converts the ISBN-10 to ISBN-13" do
    visit convert_url
    fill_in "ISBN", with: "1-891830-85-6"
    click_button "Convert"

    expect(page).to have_field("Converted", disabled: true, class: "is-valid", with: "978-1-891830-85-3")
  end

  it "converts the ISBN-13 to ISBN-10" do
    visit convert_url
    fill_in "ISBN", with: "978-1-891830-85-3"
    click_button "Convert"

    expect(page).to have_field("Converted", disabled: true, class: "is-valid", with: "1-891830-85-6")
  end
end
