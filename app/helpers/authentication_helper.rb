module AuthenticationHelper

  # return hash digest of given string
  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # return a random token
  def new_token
    SecureRandom.urlsafe_base64
  end
end