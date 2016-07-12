class Users::RegistrationsController < Devise::RegistrationsController

   #Adds a captcha check to the sign up process
   #this way if our sign up form gets bombed by spam bots we don't have a ton of nonsensical users
   def create
    if !verify_recaptcha
      flash.delete :recaptcha_error
      build_resource
      resource.valid?
      resource.errors.add(:base, "There was an error with the recaptcha code below. Please re-enter the code.")
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render :new }
    elsif user_exists?
      redirect_to new_user_session_path, alert: t('.email_in_use')
    else
      flash.delete :recaptcha_error
      flash[:errors] = 'hide'
      super
    end
  end

  private

  def user_exists?
    User.find_by(email: params[:user][:email]).present?
  end
end
