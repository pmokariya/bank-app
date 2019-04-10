class Transaction < ApplicationRecord
  belongs_to :user
  validates :price,:from_account,:to_account, presence: true
end
