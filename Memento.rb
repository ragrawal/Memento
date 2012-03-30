require 'curb'
require 'cgi'

require_relative 'MementoException'
require_relative 'parser/ParserManager'
require_relative 'writer/WriterManager'

module Memento
  def self.transform(input_format, output_format, value)
        #Sanity Checks
        raise MementoException, "Error: Missing required parameter: input_format" if input_format.nil? or input_format.empty?
        raise MementoException, "Error: Missing required parameter: output_format" if output_format.nil? or output_format.empty?
        raise MementoException, "Error: Missing required parameter: text" if value.nil? or value.empty?
      
        #if input_format = 'site', then its a website and use UrlParser to get text
        parser = nil
        if ['site'].include?(input_format.downcase.strip)
            parser = Memento::ParserManager.get_url_parser(value)
        else
            parser = Memento::ParserManager.get_text_parser(input_format)
        end
        raise MementoException, "Unable to find required parser" if parser.nil?
        
        parser.value = value
        data = parser.get_data
      
        writer = Memento::WriterManager.get_writer(output_format)
        return writer.export(data)
  end
  
  def self.get_page(url, parameters = {}, referer = nil)
 		c = Curl::Easy.new(url)
 		c.follow_location = true
    c.header_in_body = false
    c.useragent='Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2 GTB5'
    c.enable_cookies = true
    
    if parameters and !parameters.empty?
      c.http_post parameters.map{|k,v| "#{k}=#{CGI.escape(v)}"}.join('&')
    end
    
    #sometimes especially in the case pubmed url, c.perform 
    # falsely gives PartialFileError but successfully retrieves body
    begin
      c.perform
    rescue
      
    end
    return c.body_str
    	
 	end
 	
 	
  
  
  
end