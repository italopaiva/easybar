class SessionsController < ApplicationController
  def new
    if logged_in?
      session[:user_id] = @current_user.id
      redirect_to controller: :orders, action: :new, user_id: @current_user.id
    end
  end

  def create
    user = User.find_by(name: params[:login])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Logado com sucesso'
      redirect_to controller: :orders, action: :new
    else
      flash[:danger] = 'Login ou senha inválidos'
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logout realizado com sucesso!'

    redirect_to root_url
  end
end
