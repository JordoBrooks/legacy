module PostsHelper

  def display_form_image_or_placeholder(post)
    if post.image.exists?
      image_tag(post.image.url(:medium), id: 'image-preview', class: 'img-responsive ')
    else
      image_tag('placeholder-post-img.jpg', id: 'image-preview', class: 'img-responsive ')
    end
  end

  def likers_of(post)
    votes = post.votes_for.up.by_type(User)
    users = []
    unless votes.blank?
      votes.voters.each do |voter|
        users.push(link_to voter.first_name + ' ' + voter.last_name,
                                user_path(voter),
                                class: 'user-name-like')
      end
      return 'Liked by '.html_safe + likers_condensed(users)
    end
  end

  def likers_condensed(users)
    if users.length > 3
      user_subset = users.take(3)
      num_leftover = users.length - 3
      return user_subset.to_sentence.html_safe + " and #{num_leftover} others"
    else
      return users.to_sentence.html_safe
    end
  end

end
