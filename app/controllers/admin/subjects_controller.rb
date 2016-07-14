class Admin::SubjectsController < ApplicationController
  def index
    @subjects = Subject.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end
end
