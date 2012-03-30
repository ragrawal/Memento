require_relative 'AbstractTest'

class ASMParserTest < AbstractTest
  TEST_URL = [
    'http://jvi.asm.org/content/85/23/12474.abstract'
  ]
  
  def test_toOfficeXML
    TEST_URL.each do |url|
      result = Memento.transform('site', 'msofficexml', url)
      assert_not_nil result, "Failed to retrieve result"
    end
  end
end