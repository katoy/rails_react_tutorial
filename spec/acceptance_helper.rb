# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = %i[json combined_text]
  config.curl_host = 'http://localhost:3000'
  config.api_name = 'Rails_React_Tutorial API'
  config.api_explanation = 'API 仕様書'

  config.define_group :cdn do |cfg|
    cfg.docs_dir = Rails.root.join('public', 'assets', 'api', 'cdn')
    cfg.filter = :cdn
  end

  config.define_group :management do |cfg|
    cfg.docs_dir = Rails.root.join('public', 'assets', 'api', 'management')
    cfg.filter = :management
  end
end
