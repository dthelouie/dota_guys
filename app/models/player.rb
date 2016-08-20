class Player < ActiveRecord::Base

  belongs_to :match

  serialize :hero
  serialize :items


  def kda
    ratio = (self.kills.to_f + self.assists.to_f) / self.deaths.to_f
    ratio.round(1)
  end


  def abandoned_or_not_connected?
    status != 'played'
  end

end
