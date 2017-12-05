module ApplicationHelper
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has error' if errors.any?

    content_tag :div, capture(&block), class: css_class
  end

  def favorites_finder (user)
    fav_arr = Favorite.where(user_id: user.id)
    post_arr = []
    fav_arr.each do |f|
      post_arr += Post.where(id: f.post_id)
    end
  end
end
