FactoryGirl.define do
  factory :class_room do
    name { Faker::Name.name }
    standard  4
    section 'A'

  end

end
