require "rails_helper"
require 'capybara/rspec'
require 'capybara/rails'


describe "the search process", type: :feature, js: true do

  before(:each) do
    visit '/'
  end

  it "return a search for a specific query " do
    fill_in 'search_value', with: 'evil'
    click_button 'Search'
    expect(page).to have_content 'Search of evil'
  end

  it "return a search for a random query " do
    find(:xpath, "//a[@href='/en/searches/random']").click
    expect(page).to have_content 'Search of random'
  end

  it "return a search for a random query " do
    find(:xpath, "//a[@href='/en/searches/categories']").click
    page.find(:xpath, "//*[@id='dttb']/tbody/tr[1]/td[2]").click
    expect(page).to have_content 'Search of animal'
  end
end