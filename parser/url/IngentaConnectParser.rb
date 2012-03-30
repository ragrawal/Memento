class IngentaConnectParser < Memento::Parser::UrlParser
  PATTERNS = [
    Regexp.new('title="BibText Export" href="([^\"]*)"', Regexp::IGNORECASE),
    Regexp.new('ingentaconnect.com[^/]*/(.*)', Regexp::IGNORECASE)
  ]
  BASE_URL = 'http://www.ingentaconnect.com'
  
  
  protected function __getCitationUrl(){
 		
		//$pattern =  '#(http://.*/content.*format=bib)#';
		//$content = Url::getPage($this->url, array(), $this->url);
 		//if(preg_match($pattern, $content, $matches)){
		//	return $matches[1];
		//}
		$content = Url::getPage($this->url);
		if(preg_match("#title=\"BibText Export\" href=\"([^\"]*)\"#", $content, $matches)){
			return "http://www.ingentaconnect.com" . $matches[1];
		}
		else if(preg_match("#ingentaconnect.com[^/]*/(.*)#", $this->url, $matches)){
			return "http://www.ingentaconnect.com/" . $matches[1] . '?format=bib';
		}
		else
 			throw new ParserException("Unable to find bibtext link");

 	}
  
  def get_citation_url
    PATTERNS.each do |pattern|
      match = @value.match(pattern)
      return BASE_URL + match[1] if match and match.length == 2
    end
  end
  
  def get_citation_format
    'bibtex'
  end
end