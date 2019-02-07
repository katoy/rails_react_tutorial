# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Tasks' do
  let(:task) { Task.create(title: 'Old Name', description: 'Old Description') }

  get '/api/v1/tasks' do
    before do
      FactoryBot.create_list(:task, 2)
    end

    example_request 'Listing tasks' do
      expect(response_body).to eq(Task.order(created_at: :desc).all.to_json)
      expect(status).to eq(200)
    end
  end

  get '/api/v1/tasks/:id' do
    let(:id) { task.id }

    example_request 'Getting a specific Task' do
      expect(response_body).to eq(task.to_json)
      expect(status).to eq(200)
    end
  end

  put '/api/v1/tasks/:id' do
    let(:id) { task.id }
    let(:request) { { title: 'New Title', description: 'New Description' } }

    example 'Updating an task' do
      do_request(request)
      expect(status).to eq 200
      expect(response_body).to eq(Task.first.to_json)
    end
  end

  post '/api/v1/tasks' do
    let(:request) { { title: 'New Title', description: 'New Description' } }

    example 'Create an task' do
      do_request(request)
      expect(status).to eq 200
      expect(response_body).to eq(Task.first.to_json)
    end
  end

  delete '/api/v1/tasks/:id' do
    let(:id) { task.id }

    example_request 'Deleting a task' do
      expect(status).to eq(204)
      expect(Task.exists?(id: id)).to eq false
    end
  end
end
