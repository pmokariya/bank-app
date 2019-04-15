class Account < ApplicationRecord
  attr_accessor :money
  belongs_to :user
  has_many :transactions
  
  def check_balance
    self.amount
  end

  def deposit_money(money,current_user)
    self.amount = self.amount + money.to_d
  	self.save
    Transaction.create(price: money , msg: "deposit" , account_number: self.account_number,account_holder_name: current_user.email.split("@")[0],account_id: self.id , user_id: current_user.id)
  end

  def withdraw_money(money,current_user)
    if self.amount > money.to_d 
      transaction = Transaction.create(price: money , msg: "withdraw" , account_number: self.account_number,account_holder_name: current_user.email.split("@")[0], account_id: self.id , user_id: current_user.id )
      if transaction.save
        self.amount = self.amount - money.to_d 
        self.save
      else
        errors.add("Something is wrong.")
      end
    else
      errors.add("You don't have enough balance in your account.")
    end
  end
end
