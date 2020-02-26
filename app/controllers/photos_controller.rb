class PhotosController < ApplicationController
  def index
    @photos = Photo.all
    render({ :template => "photos/all_photos.html.erb"})
  end

  def create
    user_id = session.fetch(:user_id)
    image = params.fetch("input_image")
    caption = params.fetch("input_caption")
    photo = Photo.new
    photo.owner_id = user_id
    photo.image = image
    photo.caption = caption
    photo.save
    redirect_to("/photos/#{photo.id}")
  end

  def show
    if (session[:current_user_id] == nil)
      redirect_to("/user_sign_in")
      return
    end
    p_id = params.fetch("the_photo_id")
    @photo = Photo.where({:id => p_id }).first
    render({:template => "photos/details.html.erb"})
  end

  def destroy
    id = params.fetch("the_photo_id")
    photo = Photo.where({ :id => id }).at(0)
    photo.destroy

    redirect_to("/photos")
  end

  def update
    id = params.fetch("the_photo_id")
    photo = Photo.where({ :id => id }).at(0)
    photo.caption = params.fetch("input_caption")
    photo.image = params.fetch("input_image")
    photo.save

    redirect_to("/photos/#{photo.id}")
  end

  def addlike
    like = Like.new
    like.fan_id = session[:current_user_id]
    like.photo_id = params["query_photo_id"].to_i
    like.save

    redirect_to("/photos/#{like.photo_id}")
  end

  def deletelike
    like = Like.where({ :id => params["like_id"]}).at(0)
    like.destroy

    redirect_to("/photos/#{like.photo_id}")
  end

end
