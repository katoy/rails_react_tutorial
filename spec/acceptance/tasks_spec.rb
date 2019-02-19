# frozen_string_literal: true

require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Tasks' do
  explanation 'Tasks resource'

  # Headers that will be sent in every request.
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  let(:raw_post) { params.to_json }

  let(:task) do
    Task.create(title: 'Old Name', description: 'Old Description')
  end

  route '/api/v1/tasks', 'タスクの一覧' do
    get 'タスクの一覧' do
      before { FactoryBot.create_list(:task, 2) }

      example_request '正当なパラメータ' do
        expect(response_body).to eq(Task.order(created_at: :desc).all.to_json)
        expect(status).to eq(200)
      end
    end
  end

  route '/api/v1/tasks/{?title,description}', 'タスク登録' do
    parameter :title, 'タイトル', required: true, type: 'string',
      example: 'レビュー'
    parameter :description, '概要', required: true, type: 'string',
      example: 'XX機能について'

    post 'タスク登録' do
      let(:request) { { title: 'New Title', description: 'New Description' } }

      example '正当なパラメータ' do
        do_request(request)
        expect(status).to eq 200
        expect(response_body).to eq(Task.first.to_json)
      end
    end
  end

  route '/api/v1/tasks/:id', 'タスク内容' do
    parameter :id, 'タスクID', required: true, type: 'number', example: '1'

    get 'タスク内容' do
      context '成功' do
        let(:id) { task.id }

        example_request ' 正当なパラメータ' do
          expect(response_body).to eq(task.to_json)
          expect(status).to eq(200)
        end
      end

      context 'エラー' do
        let(:id) { 'a' }

        example_request '不正なパラメータ' do
          expect(response_body).to eq({error: 'Task does not exist'}.to_json)
          expect(status).to eq(404)
        end
      end
    end
  end

  route '/api/v1/tasks/:id{?title,description}', 'タスク更新' do
    parameter :id, 'タスクID', required: true, type: 'number', example: '1'
    parameter :title, 'タイトル', required: true, type: 'string',
      example: 'レビュー'
    parameter :description, '概要', required: true, type: 'string',
      example: 'XX機能について'

    put 'タスク更新' do
      let(:id) { task.id }

      context '成功' do
        let(:request) { { title: 'New Title', description: 'New Description' } }

        example ' 正当なパラメータ' do
          do_request(request)
          expect(status).to eq 200
          expect(response_body).to eq(Task.first.to_json)
        end
      end

      context 'エラー' do
        let(:id) { 'a' }

        example_request '不正なパラメータ' do
          expect(response_body).to eq({error: 'Task does not exist'}.to_json)
          expect(status).to eq(404)
        end
      end
    end
  end

  route '/api/v1/tasks/:id', 'タスク削除' do
    parameter :id, 'タスクID', required: true, type: 'number', example: '1'

    delete 'タスク削除' do
      context '成功' do
        let(:id) { task.id }

        example_request ' 正当なパラメータ' do
          expect(status).to eq(204)
          expect(Task.exists?(id: id)).to eq false
        end
      end

      context 'エラー' do
        let(:id) { 'a' }

        example_request '不正なパラメータ' do
          expect(response_body).to eq({error: 'Task does not exist'}.to_json)
          expect(status).to eq(404)
        end
      end
    end
  end
end
