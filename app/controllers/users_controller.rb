class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # To get the debug information using byebug gem in the rails server console
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if@user.save
      # Handle a successful save
    else
      render 'new'
    end

    private

      def user_params
        params.require(:user).permit( :name, :email, :password, :password_confirmation)
      end

  end
end
