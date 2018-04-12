class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        flash[:success] = 'Pedido criado com sucesso!'
        format.html { redirect_to user_order_path(@order, @user) }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        flash[:success] = 'Pedido atualizado com sucesso!'
        format.html { redirect_to @order, user_id: @user.id }
        format.json { render :show, status: :ok, location: @order }
      else
        flash[:danger] = 'Não foi possível atualizar o seu pedido.'
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to user_orders_url }
      format.json { head :no_content }
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def set_user
      user_id = session[:user_id]
      @user ||= User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil

      redirect_to root_url
    end

    def order_params
      params.require(:order)
            .permit(:content, :table_id)
            .merge(user_id: @user.id)
    end
end
