class HomesController < ApplicationController
	layout 'class_room'

	def index
		p current_user
		render json: current_user.class_room
	end
end
