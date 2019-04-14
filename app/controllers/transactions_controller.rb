class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  def index
    @transactions = current_user.account.transactions.all + current_user.transactions.all
    @transactions = @transactions.uniq.sort_by { |item| item.created_at }.reverse
  end

  def show
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    from_account = current_user.account
    to_account = Account.find_by(account_number: params[:transaction][:account_number])
    @transaction.account_id = to_account.id
    respond_to do |format|
      if @transaction.save
        if from_account.amount > params[:transaction][:price].to_s.to_d 
          from_account.withdraw_money(params[:transaction][:price],current_user)
          to_account.deposit_money(params[:transaction][:price],current_user)
          # format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
          format.html { redirect_to root_path, notice: 'Transaction was successfully created.' }
          format.json { render :show, status: :created, location: @transaction }
        else
          format.html { redirect_to root_path, notice: 'You dont have enough balance to Withdraw/Transfer money' }
        end
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(:price, :msg, :account_id, :user_id,:account_number,:account_holder_name)
    end
end
