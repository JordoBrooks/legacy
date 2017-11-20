class KinshipController < ApplicationController

  before_action :set_user

  def create
    if build_kinship
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def destroy
    destroy_kinship
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end


  private

  def build_kinship
    @kinship1 = current_user.kinship.build(family_id: params[:family_id])

    family_member = @user
    @kinship2 = family_member.kinship.build(family_id: current_user.id)

    if @kinship1.save && @kinship2.save
      true
    else
      kinship1 = current_user.kinship.find(family_id: params[:family_id])
      kinship2 = family_member.kinship.find(family_id: current_user.id)
      if kinship1.nil?
        kinship1.destroy
      elsif kinship2.nil?
        kinship2.destroy
      end
      false
    end
  end

  def destroy_kinship
    @kinship1 = current_user.kinship.find_by(family_id: params[:family_id])

    family_member = @user
    @kinship2 = family_member.kinship.find_by(family_id: current_user.id)

    @kinship1.destroy
    @kinship2.destroy
  end

  def set_user
    @user = User.find(params[:family_id])
  end

end
