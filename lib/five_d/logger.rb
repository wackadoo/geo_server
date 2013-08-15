require 'active_support'  
  
# Logger class for custom logging format  
class FiveD::Logger < ActiveSupport::BufferedLogger  
  
  private  
  
    def severity_string(level)  
        case level  
        when DEBUG  
            :DEBUG  
        when INFO  
            :INFO  
        when WARN  
            :WARN  
        when ERROR  
            :ERROR  
        when FATAL  
            :FATAL  
        else  
            :UNKNOWN  
        end  
    end  
  
  public  
  
    def add(severity, message = nil, progname = nil, &block)  
        return if @level > severity  
        message = (message || (block && block.call) || progname).to_s  
        # If a newline is necessary then create a new message ending with a newline.  
        # Ensures that the original message is not mutated.  
        message = "[%5s %s] %s\n" % [severity_string(severity),  
                            Time.now.strftime("%m/%d %H:%M:%S"),  
                            message] unless message[-1] == ?\n  
        buffer << message  
        auto_flush  
        message  
    end  
  
end  