class Teachers::Operation::Destroy < ApplicationOperation
  step :validate
  failure :handle_validation_error, fail_fast: true
  step :presist!
  failure :handle_internal_error!

  private

  def validate(options, params)
    contract = Teachers::Contract::Destroy.new(Teacher.new)
    contract.id = params[:id]
    options['contract'] = contract
    contract.valid?
  end

  def persist!(options, **)
    contract = options['contract']
    model = Teacher.find(contract.id)

    options['model'] = model
    model.destroy!
  end
end
