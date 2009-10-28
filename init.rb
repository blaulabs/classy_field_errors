require "field_error_proc_helper"

ActionView::Base.field_error_proc = Proc.new do |html_element, instance|
  FieldErrorProcHelper.add_css_class_to_element('input-error', html_element)
end