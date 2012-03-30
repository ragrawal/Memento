class AmazonParser < Memento::Parser::UrlParser
    @BASE_URL = 'http://ecs.amazonaws.com/onca/xml?Service=AWSECommerceService&AWSAccessKeyId=1E6W7G64405195A1J702&Operation=ItemLookup&ResponseGroup=Medium&ItemId='
    
    PATTERNS = [
        Regexp.new('/gp/product/(\d*)', Regexp::IGNORECASE),
        Regexp.new('/ASIN/(\d*)', Regexp::IGNORECASE),
        Regexp.new('/dp/(\w*)', Regexp::IGNORECASE)
      ].freeze
      
      if(preg_match("#/gp/product/(\d*)#", $url, $matches))
   			return $matches[1];
   		if(preg_match("#/ASIN/(\d*)#", $url, $matches))
   			return $matches[1];
   		if(preg_match("#/dp/(\w*)#", $url, $matches))
   			return $matches[1];
   		
   	def get_data
   	  
   	end
    
    protected
    
      def get_citation_url
        asin = get_asin()
        raise MementoException, 'Unable to get Amazon Standard Identification Number (ASIN).' if(asin == -1) 
        return @BASE_URL + asin
      end
      
      #TODO: 
      def get_asin
        PATTERNS.each do |pattern|
          matches = @value.match(pattern)
          return matches[1] if matches and matches.length >= 2
        end
      end
      

     	def get_citation_format
     	  raise MementoException, 'Called abstract method: get_citation_format'
     	end
      
      
        
end