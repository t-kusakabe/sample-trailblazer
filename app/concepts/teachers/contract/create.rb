class Teachers::Contract::Create < ApplicationContract
  NAME_MAX_LENGTH = 64

  model Teacher

  property :name

  validates(
    :name,
    presence: true,
    length: { maximum: NAME_MAX_LENGTH }
  )
end
