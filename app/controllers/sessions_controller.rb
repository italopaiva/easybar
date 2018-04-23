class SessionsController < ApplicationController
  def new
    if logged_in?
      session[:user_id] = @current_user.id

      if is_admin?
        redirect_to controller: :admin, action: :index
      else
        redirect_to controller: :checks, action: :new
      end
    end
  end

  def create
    user = User.find_by(name: params[:login])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Logado com sucesso'

      if user.is_admin?
        redirect_to controller: :admin, action: :index
      else
        redirect_to controller: :checks, action: :new
      end
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
