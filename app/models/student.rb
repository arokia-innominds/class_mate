class Student < User
  has_many :submissions
  has_many :assignments, through: :submissions

  validates  :name, presence: true
  validates_associated :submissions, :assignments
  validates :enrolled_no , uniqueness: true
end
