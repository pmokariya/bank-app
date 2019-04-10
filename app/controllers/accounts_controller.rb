class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  # GET /accounts
  # GET /accounts.json
  def index
    # @accounts = Account.all
    @accounts = current_user.accounts.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
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

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_current_balance
    @account = Account.find(params[:account_id])
    @account.balance
  end

  def deposit_money
    @account = Account.find(params[:account_id])
    if params[:account]
      if params[:account][:money]
        if params[:account][:key] == "deposit"
          @account.depocit_money(params[:account][:money])
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
          @account.withdraw_money(params[:account][:money])
          respond_to do |format|
            if @account.save
              format.html { redirect_to @account, notice: 'Withdraw money successfully.' }
              format.json { render :show, status: :ok, location: @account }
            else
              format.html { render :edit }
              format.json { render json: @account.errors, status: :unprocessable_entity }
            end
          end
        end
      end
    else
      @account = Account.find(params[:account_id])
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:name, :balance, :user_id)
    end
end
