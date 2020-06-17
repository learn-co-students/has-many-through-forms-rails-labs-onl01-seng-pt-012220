class CommentsController < ApplicationController

  def create
    comment = Comment.create(comment_params)
    redirect_to comment.post
  end

  def user_attributes=(user_attributes)
    user_attributes.values.each do |u_att|
      new_u = User.find_or_create_by(u_att)
      self.user_id = new_u
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :content, 
      :post_id, 
      :user_id, 
      user_attributes: [
        :username
      ]
    )
  end
end
