module ValidUserRequestHelper
  def sign_in_as_a_valid_user
    @user ||= FactoryGirl.create :user
    post_via_redirect user_session_path, 'user[login]' => @user.username, 'user[password]' => @user.password
  end
  
end