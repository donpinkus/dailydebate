class VotesController < ApplicationController
  def trigger
    if !current_user
      render json: {succesful: 0}
    end

    @existing_vote = Vote.where(comment_id: params[:comment_id], user: current_user).try(:first)

    if @existing_vote
      if @existing_vote.destroy
        render json: {succesful: 1}
      else
        render json: {succesful: 0}
      end
    else
      @vote = Vote.new(comment_id: params[:comment_id], user: current_user)

      if @vote.save
        render json: {succesful: 1}
      else
        render json: {succesful: 0}
      end
    end
  end

  # # POST /votes
  # # POST /votes.json
  # def create
  #   @vote = Vote.new(vote_params)

  #   @vote.user = current_user

  #   if @vote.save
  #     render json: {succesful: 1}
  #   else
  #     render json: {succesful: 0}
  #   end
  # end

  # # PATCH/PUT /votes/1
  # # PATCH/PUT /votes/1.json
  # def update
  #   respond_to do |format|
  #     if @vote.update(vote_params)
  #       render json: {succesful: 1}
  #     else
  #       render json: {succesful: 0}
  #     end
  #   end
  # end

  # # DELETE /topics/1
  # # DELETE /topics/1.json
  # def destroy
  #   if @vote.destroy
  #     render json: {succesful: 1}
  #   else
  #     render json: {succesful: 0}
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_vote
  #     @vote = Vote.find(params[:id])
  #   end

  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def vote_params
  #     params.require(:vote).permit(:comment_id)
  #   end
end
