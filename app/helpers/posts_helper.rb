module PostsHelper

  def display_form_image_or_placeholder(post)
    if post.image.exists?
      image_tag(post.image.url(:medium), id: 'image-preview', class: 'img-responsive ')
    else
      image_tag('placeholder-post-img.jpg', id: 'image-preview', class: 'img-responsive ')
    end
  end

end
