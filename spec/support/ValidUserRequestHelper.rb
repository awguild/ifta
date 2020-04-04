# module for helping request specs
module ValidUserRequestHelper

  # for use in request specs
  def sign_in_as_a_valid_user
    @user ||= create(:user)
    post user_session_path, params: { 'user[email]' => @user.email, 'user[password]' => @user.password }
  end

  def sign_in_as_a_admin_user
    @user ||= create(:user, :admin)
    post user_session_path, params: { 'user[email]' => @user.email, 'user[password]' => @user.password }
  end

  def create_conference
    create(:conference)
  end
end
