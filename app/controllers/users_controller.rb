class UsersController < ApplicationController
  include AuthenticationHelper

  def profile
    @user = current_user
    @posts = current_user.posts
    @liked_posts_count = @posts.count { |post| post.liked? }
    @bookmarked_posts_count = @posts.count { |post| post.bookmarked? }
  end

  def settings
    @user = current_user
  end
end