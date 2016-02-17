require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:student){FactoryGirl.create(:student, password: 'Nte123$', email: 'test@gmail.com', enrolled_no: 123)}
  
  describe "POST #create" do
    it "login as a student" do
      post :create, {email: student.email, password: 'Nte123$'}
      expect(session[:user_id]).to eq(student.id)
    end

    it "should return invalid message" do
      post :create, {email: '', password: 'Nte123$'}
      expect(response.status).to eq(200)
    end
  end

  describe "#destroy session" do

    before do
      controller.stub(:authenticate_user).and_return(true)
      controller.stub(:current_user).and_return(student)
    end
    it 'should destroy the session' do
      delete :destroy 
      expect(session[:user_id]).to be_nil
    end
  end
end