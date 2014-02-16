require 'spec_helper'

describe Beer do
  before :each do
    FactoryGirl.create :style 
  end

  it "is saved when beer has name and style" do
    beer = Beer.create name:"foo", style_id: 1

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved when beer has no name defined" do
    beer = Beer.create style:"beer"

    expect(beer).to be_invalid
    expect(Beer.count).to eq(0)
  end

  it "is not saved when beer has no style defined" do
    beer = Beer.create name:"foo"

    expect(beer).to be_invalid
    expect(Beer.count).to eq(0)
  end
end
