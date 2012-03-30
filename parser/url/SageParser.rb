class ACMPortal < Memento::Parser::UrlParser
  PATTERNS = [
    Regexp.new('http:\/\/([^\.]*).*[abstract|reprint]\/([\d\/]*)', Regexp::IGNORECASE)
  ]
  BASE_URL = 'http://online.sagepub.com/cgi/citmgr?type=bibtex&gca=sp'
  
  def get_citation_url
    PATTERNS.each do |pattern|
      match = @value.match(pattern)
      return BASE_URL + match[1] + ';' + match[2] if match and match.length == 3
    end
    raise MementoException, "Error: Unable to find unique identifier"
  end
  
  def get_citation_format
    'bibtex'
  end
end