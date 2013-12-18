class WelcomeController < ApplicationController
  def index
    @gift = Gift.new
    @names = Gift.name_list
  end
  
  def pick
    unless params[:who].blank?
      who = params[:who].strip
      @gift = Gift.pick_name(params[:who].strip)
      if @gift
        @gift.who = who
        @gift.is_done = true
        @gift.save
        redirect_to welcome_yeah_path(:id => @gift.id)
      else
        redirect_to :back, :notice => '请重试一次'
      end
    else
      redirect_to :back, :notice => '请输入你的名字'
    end
  end
  
  def yeah
    @gift = Gift.find params[:id]
  end
  
  def find_who
    who = params[:who].strip
    name_arr = Gift.name_list.map{|k,v| v}
    unless name_arr.include?(who).present?
      render json: 3
      return
    end
    gift = Gift.where(who: who)
    if gift.present?
      render json: 0
    else
      render json: 1
    end
  end
end
