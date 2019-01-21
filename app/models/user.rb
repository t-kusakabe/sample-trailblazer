class User < ApplicationRecord
  belongs_to :teacher
  self.table_name = 'users'
end
