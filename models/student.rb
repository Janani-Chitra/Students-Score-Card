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