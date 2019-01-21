class Teacher < ApplicationRecord
  has_many :users
  self.table_name = 'teachers'
end
