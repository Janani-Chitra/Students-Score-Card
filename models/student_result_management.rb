require 'set'
# require './student'
class StudentResultManagement
  attr_accessor :students, :student_ids

  def initialize
    @students = [] #has many students
    @student_ids = Set.new #to store all unique students's id
  end

  def score_card_generator score_details
    score_details.each do |sd|
      id, sub_marks = sd.split(",", 2)
      id = id.to_i
      marks = sub_marks.split(",").map{|s| s.split("-")[1].to_i}
      raise "Found duplicate student entry for student with id #{id}" if @student_ids.include?(id)
      @students <<  Student.new(id, *marks) #create student objects from given score details
      @student_ids.add(id) #Add id to the set
    end
    average_comparator
    #after generating display the score card of the class
    display_score_card
  end

  def display_score_card
    p "ID Subject1 Subject2 Subject3 Subject4 GrandTotal Grade Average-Compare"
    @students.each do |st|
      p "|#{st.id}|  #{st.sub1} | #{st.sub2} |  #{st.sub3}  | #{st.sub4}  | #{st.total}  | #{st.grade} | #{st.average­_compare} |"
    end
    p "--------------------------------------------------"
    p "-------------------------------"
    p "Grade Report"
    p "Number of students in A Grade :: #{grade_count 'A'}" 
    p "Number of students in B Grade :: #{grade_count 'B'}"
    p "Number of students in C Grade :: #{grade_count 'C'}"
    p "Number of students above their grade average :: #{average_comparator_count 'ABOVE'}"
    p "Number of students below their grade average :: #{average_comparator_count 'BELOW'}"

    p "-------------------------------"
  end

  def group_by_grade
    @grade_student_mapping ||= @students.group_by{|st| st.grade} #using instance object to avoid recomputation
  end

  def group_br_average_comparator
    @average_comparator_student_mapping ||= @students.group_by{|st| st.average­_compare}
  end

  #return the number of students in the given grade
  def grade_count grade
    return group_by_grade[grade].count if group_by_grade.keys.include? grade 
    0
  end

  #return the number of students under the given comparator category
  def average_comparator_count comparator
    return group_br_average_comparator[comparator].count if group_br_average_comparator.keys.include? comparator 
    0
  end

  #calculate gradewise average for the given grade
  def grade_average grade
    @grade_average_map ||= group_by_grade.keys.map do |g|
      { g => group_by_grade[g].map{|s| s.total}.sum / group_by_grade[g].count }
    end.reduce(:merge)
    @grade_average_map[grade]
  end

  #assign average_compare for each student based on their total and their grades over all average in class
  def average_comparator
    @students.each do |st|
      st.average­_compare = if st.total >=  grade_average(st.grade)
        "ABOVE"
      else
        "BELOW"
      end
    end
  end

end