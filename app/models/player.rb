class Player < ActiveRecord::Base

  belongs_to :match

  serialize :hero
  serialize :items


  def abandoned_or_not_connected?
    status != 'played'
  end
  
end
