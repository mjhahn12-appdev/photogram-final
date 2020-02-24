class PhotosController < ApplicationController
  def index
    render({ :template=> "layouts/index.html.erb"})
  end
end
