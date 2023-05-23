class Admin::ItemsController < ApplicationController
  def new
    @form = Item.new
  end

  def create
    @form = Item.new(item_params)
    # 商品のカラムが存在するかどうかのif文
    if params[:item][:name].present? && params[:item][:price].present? && params[:item][:detail].present? && params[:item][:genre_id].present? && params[:item][:image].present?
      if @form.save
        redirect_to admin_item_path(@form)
        flash[:success] = "商品を登録しました"
      else
        flash[:danger] = "必要情報を入力してください"
        render :new
      end 
    else
      unless @form.save
        flash[:danger] = "必要情報を入力してください"
        render :new
      end 
    end
  end

  def index
    @items = Item.page(params[:page])
    @form = Item.new
  end
  
  def show 
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end 
  
  def update
    @item = Item.find(params[:id])
    if params[:item][:name].present? && params[:item][:price].present? && params[:item][:detail].present? && params[:item][:genre_id].present? && params[:item][:image].present?
      if @form.update
        redirect_to admin_item_path(@form)
        flash[:success] = "商品を更新しました"
      else
        flash[:danger] = "必要情報を入力してください"
        render :edit
      end 
    else
      unless @form.update(item_params)
        flash[:danger] = "必要情報を入力してください"
        render :edit
      end 
    end
    @item.update(item_params)
    redirect_to admin_item_path(@item)
  end 
  
  private

  def item_params
    params.require(:item).permit(:name,:detail,:price,:image, :genre_id, :is_selling)
  end

end
