require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  let!(:user) {FactoryGirl.create(:student, email: 'test@gmail.com', password: '123ebrt', password_confirmation: '123ebrt', enrolled_no: 123)}

  before do
  	session[:user_id] = user.id
  end
	
	describe '#current_user' do
		it 'should return the current user' do
	   	expect(controller.send(:current_user)).to eq(user)
	  end

	  it 'should return false' do
	  	session[:user_id] =nil
	   	expect(controller.send(:current_user)).to be_nil
	  end
	end

	describe '#authenticate_user' do
	  it 'should return the true' do
	   	expect(controller.send(:authenticate_user)).to eq(true)
	  end

	  it 'should return the true' do
	  	session[:user_id] =nil
	  	get :index
	   	expect(response.body).to redirect_to new_session_url
	  end
	end
end