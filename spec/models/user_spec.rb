require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe '#encrypt_password' do 

  	it 'should assign the password hash' do
  	  u = User.new(password: 'Ntye123')
      expect(u.encrypt_password).to be_truthy
  	end

  	it 'should return the false' do
  	  u = User.new(password: '')
      expect(u.encrypt_password).to be_falsy
  	end
  end

  describe '#self.authenticate' do
  	it 'should authenticate user' do
  	  User.create(first_name: 'test', last_name:'test1', email: 'test@gmail.com', password:'Ver1234', enrolled_no:123, password_confirmation: 'Ver1234')	
      expect(User.authenticate('test@gmail.com', 'Ver1234')).to be_truthy
  	end

  	it 'should return the false' do
  	  u = User.new(password: '')
      expect(User.authenticate('test@gmail.com', 'Ver1234')).to be_falsy
  	end
  end
end
