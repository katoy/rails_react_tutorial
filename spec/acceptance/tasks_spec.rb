# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Tasks' do
  before do
    FactoryBot.create_list(:task, 2)
  end

  get '/api/v1/tasks' do
    example_request 'Listing tasks' do
      expect(response_body).to eq(Task.order(created_at: :desc).all.to_json)
      expect(status).to eq(200)
    end
  end

  get '/api/v1/tasks/:id' do
    let(:task) { Task.first }
    let(:id) { task.id }

    example_request 'Getting a specific Task' do
      #expect(response.keys)
      #  .to eq %w[id title description created_at updated_at]
      expect(response_body).to eq(task.to_json)
      expect(status).to eq(200)
    end
  end

  post '/api/v1/tasks/:id' do
    let(:id) { Task.first.id }
    let(:title) { 'title_updated' }
    let(:description) { 'memo_updated' }

    # TODO: 未実装
    #example_request 'Updating a task' do
    #  do_request(title: title, description: description)
    #  response = JSON.parse(response_body)
    #  expect(response['title']).to eq title
    #  expect(response['description']).to eq description
    #  expect(status).to eq(200)
    #end
  end

  delete '/api/v1/tasks/:id' do
    let(:id) { Task.first.id }

    example_request 'Deleting a task' do
      expect(status).to eq(204)
    end
  end
end
