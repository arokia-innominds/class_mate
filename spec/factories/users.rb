FactoryGirl.define do
  factory :user do
  	class_room
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'P@ssw0rd!' }
    password_confirmation { password }
    type 'Student'
  end

end
