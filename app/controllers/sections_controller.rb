class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]
  
  def index
    @sections = Section.all
  end

  def show
  end

  def new
    @section = Section.new
  end

  def edit
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to @section, notice: 'Section was successfully created.'
    else
      render :new
    end
  end

  def update
    if @section.update(section_params)
      redirect_to @section, notice: 'Section was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @section.destroy
    redirect_to sections_url, notice: 'Section was successfully destroyed.'
  end

  private
    def set_section
      @section = Section.find(params[:id])
    end

    def section_params
      params.require(:section).permit(:start_time, :end_time, :classroom_id, :teacher_id, :subject_id, :day_of_week, :section_length)
    end
end
