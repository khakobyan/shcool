class SchedulesController < ApplicationController
  before_action :set_section, only: [:add_section, :remove_section]

  def index
    @sections = current_student.sections.includes(:teacher, :subject, :classroom).order(:start_time)
  end

  def add_section
    if current_student.can_enroll?(@section)
      current_student.enroll(@section)
      redirect_to schedules_path, notice: 'Section was successfully added to your schedule.'
    else
      redirect_to schedules_path, alert: 'Cannot add section, another section overlaps with the selected time.'
    end
  end

  def remove_section
    current_student.withdraw(@section)
    redirect_to schedules_path, notice: 'Section was successfully removed from your schedule.'
  end

  def download_schedule
    @sections = current_student.sections.includes(:teacher, :subject, :classroom).order(:start_time)

    respond_to do |format|
      format.pdf do
        pdf = SchedulePdf.new(@sections)
        send_data pdf.render, filename: 'my_schedule.pdf', type: 'application/pdf', disposition: 'attachment'
      end
    end
  end

  private

  def set_section
    @section = Section.find(params[:section_id])
  end
end
