class AgreeVotesController < ApplicationController
  def trigger
    if !current_user
      render json: {succesful: 0}
    end

    @existing_vote = AgreeVote.where(
      topic_id: params[:topic_id],
      user: current_user
    ).try(:first)

    is_agree = params[:is_agree] == "1" ? true : false

    if @existing_vote && @existing_vote.is_agree == is_agree
      if @existing_vote.destroy
        render json: {succesful: 1, msg: "Removed vote"}
      else
        render json: {succesful: 0}
      end
    elsif @existing_vote
      if @existing_vote.update(is_agree: is_agree)
        render json: {succesful: 1, msg: "Updated vote"}
      else
        render json: {succesful: 0}
      end
    else
      @vote = AgreeVote.new(
        topic_id: params[:topic_id],
        is_agree: is_agree,
        user: current_user)

      if @vote.save
        render json: {succesful: 1, msg: "Created vote"}
      else
        render json: {succesful: 0}
      end
    end
  end

end
