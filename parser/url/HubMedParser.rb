class HubMedParser < Memento::Parser::UrlParser
  
  PATTERNS = [ 
    Regexp.new('.*uids=([0-9]*)', Regexp::IGNORECASE)
  ]
  BASE_URL = "http://www.hubmed.org/export/bibtex.cgi?uids=";
 	
 	def get_citation_url
 	  PATTERNS.each do |pattern|
 	    match = pattern.match(@value)
 	    return BASE_URL + match[1] if match and match.length == 2
 	  end	
 	  raise MementoException, "Error: Unable to find unique identifier"
 	end
 	
 	def get_citation_format
 	  "bibtex"
 	end
 	
end