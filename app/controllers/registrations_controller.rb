class RegistrationsController < ApplicationController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
skip_before_filter :authenticate_user

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params.require(:student).permit!)
    if @student.save
      redirect_to "/#/", :notice => "Signed up!"
    else
      render "new"
    end
  end
end
