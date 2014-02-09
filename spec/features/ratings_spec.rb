require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username:"Kalle", password:"Foobar1", password_confirmation:"Foobar1" }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "after creation is displayed on the ratings page" do
    rating = FactoryGirl.create :rating
    beer2.ratings << rating
    user.ratings << rating

    visit ratings_path
    expect(page).to have_content "#{beer2.name} #{rating.score} #{user.username}"
  end

  it "after creation is displayed on the user's page, no other users' ratings are displayed" do
    rating = FactoryGirl.create :rating
    beer2.ratings << rating
    user.ratings << rating

    rating2 = FactoryGirl.create :rating2
    beer1.ratings << rating2
    user2.ratings << rating2

    visit user_path(user)
    expect(page).to have_content "#{beer2.name} #{rating.score}"
    expect(page).to have_no_content "#{beer1.name} #{rating2.score}"
  end

  it "is removed from database after user deletes it from their profile" do
    rating = FactoryGirl.create :rating
    beer2.ratings << rating
    user.ratings << rating

    rating2 = FactoryGirl.create :rating
    beer1.ratings << rating2
    user.ratings << rating2

    visit user_path(user)
    first('li').click_link('delete')

    expect(user.ratings.count).to eq(1)
  end


end