module Lebowski
  module SCUI
    module Views
      
      class ColorWellView < Lebowski::Foundation::Views::View
        representing_sc_class 'SCUI.ColorWell'
        
        COLORS = { :red => '#ff0000', :green => '#00ff00', :blue => '#0000ff', :orange => '#ff6600', 
          :yellow => '#ffff00', :violet => '#8f00ff', :gray => '#999999', :black => '#000000', :white => '#ffffff' }
        
        def color_selected?
          return (not (text_box.value.nil? || text_box.value =='#eee'))
        end
        
        def color?(value)
          value = COLORS[value] if value.kind_of? Symbol
          return (text_box.value == value)
        end

        def select_color(value)
          value = COLORS[value] if value.kind_of? Symbol
          raise ArgumentError.new "The color value must be either a symbol or a string." if not value.kind_of? String
          text_box.type value
        end
        
        private        
          def text_box
            @text_box = picker_pane['contentView.textBox'] if @text_box.nil?
            return @text_box
          end
        
          def picker_pane
            @picker_pane = self['_pickerPane'] if @picker_pane.nil?
            return @picker_pane
          end        
      end
      
    end
  end
end