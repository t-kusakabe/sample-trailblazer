class ApplicationOperation < Trailblazer::Operation
  protected

  def handle_validation_error(options, **)
    options['validation_errors'] = options['contract'].errors.to_hash
  end

  def handle_internal_error!(options, **)
    options['operation_class'] = self.class
    raise TrailblazerApp::Error::OperationError.new(options)
  end
end
