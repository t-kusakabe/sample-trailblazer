class Teachers::Contract::Update < ApplicationContract
  NMAE_MAX_LENGTH = 64

  model Teacher

  property :id
  property :name

  validates(
    :name,
    presence: true,
    length: { maximum: NMAE_MAX_LENGTH }
  )

  validate(
    :existence_of_teacher_id
  )

  def existence_of_teacher_id
    errors.add(:id, '存在しないTeacherです。') if Teacher.pluck(:id).exclude?(id.to_i)
  end
end
