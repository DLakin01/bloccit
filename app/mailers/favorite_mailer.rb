class FavoriteMailer < ApplicationMailer
  default from: 'youremail@email.com'

  def new_comment(user, post, comment)
    headers["Message-ID"] = "<comments/#{comment.id}@peaceful-plains-45961.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@@peaceful-plains-45961.example>"
    headers["References"] = "<post/#{post.id}@@peaceful-plains-45961.example>"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end

  def new_post(user, post)
    headers["Message-ID"] = "<post/#{post.id}@peaceful-plains-45961.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@@peaceful-plains-45961.example>"
    headers["References"] = "<post/#{post.id}@@peaceful-plains-45961.example>"

    @user = user
    @post = post

    mail(to: user.email, subject: "You are now following #{post.title}!")
  end
end
