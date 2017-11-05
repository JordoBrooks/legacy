module ApplicationHelper

  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info',
    }[flash_type.to_sym] || flash_type.to_s
  end

  def profile_pic_select(user, context)
    if context == 'edit'
      if user.image.exists?
        return image_tag user.image.url(:large),
                         id: 'image-preview',
                         class: 'img-responsive img-circle profile-image'
      end
      image_tag 'default-user-image-edit.jpg', id: 'image-preview',
                class: 'img-responsive img-circle profile-image'
    elsif context == 'post'
      if user.image.exists?
        return image_tag user.image.url(:thumb),
                         id: 'image-preview',
                         class: 'img-responsive img-circle profile-image'
      end
      image_tag 'default-user-image-post.jpg', id: 'image-preview',
                class: 'img-responsive img-circle profile-image'
    end
  end
end
