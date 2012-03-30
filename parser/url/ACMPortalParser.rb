class ACMPortalParser < Memento::Parser::UrlParser
  PATTERNS = [
    Regexp.new('id=(\d*)', Regexp::IGNORECASE)
  ]
  BASE_URL = 'http://dl.acm.org/exportformats.cfm?expformat=bibtex&id='
  
  def get_citation_url
    validate
    PATTERNS.each do |pattern|
      m = @value.match(pattern)
      return BASE_URL + m[1] if m and m.length == 2
    end
    raise MementoException, "Error: Unable to find citation information" 
  end
  
  def get_citation_format
    'bibtex'
  end
end