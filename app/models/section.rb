class Section < ApplicationRecord
  enum day_of_week: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]

  belongs_to :teacher_subject
  belongs_to :classroom

  validates :start_time, :end_time, presence: true
  validate :_no_overlap

  def _no_overlap
    return unless teacher_subject.present?

    overlapping_sections = teacher_subject.sections.where(day_of_week: day_of_week)
                                          .where.not(id: id)
                                          .where("start_time < ? AND end_time > ?", end_time, start_time)
    if overlapping_sections.exists?
      errors.add(:base, "This section overlaps with another section taught by the same teacher")
    end
  end
end
