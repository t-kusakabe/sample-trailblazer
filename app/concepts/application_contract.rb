class ApplicationContract < Reform::Form
  include Reform::Form::ActiveRecord
  require 'reform/form/validation/unique_validator'
end
