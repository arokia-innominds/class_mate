require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:class_room){FactoryGirl.create(:class_room)}

  describe "GET #new" do
    it "assigns a new student as @student" do
      get :new, {}
      expect(assigns(:student)).to be_a_new(Student)
    end
  end

  describe "POST #create" do
    it "create a new student as @student" do
      post :create, {student: {first_name: 'arokia', last_name: 'a', enrolled_no: 123, email: 'test@gmail.com', password:'Nter123!', password_confirmation: 'Nter123!', class_room_id: class_room.id}}
      expect(assigns(:student).first_name).to eq("arokia")
    end

    it "invalid student details render new form" do
      post :create, {student: {first_name: 'arokia', last_name: 'a', enrolled_no: '', email: 'test@gmail.com', password:'Nter123!', password_confirmation: 'Nter123!', class_room_id: class_room.id}}
       expect(response).to render_template("new")
    end
  end
end