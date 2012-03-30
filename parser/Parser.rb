module Memento
  module Parser
    class TextParser 

      attr_accessor :value

      #constructor
      def validate
        raise MementoException, "Error: Missing required text" if text.nil? or text.empty?
      end

      # extract citation information form the input string 
      # and return an array of BibTexEntry object
      def get_data
        raise 'calling abstract method: get_data'
      end

    end
    
    class UrlParser 
      attr_accessor :value


      def validate
        raise MementoException, 'Invalid Url' if @value.nil? or @value.empty?
      end

      #function: get_data
      #@description: processes url and returns citation information as an array of BibTeX entries.
      #
      def get_data
        validate
        to = get_citation_url()
        params = get_form_parameters
        referrer = get_referrer()

        citation = Memento.get_page(to, params, referrer)
        raise MementoException, 'Error: Unable to fetch citation details' if citation.to_s.strip.empty?
        puts citation
        text_parser = Memento::ParserManager.get_text_parser(get_citation_format)
        text_parser.value = citation
        data = text_parser.get_data()

        return data

      end

      protected
       	#If to fetch citation details requires filling form, then provide form parameters
       	def get_form_parameters
       	  {}
        end
      
        def get_referrer
      	  return @url
      	end

        #============ ABSTRACT METHODS ============#
        # Subclass of UrlParser will need to atleast implement these 
        # two functions
        #==========================================

     	  #returns Url from where the citation detalils can be fetched
       	def get_citation_url
       	  raise MementoException, 'Called abstract method: get_citation_url'
       	end


       	 # return the format of citation 	
       	def get_citation_format
       	  raise MementoException, 'Called abstract method: get_citation_format'
       	end



    end
    
  end
end



