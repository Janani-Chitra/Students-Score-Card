require_relative '../models/student'

describe Student do   
  context "When testing the Student class with valid arguments" do 

    it "should calcualte total for the subject_mark arguments passed" do 
      marks = [100,100,100,99]
      st = Student.new 1, *marks
      expect(st.total).to eq marks.sum
    end
    
    it "should return the garde when we call the evaluate_grade method even with the edge values" do 
      marks = [100,100,100,39]
      st = Student.new 1, *marks
      grade = st.evaluate_grade st.total
      if st.total >= 340
        expect(grade).to eq "A"
      elsif st.total >= 300
        expect(grade).to eq "B"
      else
        expect(grade).to eq "C"
      end
    end
    
  end
  
end