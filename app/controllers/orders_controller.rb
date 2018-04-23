class OrdersController < ApplicationController
  before_action :set_user, :check_not_admin, :check_open_check
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = @check.orders
  end

  def show
  end

  def new
    @order = Order.new
    @drinks = Item.drinks
    @foods = Item.foods
    @snacks = Item.snacks
    @narguiles = Item.narguiles
  end

  def edit
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        flash[:success] = 'Pedido feito com sucesso!'
        format.html { redirect_to new_user_order_path(@user, @order) }
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
        format.html { redirect_to user_orders_path(@user, @order) }
        format.json { render :show, status: :ok, location: @order }
      else
        flash[:danger] = 'Não foi possível atualizar o seu pedido.'
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.update(active: false, ready: true)

    respond_to do |format|
      format.html { redirect_to user_orders_url }
      format.json { head :no_content }
    end
  end

  private

  def set_order
    @order = @user.orders.find(params[:id])
  end

  def check_open_check
    @check = Check.find_by!(open: true, user_id: @user.id)
  rescue ActiveRecord::RecordNotFound
    flash[:success] = 'Você precisa abrir sua conta para realizar pedidos.'
    redirect_to new_check_path
  end

  def order_params
    params.require(:order)
          .permit(*%i[content table_id item_id quantity])
          .merge(user_id: @user.id, check_id: @check.id)
  end

  def check_not_admin
    redirect_to root_url if @user.is_admin?
  end
end
