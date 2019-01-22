class Teachers::Operation::Create < ApplicationOperation
  step :validate
  failure :handle_validation_error, fail_fast: true
  step :persist!
  failure :handle_internal_error!

  private

  def validate(options, params)
    contract = Teachers::Contract::Create.new(Teacher.new)
    contract.name = params[:name]
    options['contract'] = contract
    contract.valid?
  end

  def persist!(options, **)
    contract = options['contract']
    model = Teacher.new(
      name: contract.name
    )

    options['model'] = model
    model.save!
  end
end
