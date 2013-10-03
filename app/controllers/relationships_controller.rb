class RelationshipsController < ApplicationController

	def create
		relationship = Relationship.new(params[:relationship])
		relationship.follower = current_user

		flash[:error] = "Couldn't Follow" unless relationship.save
		redirect_to relationship.followed
	end

	def destroy
		relationship = Relationship.find(params[:id])
		user = relationship.followed
		relationship.destroy
		redirect_to user
	end
end
