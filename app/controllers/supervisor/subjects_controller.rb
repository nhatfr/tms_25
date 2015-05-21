class Supervisor::SubjectsController < ApplicationController
  before_action :logged_in_user, :require_super
  
  def index
    @subjects = Subject.paginate page: params[:page], per_page: 20
  end

  def show
    @subject = Subject.find params[:id]
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t(:subject_created)
      redirect_to supervisor_subject_path(@subject)
    else
      render 'new'
    end
  end

  def update
    @subject = Subject.find params[:id]
    if @subject.update_attributes subject_params
      flash[:success] = t(:subject_updated)
      redirect_to supervisor_subject_path(@subject)
    else
      render 'edit'
    end
  end

  def edit
    @subject = Subject.find params[:id]
  end

  def destroy
    Subject.find(params[:id]).destroy
    flash[:success] = t(:subject_deleted)
    redirect_to supervisor_courses_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :instruction, tasks_attributes: [:id, :title, :content, :_destroy]
  end
end
