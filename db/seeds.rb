Rails.logger = Logger.new(STDOUT)
Rake::Task['db:fixtures:load'].invoke

# create subjects
chemistry = Subject.create(name: "General Chemistry 1")
math = Subject.create(name: "Calculus 1")
english = Subject.create(name: "Introduction to English Literature")

# create teachers
smith = Teacher.create(first_name: "John", last_name: "Smith")
doe = Teacher.create(first_name: "Jane", last_name: "Doe")

# create teacher_subjects
TeacherSubject.create(teacher: smith, subject: chemistry)
TeacherSubject.create(teacher: doe, subject: math)
TeacherSubject.create(teacher: doe, subject: english)

# create classrooms
room1 = Classroom.create(name: "Room 101")
room2 = Classroom.create(name: "Room 102")

# create sections
Section.create(subject: chemistry, teacher: smith, classroom: room1, start_time: "08:00", end_time: "08:50", days: "MWF", duration: 50)
Section.create(subject: math, teacher: doe, classroom: room2, start_time: "09:00", end_time: "10:20", days: "TTh", duration: 80)
Section.create(subject: english, teacher: doe, classroom: room1, start_time: "11:00", end_time: "11:50", days: "MWF", duration: 50)

# create students
student1 = Student.create(first_name: "Alice", last_name: "Johnson", email: "alice.johnson@example.com")
student2 = Student.create(first_name: "Bob", last_name: "Smith", email: "bob.smith@example.com")
student3 = Student.create(first_name: "Charlie", last_name: "Lee", email: "charlie.lee@example.com")

# enroll students in sections
Enrollment.create(section: Section.first, student: student1)
Enrollment.create(section: Section.last, student: student2)
Enrollment.create(section: Section.last, student: student3)
