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
    Task.create(title: 'Old Title', description: 'Old Description')
  end

  shared_examples_for 'ステータスとボディ' do |label|
    example label do
      do_request request
      expect(status).to eq expected_status
      expect(response_body).to eq expected_body
    end
  end

  route '/api/v1/tasks', 'タスクの一覧' do
    get 'タスクの一覧' do
      before { FactoryBot.create_list(:task, 2) }
      let(:request) {}
      let(:expected_status) { 200 }
      let(:expected_body) { Task.order(created_at: :desc).all.to_json }

      it_should_behave_like 'ステータスとボディ', ' 正当なパラメータ'
    end
  end

  route '/api/v1/tasks{?title,description}', 'タスク登録' do
    parameter :title, 'タイトル',
              required: true, type: 'string', example: 'レビュー'
    parameter :description, '概要',
              required: true, type: 'string', example: 'XX機能について'

    post 'タスク登録' do
      let(:request) { { title: 'New Title', description: 'New Description' } }

      context '成功' do
        let(:expected_status) { 200 }
        let(:expected_body) { Task.last.to_json }

        it_should_behave_like 'ステータスとボディ', ' 正当なパラメータ'
      end

      context 'エラー 1' do
        let(:request) { { title: '', description: '' } }
        let(:request) {}
        let(:expected_status) { 400 }
        let(:expected_body) do
          { title: ["can't be blank"], description: ["can't be blank"] }.to_json
        end

        it_should_behave_like 'ステータスとボディ', '不正（empty）'
      end

      context 'エラー 2' do
        let(:request) { { title: '1' * 257, description: '1' * 1025 } }
        let(:expected_status) { 400 }
        let(:expected_body) do
          {
            title: ['is too long (maximum is 256 characters)'],
            description: ['is too long (maximum is 1024 characters)']
          }.to_json
        end

        it_should_behave_like 'ステータスとボディ', '不正（too_long）'
      end
    end
  end

  route '/api/v1/tasks/:id', 'タスク内容' do
    parameter :id, 'タスクID', required: true, type: 'number', example: '1'
    let(:request) {}

    get 'タスク内容' do
      context '成功' do
        let(:id) { task.id }
        let(:expected_status) { 200 }
        let(:expected_body) { task.to_json }

        it_should_behave_like 'ステータスとボディ', ' 正当なパラメータ'
      end

      context 'エラー' do
        let(:id) { 'a' }
        let(:expected_status) { 404 }
        let(:expected_body) { { error: 'Task does not exist' }.to_json }

        it_should_behave_like 'ステータスとボディ', '不正（id）'
      end
    end
  end

  route '/api/v1/tasks/:id{?title,description}', 'タスク更新' do
    parameter :id, 'タスクID', required: true, type: 'number', example: '1'
    parameter :title, 'タイトル',
              required: true, type: 'string', example: 'レビュー'
    parameter :description, '概要',
              required: true, type: 'string', example: 'XX機能について'
    put 'タスク更新' do
      let(:id) { task.id }
      let(:request) { { title: 'New Title', description: 'New Description' } }

      context '成功' do
        let(:expected_status) { 200 }
        let(:expected_body) { Task.first.to_json }

        it_should_behave_like 'ステータスとボディ', ' 正当なパラメータ'
      end

      context 'エラー_1' do
        let(:id) { 'a' }
        let(:expected_status) { 404 }
        let(:expected_body) { { error: 'Task does not exist' }.to_json }

        it_should_behave_like 'ステータスとボディ', '不正（id）'
      end

      context 'エラー_2' do
        let(:request) { { title: '', description: '' } }
        let(:expected_status) { 400 }
        let(:expected_body) do
          { title: ["can't be blank"], description: ["can't be blank"] }.to_json
        end

        it_should_behave_like 'ステータスとボディ', '不正（empty）'
      end

      context 'エラー_3' do
        let(:request) { { title: task2.title, description: task2.description } }
        let(:task2) do
          Task.create(title: 'x Old Title', description: 'x Old Description')
        end
        let(:expected_status) { 400 }
        let(:expected_body) do
          { description: ['has already been taken'] }.to_json
        end

        it_should_behave_like 'ステータスとボディ', '不正（uniqness）'
      end
    end
  end

  route '/api/v1/tasks/:id', 'タスク削除' do
    parameter :id, 'タスクID', required: true, type: 'number', example: '1'
    let(:request) {}

    delete 'タスク削除' do
      context '成功' do
        let(:id) { task.id }
        let(:expected_status) { 204 }
        let(:expected_body) { '' }

        it_should_behave_like 'ステータスとボディ', ' 正当なパラメータ'
      end

      context 'エラー' do
        let(:id) { 'a' }
        let(:expected_status) { 404 }
        let(:expected_body) { { error: 'Task does not exist' }.to_json }

        it_should_behave_like 'ステータスとボディ', '不正（id）'
      end
    end
  end
end
