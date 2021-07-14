class ExpensesController < ApplicationController
  before_action :authenticate_user!


  def new
    @expense = current_user.expenses.build
  end

  def create
    respond_to do |format|
      if current_user.user_meta.present?
        user_meta = current_user.user_meta.first
        expense = user_meta.expense
        account_balance = user_meta.account_balance
        if account_balance > params['expense']['amount'].to_f
          @expense = current_user.expenses.new(:description => params['expense']['description'], :amount => params['expense']['amount'].to_f)
          @expense.save
          @flag = true
          @message = 'Expense Added.'
          format.js
        else
          @flag = false
          format.js {render :js => "failure_notice('Insufficient Balance.')"}
        end
      else
        @flag = false
        format.js {render :js => "failure_notice('Please add your account balance before adding expense.')"}
      end
    end
  end

  def edit
    @expense = current_user.expenses.find(params[:id])
  end

  def update
    @expense = current_user.expenses.find(params[:id])
    user_meta = current_user.user_meta.first
    account_balance = user_meta.account_balance
    old_user_expense = user_meta.expense
    old_expense = @expense.amount
    if (account_balance + old_expense) > params['expense']['amount'].to_f
      user_meta.update(:expense=> ((old_user_expense -  old_expense)+params['expense']['amount'].to_f), :account_balance => ((account_balance + old_expense) - params['expense']['amount'].to_f))
      @expense.update(:description => params['expense']['description'], :amount => params['expense']['amount'].to_f)
      @flag = true
      @message = 'Expense Added.'
    else
      @flag = false
      @message = 'Insufficient Balance.'
    end
  end

  def destroy
    @expense = current_user.expenses.find(params[:id])
    user_meta = current_user.user_meta.first()
    user_meta.update(:account_balance => user_meta.account_balance + @expense.amount, :expense => user_meta.expense - @expense.amount)
    @expense_id = @expense.id
    @expense.destroy
  end

end
