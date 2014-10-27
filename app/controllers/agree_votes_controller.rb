class AgreeVotesController < ApplicationController
  def trigger
    if !current_user
      render json: {succesful: 0}
    end

    @existing_vote = AgreeVote.where(
      topic_id: params[:topic_id],
      is_agree: params[:is_agree],
      user: current_user
    ).try(:first)

    if @existing_vote
      if @existing_vote.destroy
        render json: {succesful: 1}
      else
        render json: {succesful: 0}
      end
    else
      @vote = AgreeVote.new(
        topic_id: params[:topic_id],
        is_agree: params[:is_agree],
        user: current_user)

      if @vote.save
        render json: {succesful: 1}
      else
        render json: {succesful: 0}
      end
    end
  end

end
