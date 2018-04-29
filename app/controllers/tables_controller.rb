class TablesController < ApplicationController
  before_action :set_user, :check_admin
  before_action :set_table, only: [:show, :edit, :update, :destroy]

  def index
    @tables = Table.all
  end

  def show
    @orders = Order.for_table(@table.id).order_for_admin
  end

  def new
    @table = Table.new
  end

  def edit
  end

  def create
    @table = Table.new(table_params)

    respond_to do |format|
      if @table.save
        flash[:success] = 'Mesa criada com sucesso!'
        format.html { redirect_to @table }
        format.json { render :show, status: :created, location: @table }
      else
        format.html { render :new }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @table.update(table_params)
        flash[:success] = 'Dados da mesa atualizados com sucesso!'
        format.html { redirect_to @table }
        format.json { render :show, status: :ok, location: @table }
      else
        format.html { render :edit }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @table.destroy

    respond_to do |format|
      flash[:success] = 'Mesa apagada com sucesso!'
      format.html { redirect_to tables_url }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey
    respond_to do |format|
      flash[:danger] = 'Não é possível apagar a mesa, pois existem pedidos para essa mesa!'
      format.html { redirect_to tables_url }
      format.json { head :unprocessable_entity }
    end
  end

  private
    def set_table
      @table = Table.find(params[:id])
    end

    def table_params
      params.require(:table).permit(:number)
    end

    def set_user
      user_id = session[:user_id]
      @user ||= User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      session[:user_id] = nil

      redirect_to root_url
    end

    def check_admin
      redirect_to root_url unless @user.is_admin?
    end
end
