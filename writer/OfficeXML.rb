class OfficeXML < Memento::Writer::AbstractWriter
  def initialize
    @FIELD_MAPPING = {
      :id => 'b:Tag',
      :day => 'b:Day',
      :issn => 'b:StandardNumber',
      :issue => 'b:Issue',
      :journal => 'b:JournalName',
      :month => 'b:Month',
      :pages => 'b:Pages',
      :pages => 'b:Pages',
      :place => 'b:City',
      :publisher => 'b:Publisher',
      :booktitle => 'b:BookTitle',
      :title => 'b:Title', 
      :volume => 'b:Volume',
      :year => 'b:Year'
    }.freeze
    
    @DOC_TYPES = {
      :article => {:name => 'JournalArticle', :journal => 'b:JournalName'},
      :book => {:name =>  'Book', :place => 'b:CountryRegion'},
      :booklet => {:name =>  'Book', :place => 'b:CountryRegion'},
      :conference => {:name =>  'ConferenceProceedings'},
      :inbook => {:name =>  'BookSection', :place => 'b:CountryRegion'},
      :incollection => {:name =>  'ArticleInAPeriodical', :journal => 'b:PeriodicalTitle'},
      :inproceedings => {:name =>  'ConferenceProceedings'},
      :manual => {:name =>  'Report'},
      :mastersthesis => {:name =>  'Report'},
      :misc => {:name =>  'Report'},
      :phdthesis => {:name =>  'Report'},
      :proceedings => {:name =>  'ConferenceProceedings'},
      :techreport => {:name =>  'Report'},
      :unpublished => {:name =>  'Misc', :booktitle => 'b:PublicationTitle', :place => 'b:CountryRegion'}
    }.freeze
  end
  
  def export(data)
	
		sources =  '<?xml version="1.0" encoding="UTF-8" ?>'
		sources = sources + '<b:Sources SelectedStyle="" xmlns:b="http://schemas.openxmlformats.org/officeDocument/2006/bibliography" xmlns="http://schemas.openxmlformats.org/officeDocument/2006/bibliography">'
		
		data.each do |record|
		  #sanity check

		  next if record.nil? or record.empty?
		  
		  source = "<b:Source>"
		  fields = @FIELD_MAPPING.merge(@DOC_TYPES[record.type])
		  
		  #fields that require custom handling
		  source = source + '<b:SourceType>' + fields[:name] + '</b:SourceType>'
		  source = source + "<#{fields[:id]}>" + record.id + "</#{fields[:id]}>"
		 
		  source = source + process_editors(record.editor) if record.respond_to?("editor")
		  
		  
		  record.fields.each do |key, value|
		    xml_tag = fields[key]	    
		    next unless xml_tag
		    if key == :author
		       source = source + process_authors(value)
		    elsif key == :editor
		       source = source + process_editor(value)
		    else
		      source = source + "<#{xml_tag}>" + value + "</#{xml_tag}>"
		    end
		  end

		    
		  source = source + '</b:Source>'
		  sources = sources + source
	  end
		sources = sources + '</b:Sources>';
		return sources;
	end #function export
	
	private 
	  def process_authors(authors)
	    return if authors.nil? or authors.empty?
	    source = '<b:Author><b:Author><b:NameList>'
	    authors.each do |author|
	      source = source + author_tag(author)
	    end
	    source = source + '</b:NameList></b:Author></b:Author>'
	    return source
	  end
	  
	  def process_editors(editors)
	    return if editors.nil? or editors.empty?
	    source = '<b:Author><b:Editor><b:NameList>'
	    editors.each do |author|
	      source = source + author_tag(author)
	    end
	    source = source + '</b:NameList></b:Editor></b:Author>'
	    return source
	  end
	  
	  def author_tag(author)
	    last, first = author.split(',', 2)
	    a = '<b:Last>' + last.to_s + '</b:Last>'
	    b = '<b:First>' + first.to_s + '</b:First>'
	    return '<b:Person>' + a + b + '</b:Person>'
	  end
  
  
end