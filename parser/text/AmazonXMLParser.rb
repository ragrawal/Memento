require 'libxml'

class AmazonXMLParser < Memento::Parser::UrlParser
  
  def get_data
      validate
      doc = XML::Parser.string(@value)
      item = doc.parse
      item = item.root.find('./Items/Item')
      if('Book' != item.attributes)
          
  		$item = $xml->Items->Item;
  		if('Book' != (string)$item->ItemAttributes->ProductGroup)
  			throw new Exception("Currently only books can be imported from Amazon");

  		$article['doctype'] = 'book';
  		$article['url'] = trim($item->DetailPageURL);
  		$article['title'] = trim($item->ItemAttributes->Title);
  		$article['publisher']=trim($item->ItemAttributes->Publisher);
  		$article['pages'] = trim($item->ItemAttributes->NumberOfPages);
  		$imgUrl = trim($item->SmallImage->URL);

  		if(!empty($imgUrl)){
  			$ch = curl_init($imgUrl);
  			$ext = strtolower(end(explode('.', $imgUrl)));
  			uses('neat_string');
  			$neat = new NeatString();
  			$filename = $neat->randomPassword(10) . '.' . $ext;
  			$fp = fopen(ARTICLE_ICON . $filename, 'w');
  			curl_setopt($ch, CURLOPT_FILE, $fp);
  			curl_setopt($ch, CURLOPT_HEADER, 0);
  			curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
  			curl_exec($ch);
  			curl_close($ch);
  			fclose($fp);
  			$article['img'] = ARTICLE_ICON_URL.$filename;
  		}



  		list($article['year'], $article['month'], $article['day']) = DateUtil::getCleanDate((string)$item->ItemAttributes->PublicationDate);

  		foreach($item->ItemAttributes->Author as $author)
  			$authors[] = (string) $author;

  		$data[0] = array('Article'=>$article, 'Author' => $authors);
  		return $data;
  	}
  end
end