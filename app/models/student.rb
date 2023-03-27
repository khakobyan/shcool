class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :sections, through: :enrollments

  validates :name, presence: true, uniqueness: true

  def schedule
    sections.order(:start_time).map do |section|
      {
        subject: section.subject.name,
        start_time: section.start_time,
        end_time: section.end_time,
        teacher_name: section.teacher.first_and_last_name,
        classroom_name: section.classroom.name
      }
    end
  end

  def add_section(section)
    if sections.none? { |s| s.start_time < section.end_time && s.end_time > section.start_time }
      sections << section
    else
      false
    end
  end

  def remove_section(section)
    sections.destroy(section)
  end
end
