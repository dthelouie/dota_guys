class PlayersController < ApplicationController

  def show

    player_data = SteamWebApi::Player.new(params[:player_id].to_i + 76561197960265728)
    player_profile = player_data.summary.profile
    @player = User.find_or_create_by(uid: (player_profile['steamid'].to_i - 76561197960265728).to_s, nickname: player_profile['personaname'], avatar_url: player_profile['avatarmedium'], profile_url: player_profile['profileurl'])
    @player.load_matches!(5)

    @matches = @player.matches.order('started_at DESC')

  end

end
