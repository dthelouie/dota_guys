class User < ActiveRecord::Base
  def from_omniauth(auth)
    STEAM_64_BIT_TO_32_BIT_CONVERSION = 76561197960265728
    info = auth['info']
    user = find_or_initialize_by(uid: (auth['uid'].to_i - STEAM_64_BIT_TO_32_BIT_CONVERSION).to_s)
    user.nickname = info['nickname']
    user.avatar_url = info['image']
    user.profile_url = info['urls']['Profile']
    user.save!
    user
  end
end
