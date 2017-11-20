module ApplicationHelper

  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
    }[flash_type.to_sym] || flash_type.to_s
  end

  def profile_pic_select(user, context)
    if context == 'profile'
      if user.image.exists?
        return image_tag user.image.url(:large),
                         id: 'image-preview',
                         class: 'img-responsive img-circle profile-image'
      end

      if current_user?(user)
        image_tag 'default-user-image-edit.jpg', id: 'image-preview',
                  class: 'img-responsive img-circle profile-image'
      else
        image_tag 'default-user-image.jpg', id: 'image-preview',
                  class: 'img-responsive img-circle profile-image'
      end

    elsif context == 'edit'
      if user.image.exists?
        return image_tag user.image.url(:large),
                         id: 'image-preview',
                         class: 'img-responsive img-circle edit-profile-image'
      end
      image_tag 'default-user-image-edit.jpg', id: 'image-preview',
                class: 'img-responsive img-circle edit-profile-image'

    elsif context == 'post'
      if user.image.exists?
        return image_tag user.image.url(:thumb),
                         class: 'img-responsive img-circle post-top-img'
      end
      image_tag 'default-user-image-post.jpg',class: 'img-responsive img-circle post-top-img'
    end
  end
end
