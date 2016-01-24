class Assignment < ActiveRecord::Base
	belongs_to :class_room
	has_many :submissions
	has_many :students, through: :submissions

	validates :title, presence: true
end
