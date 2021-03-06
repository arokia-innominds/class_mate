require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe StudentsController, type: :controller do
  render_views
  # This should return the minimal set of attributes required to create a valid
  # Student. As you add validations to Student, be sure to
  # adjust the attributes here as well.
  let(:class_room) {FactoryGirl.create(:class_room)}
  let(:user) { FactoryGirl.create(:user, class_room: class_room)}
  let(:valid_attributes) {{first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, name: Faker::Name.name, 
    email: Faker::Internet.email, password: '12345678', password_confirmation: '12345678', enrolled_no: rand(0..100), class_room_id: class_room.id}
  }

  let(:invalid_attributes) {{name: ''}}

  before do
    controller.stub(:authenticate_user).and_return(true)
    controller.stub(:current_user).and_return(user)
  end

  describe "GET #index" do
    it "assigns all students as @students" do
      get :index, {format: :json}
      expect(JSON.parse(response.body)[0]['id']).to eq(user.id)
    end
  end

  describe "GET #show" do
    it "assigns the requested student as @student" do
      student = Student.create! valid_attributes
      get :show, {:id => student.to_param}
      expect(assigns(:student)).to eq(student)
    end
  end

  describe "GET #new" do
    it "assigns a new student as @student" do
      get :new, {}
      expect(assigns(:student)).to be_a_new(Student)
    end
  end

  describe "GET #edit" do
    it "assigns the requested student as @student" do
      student = Student.create! valid_attributes
      get :edit, {:id => student.to_param}
      expect(assigns(:student)).to eq(student)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Student" do
        expect {
          post :create, {:student => valid_attributes}
        }.to change(Student, :count).by(1)
      end

      it "assigns a newly created student as @student" do
        post :create, {:student => valid_attributes}
        expect(assigns(:student)).to be_a(Student)
        expect(assigns(:student)).to be_persisted
      end

      it "redirects to the created student" do
        post :create, {:student => valid_attributes}
        expect(response).to redirect_to(Student.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved student as @student" do
        post :create, {:student => invalid_attributes}
        expect(assigns(:student)).to be_a_new(Student)
      end

      it "re-renders the 'new' template" do
        post :create, {:student => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {{first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, name: Faker::Name.name, 
    email: Faker::Internet.email, password: '12345679', password_confirmation: '12345679', enrolled_no: rand(0..100), class_room_id: class_room.id}}

      it "updates the requested student" do
        student = Student.create! valid_attributes
        put :update, {:id => student.to_param, :student => new_attributes}
        student.reload
        expect(assigns(:student)).to eq(student)
      end

      it "assigns the requested student as @student" do
        student = Student.create! valid_attributes
        put :update, {:id => student.to_param, :student => valid_attributes}
        expect(assigns(:student)).to eq(student)
      end

      it "redirects to the student" do
        student = Student.create! valid_attributes
        put :update, {:id => student.to_param, :student => valid_attributes}
        expect(response).to redirect_to(student)
      end
    end

    context "with invalid params" do
      it "assigns the student as @student" do
        student = Student.create! valid_attributes
        put :update, {:id => student.to_param, :student => invalid_attributes}
        expect(assigns(:student)).to eq(student)
      end

      it "re-renders the 'edit' template" do
        student = Student.create! valid_attributes
        put :update, {:id => student.to_param, :student => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested student" do
      student = Student.create! valid_attributes
      expect {
        delete :destroy, {:id => student.to_param}
      }.to change(Student, :count).by(-1)
    end

    it "redirects to the students list" do
      student = Student.create! valid_attributes
      delete :destroy, {:id => student.to_param}
      expect(response).to redirect_to(students_url)
    end
  end

end
