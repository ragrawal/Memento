#Bought by Taylor and 


class LeoonlinePortal < Memento::Parser::UrlParser
  PATTERNS = [
    Regexp.new('abs/(.*)', Regexp::IGNORECASE)
  ]
  BASE_URL = 'http://www.tandfonline.com/action/downloadCitation'
  
  
  def get_data
    Memento.get_page(@url)
    return super
  end
  
  def get_citation_url
    BASE_URL
  end
  
  def get_form_parameters
    params = {'downloadFileName'=> 'tandf_rfse206_1', 'include' => 'abs', 'format' => 'bibtex', 'direct' => 'Download+article+metadata'}
    
    downloadFileName=tandf_rfse206_1&format=bibtex&direct=true&include=abs
		
		PATTERNS.each do |pattern|
      match = @value.match(pattern)
      if match and match.length == 2
        params['doi'] = match[1]
        break
      end   
    end
    
    raise MementoException, "Error: Unable to find DOI" unless params.has_key?('doi')
    å
    return params
  end 	
  
  def get_citation_format
    'bibtex'
  end
end