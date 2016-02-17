class HomesController < ApplicationController
	layout 'class_room'
    respond_to :html, :json

	def index
		respond_to do |format|
      format.json { render :json => current_user.class_room.to_json }
      format.html
    end
	end
end
