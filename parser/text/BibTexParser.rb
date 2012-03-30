require 'bibtex'

class BibTexParser < Memento::Parser::TextParser
  def get_data
    return BibTeX.parse @value
  end
end
