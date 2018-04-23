class AdminController < ApplicationController
  before_action :set_order, only: [:order_ready]

  def index
    @orders = Order.joins(:check)
                   .order('checks.open DESC')
                   .order(ready: :asc, active: :asc, created_at: :asc)
  end

  def order_ready
    @order.ready = true
    @order.save!

    flash[:success] = 'Pedido marcado como pronto!'

    redirect_to admin_index_path
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end
end
