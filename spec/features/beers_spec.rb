require 'spec_helper'

include OwnTestHelper

describe "Beer" do
  before :each do
    FactoryGirl.create :user
    FactoryGirl.create(:brewery, name: 'lolbrewery', year: 2000)   
  end

  it "is created when it gets a valid name" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
    fill_in('beer[name]', with:'pisswasser')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "is not created when name is missing" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
    click_button("Create Beer")
    expect(page).to have_content "Name can't be blank"
  end

end