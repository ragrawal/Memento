require_relative 'Parser'

#Test Parser
require_relative 'text/BibTexParser'

#Url Parser
require_relative 'url/ASMParser'
require_relative 'url/HubMedParser'
require_relative 'url/ACMPortalParser'
require_relative 'url/BlackwellSynergyParser'
require_relative 'url/PubmedParser'


module Memento
  module ParserManager
      TEXT_PARSER = {
        'bibtex' => {'name' => 'BibTeX', 'parser' => 'BibTexParser'}
      }
      
      WEBSITES = {
        'asm.org' => {'name' => 'ASM Journals', 'link' => 'http://journals.asm.org/', 'parser' => 'ASMParser'},
        'hubmed.org' => {'name' => 'Hubmed', 'link' => "http://www.hubmed.org", 'parser' => 'HubMedParser'},
        'dl.acm.org' => {'name' => 'ACM Digital Library', 'link' => 'http://dl.acm.org/', 'parser' => 'ACMPortalParser'},
        'ncbi.nlm.nih.gov' => {'name' => 'PubMed', 'link' => 'http://www.pubmed.gov', 'parser'=>'PubmedParser'},
        'onlinelibrary.wiley.com' => {'name' =>'Wiley Online Library', 'link' => "http://onlinelibrary.wiley.com", 'parser' => 'BlackwellSynergyParser'}
        
      }

      def self.get_text_parser(format)
     		raise MementoException, "Error: Missing require parameter: format" if format.nil? or format.empty?
     		info = TEXT_PARSER[format.to_s.downcase.strip]
     		raise MementoException, "Error: unsupported text format: #{format}" if info.nil?
     		Kernel.const_get(info['parser']).new
      end
      
      def self.get_url_parser(url)
        raise MementoException, "Error: Missing required parameter url" if url.nil? or url.empty?
        WEBSITES.each do |key, value|
          return Kernel.const_get(value['parser']).new if url =~ /#{key}/
        end  
        raise MementoException, "Error: Parsing is not supported for this website"
      end #get_parser

  end
end