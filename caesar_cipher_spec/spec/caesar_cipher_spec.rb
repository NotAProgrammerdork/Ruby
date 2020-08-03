#spec/calculator_spec.rb
require "./lib/caesar_cipher.rb"

describe "#caesar_cipher" do
  describe "Lowercased words" do
    context "Positive shift" do
      it "works with single digit numbers" do
        expect(caesar_cipher("ab cd", 5)).to eql("fg hi")
      end
      it "works with two digit numbers" do
        expect(caesar_cipher("ab cd", 12)).to eql("mn op")
      end
    end
    context "Negative shift" do
      it "works with single digit numbers" do
        expect(caesar_cipher("fg hi", -3)).to eql("cd ef")
      end
      it "works with two digit numbers" do
        expect(caesar_cipher("mn op", -10)).to eql("cd ef")
      end
    end
  end

  describe "Uppercased words" do
    context "Positive shift" do
      it "works with single digit numbers" do
        expect(caesar_cipher("AVC EF", 2)).to eql("CXE GH")
      end
      it "works with two digit numbers" do
        expect(caesar_cipher("BC ADE", 17)).to eql("ST RUV")
      end
    end
    context "Negative shift" do
      it "works with single digit numbers" do
        expect(caesar_cipher("JEKC SDH", -2)).to eql("HCIA QBF")
      end
      it "works with two digit numbers" do
        expect(caesar_cipher("ZZZ WXYZ", -20)).to eql("FFF CDEF")
      end
    end
  end

  describe "Numbers and marks" do
    it "works with only numbers and marks" do
      expect(caesar_cipher("21¡312?_ .,148", 5)).to eql("21¡312?_ .,148")
    end
    it "works with letters, numbers and marks" do
      expect(caesar_cipher("Heada21¡¿", 3)).to eql("Khdgd21¡¿")
    end  
  end

  describe "Wrapping" do
    it "wraps around positive shift" do
      expect(caesar_cipher("abcd efg", 30)).to eql("efgh ijk")
      expect(caesar_cipher("EADJ FIW", 49)).to eql("BXAG CFT")
      expect(caesar_cipher("IaMw HoI", 13)).to eql("VnZj UbV")
    end
    it "wraps around negative shift" do
      expect(caesar_cipher("xguj ryy", -54)).to eql("vesh pww")
      expect(caesar_cipher("MAEU ASJ", -16)).to eql("WKOE KCT")
      expect(caesar_cipher("YoiI OsA", -14)).to eql("KauU AeM")
    end
  end

  describe "Zero shift" do
    it "returns the same string" do
      expect(caesar_cipher("VASHGFsaFG2326¡+?", 0)).to eql("VASHGFsaFG2326¡+?")
    end
  end
end
