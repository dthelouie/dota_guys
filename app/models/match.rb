class Match < ActiveRecord::Base
  belongs_to :user
  has_many :players, dependent: :delete_all

  def load_players!(radiant, dire)
    roster = {radiant: radiant, dire: dire}
    roster.each_pair do |k, v|
      v.players.each do |player|
        self.players.create({
                              uid: player.id,
                              items: player.items.delete_if {
                                  |item| item.name == "Empty"
                              }.map  {
                                  |item| {id: item.id, name: item.name, image: item.image_url}
                              },
                              hero: {id: player.hero.id,
                                     name: player.hero.name,
                                     image: player.hero.image_url(:lg)},
                              level: player.level,
                              kills: player.kills,
                              deaths: player.deaths,
                              assists: player.assists,
                              last_hits: player.last_hits,
                              denies: player.denies,
                              gold: player.gold,
                              gpm: player.gpm,
                              xpm: player.xpm,
                              status: player.status.to_s.titleize,
                              gold_spent: player.gold_spent,
                              hero_damage: player.hero_damage,
                              tower_damage: player.tower_damage,
                              hero_healing: player.hero_healing,
                              slot: player.slot,
                              radiant: k == :radiant
                          })
      end
    end
  end

  def formatted
    self.started_at.strftime("%-m/%d/%Y, %l:%M %p %z")
  end

end
