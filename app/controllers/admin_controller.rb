class AdminController < ApplicationController
  before_action :set_order, only: [:order_ready]

  def index
    @orders = Order.joins(:check)
                   .only_today
                   .order_for_admin
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
