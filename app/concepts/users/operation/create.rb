class Users::Operation::Create < ApplicationOperation
  step :validate
  failure :handle_validation_error, fail_fast: true
  step :persist!
  failure :handle_internal_error!

  private

  def validate(options, params)
    contract = Users::Contract::Create.new(User.new)
    contract.name = params[:name]
    contract.teacher_id = prams[:teacher_id]
    options['contract'] = contract
    contract.valid?
  end

  def persist!(options, **)
    contract = options['contract']
    teacher  = Teacher.find(contract.teacher_id)
    model = teacher.users.create(
      name: contract.name
    )

    options['model'] = model

    model.save!
  end
end
