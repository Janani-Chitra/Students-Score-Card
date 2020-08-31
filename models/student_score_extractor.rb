class StudentScoreExtractor
  def self.extract_score_details score_details
    raise("Empty score details provided, please check the input file") if score_details.nil? || score_details.empty?
    input = []
    score_details.split("\n").each_with_index do |line, index|
      line = line.strip  #remove leading ansd trailing white spaces and other tab spaces or new lines
      if line.match(/^[0-9]+,(S[1-4]-([0-9]{1,2}|100),){3}S[1-4]-([0-9]{2}|100)$/)
        input << line  #inserting every valid record from input file to input list
      else
        raise "Invalid student entry : '#{line}' at line number - #{index+1}"
      end
    end
    input
  end
end