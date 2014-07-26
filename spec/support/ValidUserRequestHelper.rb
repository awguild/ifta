# module for helping request specs
module ValidUserRequestHelper

  # for use in request specs
  def sign_in_as_a_valid_user
    FactoryGirl.create :conference
    @user ||= FactoryGirl.create :user
    post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
  end
end
