# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
class_room = ClassRoom.create(name: 'School A', description: 'New School', section: 'AB', standard: 4 )
student = Student.create(name: 'Admin', first_name: 'Admin', last_name: 'example', enrolled_no: 123,class_room_id: class_room.id,email: 'admin@example.com', password: '12345678', password_confirmation: '12345678')