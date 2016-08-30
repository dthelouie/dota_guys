class PlayersController < ApplicationController

  def show
    redirect_to root_path if current_user && params[:player_id].to_s == current_user.uid
    if params[:player_id].to_s.length != 17
      id = params[:player_id].to_i + 76561197960265728
    else
      id = params[:player_id].to_i
    end
    player_data = SteamWebApi::Player.new(id)
    player_profile = player_data.summary.profile
    @player = User.find_or_create_by(uid: (player_profile['steamid'].to_i - 76561197960265728).to_s, nickname: player_profile['personaname'], avatar_url: player_profile['avatarmedium'], profile_url: player_profile['profileurl'])

    if @player
      @player.load_matches!(10)
      @matches = @player.matches.order('started_at DESC')
    else
      render :player_not_found
    end

  end

end
