require_relative 'Writer'
require_relative 'OfficeXML'

module Memento
  module WriterManager
      WRITERS =  {
    		:msofficexml => {'name'=>'MS Office XML', 'parser'=>'OfficeXML'}
    	}.freeze
  	
    	def self.get_writer(format)
    	  raise MementoException, 'Error: Missing required parameter: format' if format.nil? or format.empty? 
    	  	info = WRITERS[format.to_s.downcase.strip.to_sym]
      		raise MementoException, 'Error: unsupported writer type: #{format}' if info.nil? or info.empty?
      		return Kernel.const_get(info['parser']).new
    	end
  end
end