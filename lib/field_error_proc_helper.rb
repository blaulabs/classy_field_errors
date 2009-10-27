module FieldErrorProcHelper
  
  def self.add_css_class_to_element(css_class, html_element)
    FieldErrorProcHelper::HtmlElement.add_css_class(css_class, html_element)
  end
  
  class HtmlElement
    
    def initialize(css_class, html_element)
      @css_class = css_class
      @html_element = html_element
    end
    
    def self.add_css_class(css_class, html_element)
      new(css_class, html_element).add_css_class
    end
    
    def add_css_class
      should_add_css_class? ? insert_or_update_css_class : @html_element
    end
    
    private
    
      def should_add_css_class?
        match_form_element && element_needs_css_class
      end
    
      def element_needs_css_class
        !(@html_element =~ /<[^>]+class=['"].*#{@css_class}.*['"]/)
      end
      
      def insert_or_update_css_class
        match_class_attribute ? update_css_class : insert_css_class
      end
      
      def insert_css_class
        @html_element.insert(match_form_element.end(1), " class=\"#{@css_class}\"") 
      end
      
      def update_css_class
        @html_element.insert(match_class_attribute.end(1), "#{@css_class} ")
      end

      def match_form_element
        @match_form_element ||= /<(input|textarea|select)/.match(@html_element)
      end

      def match_class_attribute
        @match_class_attribute ||= /<[^>]+(class=['"])/.match(@html_element)
      end
    
  end
  
end