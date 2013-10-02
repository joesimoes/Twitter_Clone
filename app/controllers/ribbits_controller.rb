class RibbitsController < ApplicationController

  def create
    ribbit = Ribbit.new(params[:ribbit])
    ribbit.user_id = current_user.id

    flash[:error] = "Your Ribbit was over 140 characters" unless ribbit.save
    redirect_to root_url
  end
end
