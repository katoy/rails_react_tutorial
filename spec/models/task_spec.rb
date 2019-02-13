# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  subject { task.valid? }
  let(:task) { build(:task, title: title, description: description) }
  let(:title) { 'title' }
  let(:description) { 'description' }

  context 'with title and description' do
    it 'is valid' do is_expected.to be_truthy end
  end

  context 'without title' do
    let(:title) { '' }

    it 'is invalid' do
      is_expected.to be_falsey
      expect(task.errors[:title]).to include("can't be blank")
    end
  end

  context 'without description' do
    let(:description) { '' }

    it 'is invalid' do
      is_expected.to be_falsey
      expect(task.errors[:description]).to include("can't be blank")
    end
  end

  context 'title.length' do
    let(:title) { 'x' * length }
    context 'is 256' do
      let(:length) { 256 }
      it 'is valid' do is_expected.to be_truthy end
    end

    context 'is 257' do
      let(:length) { 257 }
      it 'is invalid' do
        is_expected.to be_falsey
        expect(task.errors[:title])
          .to include('is too long (maximum is 256 characters)')
      end
    end
  end

  context 'description.length' do
    let(:description) { 'x' * length }
    context 'is 1024' do
      let(:length) { 1024 }

      it 'is valid' do is_expected.to be_truthy end
    end

    context 'is 1025' do
      let(:length) { 1025 }

      it 'is invalid' do
        is_expected.to be_falsey
        expect(task.errors[:description])
          .to include('is too long (maximum is 1024 characters)')
      end
    end
  end

  context 'cheking uniquness' do
    let(:task) do
      build(:task, title: title, description: description)
    end
    let!(:task_one) { create(:task) }
    let(:title) { task_one.title }
    let(:description) { task_one.description }

    context 'already exist [title,description]' do
      it 'is invalid' do
        is_expected.to be_falsey
        expect(task.errors[:description])
          .to include('has already been taken')
      end
    end

    context 'already exist title, not same description' do
      let(:title) { 'new title_x' }
      it 'is valid' do is_expected.to be_truthy end
    end

    context 'already exist description, not same title' do
      let(:description) { 'new description_x' }
      it 'is valid' do is_expected.to be_truthy end
    end
  end
end
