module UsersHelper

  def current_user_is_family(family_id)
    kinship =  Kinship.find_by(user_id: current_user.id, family_id: family_id)
    return true if kinship
  end

end
