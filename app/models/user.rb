class User < ActiveRecord::Base
  has_many :matches

  class << self
    def from_omniauth(auth)
      info = auth['info']
      user = self.find_or_initialize_by(uid: (auth['uid'].to_i - steam_id_conversion).to_s)
      user.nickname = info['nickname']
      user.avatar_url = info['image']
      user.profile_url = info['urls']['Profile']
      user.save!
      user
    end

    def steam_id_conversion
      return 76561197960265728
    end

  end

  def load_matches!(count)
    matches_arr = Dota.api.matches(player_id: self.uid, limit: count)
    if matches_arr && matches_arr.any?
      matches_arr.each do |match|
        unless self.matches.where(uid: match.id).any?
          match_info = Dota.api.matches(match.id)
          new_match = self.matches.create({
                                            uid: match.id,
                                            winner: match_info.winner.to_s.titleize,
                                            first_blood: parse_duration(match_info.first_blood),
                                            started_at: match_info.starts_at,
                                            mode: match_info.mode,
                                            cluster: match_info.cluster,
                                            duration: parse_duration(match_info.duration),
                                            match_type: match_info.type
                                          })
                                          new_match.load_players!(match_info.radiant, match_info.dire)
        end
      end
    end
  end

  def won?(match)
    player = find_self_in(match)
    (player.radiant? && match.winner == 'Radiant') ||(!player.radiant? && match.winner == 'Dire')
  end

  def played_for_in(match)
    Rails.cache.fetch(self.uid + '_played_for_in_' + match.uid) {find_self_in(match).hero}
  end

  private

  def find_self_in(match)
    match.players.find_by(uid: uid)
  end

  def parse_duration(d)
    hr = (d/3600).floor
    min = ((d- (hr * 3600)) / 60).floor
    sec = (d - (hr * 3600) - (min * 60)).floor

    hr = '0' + hr.to_s if hr.to_i < 10
    min = '0' + min.to_s if min.to_i < 10
    sec = '0' + sec.to_s if sec.to_i < 10

    hr.to_s + ':' + min.to_s + ':' + sec.to_s
  end

end
