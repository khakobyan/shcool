class Classroom < ApplicationRecord
  has_many :sections, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
