PURPOSE: Provide clean html/css handling of form fields with errors.  Rails wraps error input fields with a div, to provide styling.  We just add the css class directly to the error form field.

WHY: The default rails way can break html structure, and destroy placement/styling.  We saw this happen mainly when you wrap form fields inside label tags.

RESULT:
  Normal Rails html/css for error input fields
    <div class="fieldWithErrors"><input class="input-error test">Test</input></div>
  New output
    <input class="input-error test">Test</input>
This works on input, textarea and select elements.
    

HOW TO USE:
  - Put field_error_proc.rb in config/initializers
  - Put field_error_proc_helper.rb in lib
  - Put the css contained in field_error_proc.css in your base css file
  (You don't need the test file)
  
And your done, you may need to restart your server to have the changes take effect.