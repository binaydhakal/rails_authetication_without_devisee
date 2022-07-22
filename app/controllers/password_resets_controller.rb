class PasswordResetsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:email])
        if @user.present?
            #Send the mail to the exitsting user
            PasswordMailer.with(user: @user).reset.deliver_now
        end
        redirect_to root_path, notice: "If the email you supplied exit, then you will get a email to reset your password"
    end

    def edit
        @user = User.find_signed!(params[:token], purpose: "reset_password")
    rescue ActiveSupport::MessageVerifier::InvalidSignature 
        redirect_to sign_in_path, alert: "Soory, the token has expired, Please try again"
    end

    def update
        @user = User.find_signed!(params[:token], purpose: "reset_password")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: "Pasword has been updated!"
        else
            render :edit
        end
    end

    private

    def password_params
        params.require(:user).permit(:password, :password_confirmation)
    end
end