module Providers
  module JwtAuth
    ALGORITHM = 'HS256'
    JWT_SECRET = ENV.fetch('jwt_secret', '$default$')
    EXPIRE_AFTER = 24.hours

    module_function

    def authenticate(token:)
      payload, _ = JWT.decode(token, JWT_SECRET, true, { algorithm: ALGORITHM })
      user = User.find_by(id: payload['user_id'])

      if user&.active_tokens.include? payload['jti']
        { result: user }
      else
        { error: 'User unauthorized' }
      end
    rescue JWT::ExpiredSignature => e
      logout(token: token)
      { error: e }
    rescue JWT::DecodeError => e
      { error: e }
    end

    def login(user:)
      iat = Time.now.to_i
      jti_raw = [JWT_SECRET, iat].join(':').to_s
      jti = Digest::MD5.hexdigest(jti_raw)
      payload = {
        exp: EXPIRE_AFTER.from_now.to_i,
        jti: jti,
        user_id: user.id
      }

      user.active_tokens |= [jti]
      user.save!

      { result: JWT.encode(payload, JWT_SECRET, ALGORITHM) }
    end

    def logout(token:)
      payload, _ = JWT.decode(token, JWT_SECRET, false, { algorithm: ALGORITHM })
      user = User.find_by(id: payload['user_id'])
      return { error: 'User not found' } unless user

      user.active_tokens -= [payload['jti']]

      { result: user.save }
    rescue JWT::DecodeError => e
      { error: e }
    end
  end
end
