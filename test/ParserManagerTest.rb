require 'test/unit'
require_relative "../Memento"

class ParserManagerTest < Test::Unit::TestCase
  def test_bibtex

    ['bibtex','Bibtex','BIBTEX'].each do |format|
      
      parser = Memento::ParserManager.get_text_parser(format)
      assert_equal BibTexParser, parser.class
    end
  end
  
  
end
