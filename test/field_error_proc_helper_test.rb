require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/field_error_proc_helper'))

class << Test::Unit::TestCase
  def test(name, &block)
    test_name = :"test_#{name.gsub(' ','_')}"
    raise ArgumentError, "#{test_name} is already defined" if self.instance_methods.include? test_name.to_s
    define_method test_name, &block
  end
end

class FieldErrorProcHelperTest <  Test::Unit::TestCase

  test "should return tag with input_error class for input" do
    assert_equal "<input class=\"input_error test\">Test</input>",
      FieldErrorProcHelper.add_css_class_to_element("input_error", "<input class=\"test\">Test</input>")
  end

  test "should return tag with input_error class for label" do
    assert_equal "<label class=\"input_error test\">Test</label>",
      FieldErrorProcHelper.add_css_class_to_element("input_error", "<label class=\"test\">Test</label>")
  end

  test "should return tag with input_error class for textarea" do
    assert_equal "<textarea class=\"input_error test\">Test</textarea>",
      FieldErrorProcHelper.add_css_class_to_element("input_error", "<textarea class=\"test\">Test</textarea>")
  end

  test "should return tag with input_error class for label with a tag" do
    input = "<label>a <a class=\"a\">b</a></label>"
    assert_equal '<label class="input_error">a <a class="a">b</a></label>',
      FieldErrorProcHelper.add_css_class_to_element("input_error", input)
  end

  test "should return tag with input_error class for select" do
    assert_equal "<select class=\"input_error test\">Test</select>",
      FieldErrorProcHelper.add_css_class_to_element("input_error", "<select class=\"test\">Test</select>")
  end

  test "should return tag with input_error called through Proc::new" do
    my_proc = Proc.new do |html_tag, instance|
      FieldErrorProcHelper.add_css_class_to_element("input_error", html_tag)
    end

    assert_equal "<select class=\"input_error test\">Test</select>", my_proc.call("<select class=\"test\">Test</select>")
  end

  test "should work without class attribute" do
    assert_equal "<input class=\"input_error\" type=\"text\"/>", FieldErrorProcHelper.add_css_class_to_element("input_error", "<input type=\"text\"/>")
  end

  test "should work with self-closing tag" do
    assert_equal "<input class=\"input_error\"/>", FieldErrorProcHelper.add_css_class_to_element("input_error", "<input/>")
  end

  test "should work without any spaces or other attributes" do
    assert_equal "<select class=\"input_error\">Test</select>", FieldErrorProcHelper.add_css_class_to_element("input_error", "<select>Test</select>")
  end

  test "should return tag without input_error class for other tags" do
    assert_equal "<p class=\"test\">Test</p>", FieldErrorProcHelper.add_css_class_to_element("input_error", "<p class=\"test\">Test</p>")
  end

  test "should return tag without input_error class for other tags without class" do
    assert_equal "<p>Test</p>", FieldErrorProcHelper.add_css_class_to_element("input_error", "<p>Test</p>")
  end

  test "should not add class if it already exists for the element" do
    assert_equal "<input class=\"test input_error\">Test</input>",
      FieldErrorProcHelper.add_css_class_to_element("input_error", "<input class=\"test input_error\">Test</input>")
  end

end
