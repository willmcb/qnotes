class CollectionsController < ApplicationController
  before_action :authorize

  def index
    @collections = current_user.collections.all_by_name
  end

  def new
    @collection = Collection.new
  end

  def show
    @collection = current_user.collections.find(params[:id])
    @notes = @collection.notes
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
    params.require(:collection).permit(:name, :id)
  end
end

