require "lib/field_error_proc_helper"

include FieldErrorProcHelper

ActionView::Base.field_error_proc = Proc.new do |html_element, instance|
  add_css_class_to_element('input-error', html_element)
end