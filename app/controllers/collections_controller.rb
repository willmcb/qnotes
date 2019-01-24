class CollectionsController < ApplicationController
  before_action :authorize

  def index
    @collections = Collection.all
  end

  def new
    @Collection = Collection.new
  end

  def create
    collection = current_user.collections.new(name: collection_params[:name])

    if collection.save!
        flash[:notice] = "Collection has been saved"
    else
      flash[:notice] = collection.errors.full_messages.join(", ")
    end
    redirect_to collections_path
  end

  private

  def collection_params
    params.permit(:name)
  end
end

