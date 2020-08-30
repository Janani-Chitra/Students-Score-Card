class StudentResultManagement
  attr_accessor :students

  def initialize
    @students = [] #has many students
  end

  def score_card_generator score_details
    score_details.each do |sd|
      id, sub_marks = sd.split(",", 2)
      marks = sub_marks.split(",").map{|s| s.split("-")[1].to_i}
      @students << Student.new(id, *marks) #create student objects from given score details
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
    p "Number of students in A Grade :: #{group_by_grade['A'].count}" 
    p "Number of students in B Grade :: #{group_by_grade['B'].count}"
    p "Number of students in C Grade :: #{group_by_grade['C'].count}"
    p "Number of students above their grade average :: #{group_br_average_comparator['ABOVE'].count}"
    p "Number of students below their grade average :: #{group_br_average_comparator['BELOW'].count}"

    p "-------------------------------"
  end

  def group_by_grade
    @grade_student_mapping ||= @students.group_by{|st| st.grade} #using instance object to avoid recomputation
  end

  def group_br_average_comparator
    @average_comparator_student_mapping ||= @students.group_by{|st| st.average­_compare}
  end

  #calculate gradewise average for the given grade
  def grade_average grade
    group_by_grade[grade].map{|s| s.total}.sum / group_by_grade[grade].count
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

class Student
  attr_accessor :id, :sub1, :sub2, :sub3, :sub4, :grade, :total, :average­_compare
  def initialize id, sub1, sub2, sub3, sub4
    @id, @sub1, @sub2, @sub3, @sub4 = id, sub1, sub2, sub3, sub4
    @total = sub1 + sub2 + sub3 + sub4 #calculate grand_total
    @grade = evaluate_grade @total
  end

  def evaluate_grade total #evaluate grade based on total 
    case total
      when 340..400 
        'A'
      when 300..340 
        'B'
      else 
        'C'
    end
  end

end

input = %W{
  1,S1-88,S2-53,S3-69,S4-64 2,S1-92,S2-86,S3-93,S4-77 3,S1-53,S2-59,S3-72,S4-59 4,S1-60,S2-52,S3-85,S4-62 5,S1-85,S2-53,S3-74,S4-61 6,S1-72,S2-91,S3-72,S4-89 7,S1-72,S2-71,S3-77,S4-91 8,S1-89,S2-60,S3-94,S4-59 9,S1-63,S2-61,S3-80,S4-57 10,S1-86,S2-84,S3-65,S4-72 11,S1-83,S2-75,S3-89,S4-89 12,S1-65,S2-63,S3-65,S4-80 13,S1-57,S2-56,S3-56,S4-59 14,S1-60,S2-52,S3-77,S4-75 
  15,S1-67,S2-56,S3-85,S4-62 16,S1-75,S2-84,S3-61,S4-90 17,S1-64,S2-53,S3-56,S4-77 18,S1-60,S2-51,S3-55,S4-66 19,S1-83,S2-70,S3-69,S4-65 20,S1-57,S2-76,S3-75,S4-59 21,S1-63,S2-84,S3-52,S4-74 22,S1-61,S2-64,S3-65,S4-53 23,S1-73,S2-83,S3-86,S4-73 24,S1-58,S2-67,S3-74,S4-85 25,S1-52,S2-53,S3-55,S4-83 26,S1-57,S2-81,S3-55,S4-70 27,S1-61,S2-68,S3-55,S4-91 28,S1-63,S2-68,S3-65,S4-72 29,S1-71,S2-63,S3-87,S4-70 30,S1-60,S2-65,S3-79,S4-81 31,S1-52,S2-92,S3-78,S4-81 32,S1-66,S2-65,S3-80,S4-73 33,S1-73,S2-51,S3-55,S4-58 34,S1-86,S2-80,S3-66,S4-71 35,S1-91,S2-69,S3-69,S4-90 36,S1-70,S2-78,S3-72,S4-78 37,S1-66,S2-94,S3-89,S4-52 38,S1-94,S2-52,S3-58,S4-82 39,S1-70,S2-51,S3-57,S4-54 40,S1-92,S2-90,S3-55,S4-84 41,S1-66,S2-81,S3-86,S4-75 42,S1-67,S2-54,S3-77,S4-94 43,S1-56,S2-80,S3-67,S4-57 44,S1-83,S2-72,S3-77,S4-86 45,S1-55,S2-79,S3-79,S4-66 46,S1-53,S2-57,S3-50,S4-84 47,S1-57,S2-76,S3-78,S4-52 48,S1-69,S2-51,S3-69,S4-90 49,S1-68,S2-72,S3-56,S4-81 50,S1-85,S2-63,S3-55,S4-54 
}

srm = StudentResultManagement.new 
srm.score_card_generator input