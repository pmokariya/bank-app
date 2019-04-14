class Transaction < ApplicationRecord
  belongs_to :user
  validates :price,:account_number,:account_holder_name, presence: true
end
