class TransactionsController < ApplicationController
  before_action :authenticate_user!


  def new
    @transaction = LoanMoney.new(:donor => current_user)
  end

  def create
    respond_to do |format|
      if params['loan_money']['recipient'] != ""
        if current_user.user_meta.present?
          user_meta = current_user.user_meta.first
          account_balance = user_meta.account_balance
          if account_balance > params['loan_money']['amount'].to_f
            # user_meta.update(:account_balance => (account_balance - params['loan_money']['amount'].to_f))
            recipient = User.find(params['loan_money']['recipient'])
            @transaction = LoanMoney.new(:donor => current_user, :recipient => recipient, :description => params['loan_money']['description'], :amount => params['loan_money']['amount'].to_f)
            @transaction.save
            @flag = true
            @message = 'Transaction Completed.'
            format.js
          else
            @flag = false
            format.js {render :js => "failure_notice('Insufficient Balance.')"}
          end
        else
          @flag = false
          format.js {render :js => "failure_notice('Please add your account balance before transaction.')"}
        end
      else
        format.js {render :js => "failure_notice('Please choose a recipient.')"}
      end
    end
  end

  def filter_transaction
    @transactions = params[:user] == '0' ? current_user.transactions : current_user.transactions.where(:recipient => params[:user])
    @transactions = params[:status] == '0' ? @transactions : @transactions.where(:status => params[:status])
   end

  def update_status
    @transaction = current_user.transactions.find_by(:id => params[:id])
    @transaction.update(:status => params[:status])
    @response = transaction_update_maneuver(@transaction, params[:status])
  end

  private

  def transaction_update_maneuver(transaction, status)
    user_meta = current_user.user_meta.first()
    if transaction.write_off?
      if transaction.paid?
        new_account_balance = user_meta.account_balance - transaction.amount
        transaction.update(:paid_ts => nil)
        response = 'Transaction wrote off, No amount credited.'
      else
        new_account_balance = user_meta.account_balance
        response = 'Transaction wrote off, No amount credited.'
      end
    elsif transaction.paid_back?
      new_account_balance = transaction.amount + user_meta.account_balance
      transaction.update(:paid_ts => DateTime.now)
      response = 'The amount has been credited to account.'
    elsif transaction.pending?
      if transaction.paid?
        new_account_balance = user_meta.account_balance - transaction.amount
        transaction.update(:paid_ts => nil)
        response = 'Updated, Amount has been debited.'
      else
        new_account_balance = user_meta.account_balance
        response = 'Updated, Amount neither debited nor credited'
      end
    end
    user_meta.update(:account_balance => new_account_balance)
    return response
  end




end
