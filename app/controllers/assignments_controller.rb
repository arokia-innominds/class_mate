class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy, :submission, :show_submission]
  respond_to :html, :json
  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
    respond_to do |format|
      format.json { render :json => @assignments }
      format.html
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    respond_with(@assignment.as_json)
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
    respond_to do |format|
      format.json { render json: @assignment.as_json}
    end
  end

  # GET /assignments/1/edit
  def edit
    respond_to do |format|
      format.json { render json: @assignment.as_json}
    end
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment.as_json, status: :ok , notice: 'Assignment was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render json: @assignment.as_json, status: :ok , notice: 'Assignment was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def submission
    @submission = Submission.new(submission_params.merge(student_id: current_user.id))
    if @submission.save
      respond_to do |format|
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render json: @submission.as_json, status: :ok , notice: 'Submission was successfully created.' }
      end
    end
  end

  def show_submission
     @submissions = @assignment.submissions.joins(:student)
     respond_to do |format|
       format.json { render json: @submissions.as_json, status: :ok}
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).merge(class_room_id: params[:class_room_id]).permit!
    end

    def submission_params
      params.require(:submission).permit!
    end
end
