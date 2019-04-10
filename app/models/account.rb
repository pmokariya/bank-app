class Account < ApplicationRecord
  attr_accessor :money
  belongs_to :user
  validates :name,:balance, presence: true

  def depocit_money(money)
  	self.balance = self.balance.to_s.to_d + money.to_s.to_d
  	self.save
  end

  def withdraw_money(money)
  	self.balance = self.balance.to_s.to_d - money.to_s.to_d 
  	self.save
  end
end
