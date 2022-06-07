class CommentsController < ApplicationController
  # def new
  #   @ride = Ride.find(params[:ride_id])
  #   @comment = Comment.new
  # end

  def create
    @ride = Ride.find(params[:ride_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.ride = @ride
    if @comment.save
      redirect_to ride_path(@ride, anchor: "comment-#{@comment.id}")
    else
      render 'rides/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
