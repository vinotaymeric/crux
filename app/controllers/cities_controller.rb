def index
  @users = User.where(native_language: params[:native_language]) unless params[:native_language].blank?

  unless params[:tag_id].blank?
    if params[:tag_id].class == Integer
      @users = @users.joins(:taggings).where(taggings: {tag_id: params[:tag_id]})
      @users = @users.all.uniq.select { |u| (u.tags.ids & params[:tag_id].map(&:to_i)).size == params[:tag_id].size }
    else
      @tag = Tag.where(name: params[:tag_id]).first
      @users = @users.joins(:taggings).where(taggings: {tag_id: @tag.id})
    end
  end

end
