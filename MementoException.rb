# Note instead of subclassing from Exception, use StandardError because 
# StandardError deals with application level errors where as Exception deals with the 
# both application and environment level types of errors

class MementoException < StandardError

 
end
