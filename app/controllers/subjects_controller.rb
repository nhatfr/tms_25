class SubjectsController < ApplicationController
  before_action :logged_in_user

  def show
    @subject = Subject.find params[:id]
  end
end
