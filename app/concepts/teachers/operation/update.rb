class Teachers::Operation::Update < ApplicationOperation
  step :validate
  failure :handle_validation_error, fail_fast: true
  step :persist!
  failure :handle_internal_error!

  private

  def validate(options, params)
    contract = Teachers::Contract::Update.new(Teacher.new)
    contract.id   = params[:id]
    contract.name = params[:name]
    options['contract'] = contract
    contract.valid?
  end

  def persist!
    contract = options['contract']
    model = Teacher.find(contract.id)
    model.name = contract.name
    options['model'] = model
    model.save!
  end
end
