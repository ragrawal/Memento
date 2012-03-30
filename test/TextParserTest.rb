require 'test/unit'
require_relative "../Memento"

class TextParserTest < Test::Unit::TestCase
  def test_bibtex2office
    bib = Memento.transform("bibtex","msofficexml",File.open("test/mybib.bib").read)
    puts bib
  end
  
  
end
