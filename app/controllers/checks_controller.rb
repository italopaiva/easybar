class ChecksController < ApplicationController
  before_action :set_user
  before_action :check_not_open_check, except: [:close, :remove_tax]
  before_action :set_check, only: [:show, :edit, :update, :close, :remove_tax]

  def index
    @checks = Check.all
  end

  def show
  end

  def new
    @tables = Table.all
    @check = Check.new
    @checks = @user.checks.closed
  end

  def edit
  end

  def create
    @check = Check.new(check_params)

    @check.open = true

    respond_to do |format|
      if @check.save
        flash[:success] = 'Conta aberta com sucesso! Já pode realizar os seus pedidos!'
        format.html { redirect_to user_orders_path(@user) }
        format.json { render :show, status: :created, location: @check }
      else
        flash[:danger] = 'Não foi possível abrir sua conta. Tente novamente.'
        format.html { render :new }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @check.update(check_params)
        format.html { redirect_to @check, notice: 'Check was successfully updated.' }
        format.json { render :show, status: :ok, location: @check }
      else
        format.html { render :edit }
        format.json { render json: @check.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    @check.open = false

    if @check.can_close? && @check.save
      flash[:success] = 'Conta fechada com sucesso!'
    else
      flash[:danger] = 'Você ainda tem pedidos que não estão prontos. Não foi possível fechar a sua conta.'
    end

    redirect_to controller: :checks, action: :new
  end

  def remove_tax
    @check.allow_service_tax = !@check.allow_service_tax

    if @check.save!
      flash[:success] = 'Taxa removida com sucesso!'
    else
      flash[:danger] = 'Não foi possível remover a taxa.'
    end

    redirect_to controller: :checks, action: :new
  end

  private

    def set_check
      @check = Check.find(params[:id])
    end

    def check_not_open_check
      @check = Check.find_by!(open: true, user_id: @user.id)

      redirect_to user_orders_path(@user)
    rescue ActiveRecord::RecordNotFound
      true
    end

    def check_params
      params.require(:check)
            .permit(:table_id)
            .merge(user_id: @user.id)
    end
end
