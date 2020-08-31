require "./models/student"
require "./models/student_result_management"
require "./models/student_score_extractor"
class Main
  def self.read_score_details
    File.read("input.txt")
  end

  def self.run
    srm = StudentResultManagement.new 
    score_details = read_score_details
    begin  
      score_details = StudentScoreExtractor.extract_score_details score_details
      srm.score_card_generator score_details
    rescue StandardError => e
      p "#{e.inspect}"
    end     
  end

end

Main.run