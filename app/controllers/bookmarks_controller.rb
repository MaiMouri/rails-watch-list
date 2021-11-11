class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]

  def index
    @bookmarks = Bookmark.all
  end

  def show
    @bookmark = Bookmark.find(param[:id])
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    # Fill the instances
    @bookmark.list = @list

    if @bookmark.save
      # if succeed, go to the list(the instance)
      redirect_to list_path(@list)
    else
      # if faile, reload and try again
      render :new
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  # def set_bookmark
  #   @bookmark = Bookmark.find(params[:id])
  # end

  def set_list
    @list = List.find(params[:list_id])
  end

end
