module Lebowski
  module SCUI
    module Views

      class ContentEditableView < Lebowski::Foundation::Views::View
        representing_sc_class 'SCUI.ContentEditableView'
        
        def value
          return self['value']
        end
        
        def debug
          puts "iframe.tag = " + iframe.tag
          puts "iframe.class.to_s = " + iframe.class.to_s
          puts "iframe.html = " + iframe.html.to_s
          puts "iframe.text = " + iframe.text.to_s
          puts "iframe.attribute('style') = " + iframe.attribute('style').to_s
          puts "iframe.attribute('scrolling') = " + iframe.attribute('scrolling').to_s
          puts "iframe.scrolling = " + iframe.scrolling.to_s
          
          puts "html.class = " + html.class.to_s
          puts "body.class = " + body.class.to_s
        end
        
        private
          def iframe
            if @iframe.nil?
              cq = self.core_query('iframe')
              @iframe = cq[0]
              # cq.done
            end
            return @iframe
          end
          
          def body
            if @body.nil?
              cq = self.core_query('body')
              @body = cq[0]
              # cq.done
            end
            return @body            
          end
          
          def html
            if @html.nil?
              cq = self.core_query('html')
              @html = cq[0]
              # cq.done
            end
            return @html
          end
      end

    end
  end
end