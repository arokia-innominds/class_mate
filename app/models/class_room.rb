class ClassRoom < ActiveRecord::Base
	has_many :students
	has_many :assignments

	validates :name, presence: true 
	validates_associated :students, :assignments
end
