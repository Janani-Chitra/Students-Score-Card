require_relative "../models/student_score_extractor"

describe StudentScoreExtractor do 
  context "When testing the StudentScoreExtractor class with invalid arguments" do 
    it "should throw an error if we call the extract_score_details method with score > 100" do 
      expect { StudentScoreExtractor.extract_score_details "1,S1-188,S2-53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with negative score " do 
      expect { StudentScoreExtractor.extract_score_details "1,S1-88,S2--53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method without id value " do 
      expect { StudentScoreExtractor.extract_score_details ",S1-88,S2--53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with char id value " do 
      expect { StudentScoreExtractor.extract_score_details "a,S1-88,S2--53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with negative id value " do 
      expect { StudentScoreExtractor.extract_score_details "-21,S1-88,S2--53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with missing '-' " do 
      expect { StudentScoreExtractor.extract_score_details "1,S188,S2-53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with missing ',' " do 
      expect { StudentScoreExtractor.extract_score_details "1S1-88,S2-53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with missing 'S' " do 
      expect { StudentScoreExtractor.extract_score_details "1,88,S2-53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with lowercase 's' " do 
      expect { StudentScoreExtractor.extract_score_details "1,s1-88,S2-53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with extra space in-between " do 
      expect { StudentScoreExtractor.extract_score_details "1, S1-88,S2-53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with extra char in-between " do 
      expect { StudentScoreExtractor.extract_score_details "1,@S1-88,S2-53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with '\t' in-between " do 
      expect { StudentScoreExtractor.extract_score_details "1, S1-88,S2-53\t,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

    it "should throw an error if we call the extract_score_details method with greater subject number " do 
      expect { StudentScoreExtractor.extract_score_details "1, S9-88,S2-53,S3-69,S4-64" }.to raise_error.with_message(/Invalid student entry :/)
    end

  end

  context "When testing the StudentScoreExtractor class with no arguments" do 
    it "should raise an error if we call the extract_score_details method without argument " do 
      expect { StudentScoreExtractor.extract_score_details }.to raise_error(ArgumentError)
    end

    it "should raise an error if we call the extract_score_details method empty string " do 
      expect { StudentScoreExtractor.extract_score_details "" }.to raise_error.with_message(/Empty score details provided/)
    end
  end

  context "When testing the StudentScoreExtractor class with valid arguments" do 
    
    it "should return array of score string if we call the extract_score_details method with subject mark value as 0 " do 
      score = StudentScoreExtractor.extract_score_details "1,S1-00,S2-0,S3-01,S4-64"
      expect(score).to eq ["1,S1-00,S2-0,S3-01,S4-64"]
    end

    it "should return score string ignoring empty lines if we call the extract_score_details method with empty lines " do 
      score = StudentScoreExtractor.extract_score_details "1,S1-88,S2-53,S3-69,S4-64\n\n"
      expect(score).to eq ["1,S1-88,S2-53,S3-69,S4-64"]
    end

    it "should return score string ignoring leading and trailing spaces if present when we call the extract_score_details method " do 
      score = StudentScoreExtractor.extract_score_details "    1,S1-88,S2-53,S3-69,S4-64 "
      expect(score).to eq ["1,S1-88,S2-53,S3-69,S4-64"]
    end

    it "should return score string if present when we call the extract_score_details method with multiple lines " do 
      score = StudentScoreExtractor.extract_score_details "1,S1-88,S2-53,S3-69,S4-64\n2,S1-92,S2-86,S3-93,S4-77"
      expect(score).to eq ["1,S1-88,S2-53,S3-69,S4-64","2,S1-92,S2-86,S3-93,S4-77"]
    end

  end
  
end