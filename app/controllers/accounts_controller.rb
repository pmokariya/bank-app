class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy,:check_current_balance]

  def index
    @accounts = current_user.account
  end

  def show
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_current_balance
    @account.check_balance
  end

  def deposit_withdraw_money
    @account = Account.find(params[:account_id])
    if params[:account]
      if params[:account][:money]
        if params[:account][:key] == "deposit"
          @account.deposit_money(params[:account][:money],current_user)
          respond_to do |format|
            if @account.save
              format.html { redirect_to @account, notice: 'Deposit money successfully.' }
              format.json { render :show, status: :ok, location: @account }
            else
              format.html { render :edit }
              format.json { render json: @account.errors, status: :unprocessable_entity }
            end
          end
        elsif params[:account][:key] == "withdraw"

          respond_to do |format|
            if @account.amount > params[:account][:money].to_s.to_d 
              if @account.save
                @account.withdraw_money(params[:account][:money],current_user)
                format.html { redirect_to @account, notice: 'Withdraw money successfully.' }
                format.json { render :show, status: :ok, location: @account }
              else
                format.html { render :edit }
                format.json { render json: @account.errors, status: :unprocessable_entity }
              end
            else
              format.html { redirect_to root_path, notice: 'You dont have enough balance to Withdraw/Transfer money' }
            end
          end
        end
      end
    else
      @account = Account.find(params[:account_id])
    end
  end

  private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(:account_holder_name, :amount, :user_id, :account_number,:account_type)
    end
end
