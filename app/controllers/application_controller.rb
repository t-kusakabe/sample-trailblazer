class ApplicationController < ActionController::Base
  def translate_validation_errors(result)
    validation_errors = result['validation_errors']
    class_name = result['contract'].instance_variable_get(:@model).class.name
    error_messages = []
    validation_errors.each do |key, values|
      values.each do |value|
        error_messages << I18n.t('activerecord.attributes.' << class_name.downcase << '.' << key.to_s) + value
      end
    end
    error_messages
  end
end
