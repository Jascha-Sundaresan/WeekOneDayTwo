class Student
  def initialize(first, last)
    @first = first
    @last = last
    @courses = []
  end
  
  def name
   @first + " " + @last 
  end
  
  def courses
    @courses
  end
  
  def enroll(course)
    raise "Course Conflict" if student_has_conflict?(course)
    @courses << course unless courses.include?(course)
    course.update_student_list(self)
  end
  
  def student_has_conflict?(course)
    courses.any? {|other_course| course.conflicts_with?(other_course) }
  end
  
  def course_load
    hash = {}
    courses.each do |course|
      hash[course.department] = course.credits
    end
    hash
  end
end

class Course
  
  attr_reader :department, :credits, :days, :time
  
  def initialize(name, department, credits, days, time)
    @name = name
    @department = department
    @credits = credits
    @days = days
    @time = time
    @students = []
  end
  
  def conflicts_with?(another_course)
    self.time == another_course.time && same_day?(self, another_course)
  end
  
  
  def students
    @students
  end
  
  def add_student(student)
    student.enroll(self) unless student.courses.include?(self)
  end
  
  def update_student_list(student)
    @students << student unless students.include?(student)
  end
  
  private
  
  def same_day?(course, another_course)
    course.days.any? { |day| another_course.days.include?(day) }
  end
  
end


# tests 
s = Student.new("Jim", "Bob")
c1 = Course.new("Basket Weaving", "School of Arts", 3, [:Mon, :Wed, :Fri], 1)
c2 = Course.new("Algorithms", "School of Computer Science", 3, [:Tue, :Thu], 1)

s.enroll(c1)
s.enroll(c2)
p c1.conflicts_with?(c2)
p s.course_load
