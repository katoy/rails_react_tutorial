# frozen_string_literal: true

class Task < ApplicationRecord
  validates :title, :description, presence: true
  validates :title, length: { maximum: 256 }
  validates :description, length: { maximum: 1024 }
  validates :description, uniqueness: { scope: :title }
end
