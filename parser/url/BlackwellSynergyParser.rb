class BlackwellSynergyParser < Memento::Parser::UrlParser
  
  PATTERNS = [
    Regexp.new('doi/(.*)/[abstract|full]', Regexp::IGNORECASE)
  ]
  BASE_URL = 'http://onlinelibrary.wiley.com/documentcitationdownloadformsubmit'
  
  
 	def get_form_parameters
 	  params = {'hasAbstract' => 'CITATION_AND_ABSTRACT', 'fileFormat' => 'BIBTEX', 'submit' => 'Submit'}
 	  
 	  PATTERNS.each do |pattern|
      match = @value.match(pattern)
      if match and match.length == 2
        params['doi'] = match[1]
        break
      end
    end
    
    raise MementoException, "Error: Unable to find DOI" unless params.has_key?('doi')
    
    return params
 	end
  
  def get_citation_url
    BASE_URL
  end
  
  def get_citation_format
    'bibtex'
  end
end