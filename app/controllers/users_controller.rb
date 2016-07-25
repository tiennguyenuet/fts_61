 class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @activities = PublicActivity::Activity.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end
 end
