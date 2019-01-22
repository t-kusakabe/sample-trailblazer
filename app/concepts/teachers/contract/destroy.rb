class Teachers::Contract::Destroy < ApplicationContract
  NAME_MAX_LENGTH = 64

  model Teacher

  property :id

  validates(
    :id,
    presence: true
  )

  validate(
    :existence_of_teacher_id
  )

  def existence_of_teacher_id
    errors.add(:id, '存在しないTeacherです。') if Teacher.pluck(:id).exclude?(id.to_i)
  end
end
