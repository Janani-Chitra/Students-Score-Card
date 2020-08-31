require_relative '../models/student_result_management'
require_relative '../models/student'

describe StudentResultManagement do
  context "When testing the StudentResultManagement class with invalid arguments" do
    it "should throw an error if we call the score_card_generator method with duplicate student entry" do
      score_details = ["1,S1-88,S2-53,S3-69,S4-64","2,S1-92,S2-86,S3-93,S4-77","01,S1-92,S2-86,S3-93,S4-77"]
      srm = StudentResultManagement.new
      expect { srm.score_card_generator score_details }.to raise_error.with_message(/Found duplicate student entry for student with id/)
    end
  end

  context "When testing the StudentResultManagement class with valid arguments" do
    it "should create students if we call the score_card_generator method with valid student entry" do
      score_details = ["1,S1-88,S2-53,S3-69,S4-64","2,S1-92,S2-86,S3-93,S4-77"]
      srm = StudentResultManagement.new
      srm.score_card_generator score_details
      expect(srm.student_ids.include?(1)).to eq true
    end

  end
  
end