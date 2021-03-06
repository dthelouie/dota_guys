class Player < ActiveRecord::Base

  belongs_to :match

  serialize :hero
  serialize :items


  def kda
    if self.deaths == 0
      ratio = self.kills.to_f + self.assists.to_f
    else
      ratio = (self.kills.to_f + self.assists.to_f) / deaths.to_f
    end
    return ratio.round(1)
  end


  def get_profile
    player = SteamWebApi::Player.new(self.uid.to_i + steam_id_conversion)
    if player.summary.success
      @profile = player.summary.profile
    else
      return false
    end
  end

  def nickname
    unless @profile
      get_profile
    end
    if @profile
      return @profile['personaname']
    else
      return "some random DotaGuy"
    end
  end

  def avatar
    unless @profile
      get_profile
    end
    if @profile
      return @profile['avatarmedium']
    end
  end


  def abandoned_or_not_connected?
    status != 'Played'
  end

  private
  def steam_id_conversion
    return 76561197960265728
  end

end
