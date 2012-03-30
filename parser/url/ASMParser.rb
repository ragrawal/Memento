require 'uri'
class ASMParser < Memento::Parser::UrlParser
 	
 	PATTERNS = [
 	  Regexp.new('http:\/\/(.*)\.asm\.org.*[abstract|full|reprint]\/(.*)\?', Regexp::IGNORECASE),
 	  Regexp.new('http:\/\/(.*)\.asm\.org\/content\/(.*)\.[abstract|full]')
 	].freeze
 	BASE_URL = 'http://DOMAIN.asm.org/citmgr?type=bibtex&gca=';
  
  def get_citation_url
    PATTERNS.each do |pattern|
      match = @value.match(pattern)
      return BASE_URL.gsub('DOMAIN', match[1]) + URI.escape("#{match[1]};#{match[2]}") if match and match.length == 3
    end
    raise MementoException, "Error: Unable to find link to bibtex"
  end
  
  def get_citation_format
    "bibtex"
  end
  
  
    
end