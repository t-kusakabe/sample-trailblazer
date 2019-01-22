class Users::Contract::Create < ApplicationContract
  NAME_MAX_LENGTH = 64

  model User

  property :name
  property :teacher_id

  validates(
    :name,
    presence: true,
    length: { maximum: NAME_MAX_LENGTH }
  )

  validate(
    :existence_of_teacher_id
  )

  def existence_of_teacher_id
    errors.add(:teacher_id, 'が不正です。') if Teacher.pluck(:id).exclude?(teacher_id.to_i)
  end
end
