module UsersHelper
  def participation_check
    @user = current_user
    @user.posts.count + @user.comments.count
  end
end
