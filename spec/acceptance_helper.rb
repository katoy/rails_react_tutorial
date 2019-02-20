# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.curl_host = 'http://localhost:3000'
  config.api_name = 'Rails_React_Tutorial API'
  config.api_explanation = 'API 仕様書'

  config.request_body_formatter = :json
  config.request_headers_to_include = %w[Content-Type Accept]
  config.response_headers_to_include = %w[Content-Type]

  config.define_group :cdn do |cfg|
    cfg.docs_dir = Rails.root.join('public', 'assets', 'api', 'cdn')
    cfg.filter = :cdn
  end

  config.define_group :management do |cfg|
    cfg.docs_dir = Rails.root.join('public', 'assets', 'api', 'management')
    cfg.filter = :management
  end
end
