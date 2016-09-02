class PlayersController < ApplicationController

  def show
    redirect_to root_path if current_user && params[:player_id].to_s == current_user.uid
    if params[:player_id].to_s.length != 17
      id = params[:player_id].to_i + steam_id_conversion
    else
      id = params[:player_id].to_i
    end
    player_data = SteamWebApi::Player.new(id)
    if player_data.summary.success == false
      render :player_not_found
    else
      player_profile = player_data.summary.profile
      @player = User.find_or_initialize_by(uid: (player_profile['steamid'].to_i - steam_id_conversion).to_s)
      if (@player.nickname != player_profile['personaname'] || @player.avatar_url != player_profile['avatarmedium'] || @player.profile_url != player_profile['profileurl'])
        @player.nickname = player_profile['personaname']
        @player.avatar_url = player_profile['avatarmedium']
        @player.profile_url = player_profile['profileurl']
        @player.save!
      end

      @player.load_matches!(10)
      @matches = @player.matches.order('started_at DESC')
      render :player_not_found if @matches.empty?
    end

  end

end
