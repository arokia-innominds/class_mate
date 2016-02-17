class Student < User
  has_many :submissions
  has_many :assignments, through: :submissions

  validates_associated :submissions, :assignments
  validates :enrolled_no , uniqueness: true, presence:true
end
