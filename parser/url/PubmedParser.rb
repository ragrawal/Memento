class PubmedParser < Memento::Parser::UrlParser
  PATTERNS = [
    Regexp.new('.*TermToSearch=([0-9]*)', Regexp::IGNORECASE),
    Regexp.new('.*list_uids=([0-9]*)',Regexp::IGNORECASE),
    Regexp.new('/pubmed/([0-9]*)/?', Regexp::IGNORECASE),
    Regexp.new('uid=([0-9]*)', Regexp::IGNORECASE)
  ]
  BASE_URL = 'http://www.hubmed.org/export/bibtex.cgi?uids='
    
  def get_citation_url
    PATTERNS.each do |pattern|
      match = @value.match(pattern)
      return BASE_URL + match[1] if match and match.length == 2
    end
    raise MementoException, "Error: Unable to find article identifier number"
  end
  
  def get_citation_format
    'bibtex'
  end
end