require 'bibtex'
require '/Users/ragrawal/personal/Memento/rMemento/export/Bib2OfficeXML2'

bib = BibTeX.open("mybib.bib")
puts Bib2OfficeXML2.new.export(bib)