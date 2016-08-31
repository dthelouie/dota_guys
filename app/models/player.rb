class Player < ActiveRecord::Base

  belongs_to :match

  serialize :hero
  serialize :items


  def kda
    if self.deaths == 0
      ratio = self.kills + self.assists
    else
      ratio = (self.kills.to_f + self.assists.to_f) / deaths.to_f
      ratio = ratio.round(1)
    end
    return ratio
  end


  def get_profile
    player = SteamWebApi::Player.new(self.uid.to_i + 76561197960265728)
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
    status != 'played'
  end

end
