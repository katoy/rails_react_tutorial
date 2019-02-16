# frozen_string_literal: true

require 'rails_helper'

describe 'Homepage' do
  SCREENSHOTS = "#{Rails.root}/screenshots"

  before do
    driven_by :selenium_chrome_headless
    # driven_by :selenium_chrome
  end
  after do
    take_full_page_screenshot("#{SCREENSHOTS}/home.png")
  end

  let(:title) { 'Rails 5.1 + webpacker + React + Reactstrap Example' }

  it 'shows title' do
    visit root_url
    expect(page).to have_content title
  end
end
