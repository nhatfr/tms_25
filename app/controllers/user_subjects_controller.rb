class UserSubjectsController < ApplicationController
  def update
    @var = UserSubject.find params[:id]
    unless @var.status == t(:completed)
      @var.update_attributes status: t(:completed) 
    end
  end
end
