class FinancialEntriesController < ApplicationController
  load_and_authorize_resource

  before_action :set_financial_entry, only: %i[show edit update destroy]

  def index
    @financial_entries = FinancialEntry.order(due_on: :asc)
  end

  def show; end

  def new
    @financial_entry = FinancialEntry.new(due_on: Date.current)
  end

  def edit; end

  def create
    @financial_entry = FinancialEntry.new(financial_entry_params)

    if @financial_entry.save
      redirect_to @financial_entry, notice: "Lancamento criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @financial_entry.update(financial_entry_params)
      redirect_to @financial_entry, notice: "Lancamento atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @financial_entry.destroy
    redirect_to financial_entries_url, notice: "Lancamento removido com sucesso."
  end

  private

  def set_financial_entry
    @financial_entry = FinancialEntry.find(params[:id])
  end

  def financial_entry_params
    params.require(:financial_entry).permit(:order_id, :description, :kind, :status, :amount, :due_on, :paid_on)
  end
end
