class MatchesController < ApplicationController

  def index
    if current_user
      current_user.load_matches!(10)
      @matches = current_user.matches.order('started_at DESC')
    end
  end

  def show
    @match = Match.find_by(id: params[:id])
    @players = @match.players.order('slot ASC').group_by(&:radiant)
  end

end
