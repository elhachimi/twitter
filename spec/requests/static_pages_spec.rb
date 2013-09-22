require 'spec_helper'

describe "StaticPages" do
	let(:base_title) {"Twitter tweet tweet"}
  describe "Home page" do
  	it "should have the content 'Twitter' " do
  		visit '/static_pages/home'
  		expect(page).to have_content('Twitter')
  		expect(page).to have_title("#{base_title} | Home")
  	end
  end

  describe 'Help page' do
  	it "should have the content 'Help' " do
  		visit '/static_pages/help'
  		expect(page).to have_content('Help')
  		expect(page).to have_title("#{base_title} | Help")
  	end
  end

  describe 'About page' do
  	it "should have the content 'About' " do
  		visit '/static_pages/about'
  		expect(page).to have_content('About')
  		expect(page).to have_title("#{base_title} | About")
  	end
  end
end
