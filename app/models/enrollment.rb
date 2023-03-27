class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :section

  validate :no_overlap

  private

  def no_overlap
    if student.sections.where(day_of_week: section.day_of_week)
                       .where.not(id: section.id)
                       .where("start_time < ? AND end_time > ?", section.end_time, section.start_time)
                       .any?
      errors.add(:section, "overlaps with another section")
    end
  end
end
