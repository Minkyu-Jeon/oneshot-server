class Admin::StoresController < Admin::BaseController
  before_action :find_store, only: [:edit, :update]
	def index
		set_menu("stores", "index")
		@stores = Store.all
	end

  def edit
    set_menu("stores", "edit")
  end

  def update
    if @store.update(store_params)
      redirect_to stores_path
    else
      render :edit
    end
  end

  private
  def find_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :open_time, :close_time, :address, store_images_attributes: [:id, :_destroy, :display_order, :image_cache])
  end
end
