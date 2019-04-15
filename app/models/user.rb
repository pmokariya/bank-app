class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account
  has_many :transactions

  after_create :create_account

  def create_account
    a = Account.create(
      user_id: self.id,
      account_holder_name: self.email.split('@')[0],
      account_number: SecureRandom.random_number(10**10).to_s.rjust(16,'0'),
      account_type: "saving", 
      amount: "0.0",
    )
	end
end
