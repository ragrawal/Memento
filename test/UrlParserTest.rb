require_relative 'AbstractTest'

class HubMedParserTest < AbstractTest
  TEST_URL = [
  
    # ACM PORTAL
    'http://dl.acm.org/citation.cfm?id=505168.505187&coll=DL&dl=GUIDE',
   
    # ASM
    'http://jvi.asm.org/content/85/23/12474.abstract',

    #Blackwell Synergey or Wiley
    'http://onlinelibrary.wiley.com/doi/10.1002/smr.509/abstract',

    #HUBMED
    'http://www.hubmed.org/display.cgi?uids=21809171',
  
    #PubMed - ncbi.nlm.nih.gov
    'http://www.ncbi.nlm.nih.gov/pubmed/22454401'
  ]
  
  def test_officeXML
    TEST_URL.each do |url|
      result= Memento.transform('site', 'msofficexml', url)
      puts result
      assert_not_nil result, "Failed: #{url}"
    end
  end
end