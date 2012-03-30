module Memento
  module Writer
    
  	class AbstractWriter
      def export(data)
        raise MementoException, "calling abstract method: export"
      end
    end
  	
  end
end
