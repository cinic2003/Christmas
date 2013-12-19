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
        token = Array.new(8){rand(1024).to_s(36)}.join
        @gift.token = token
        @gift.save
        redirect_to welcome_yeah_path(:id => @gift.id, :token => token)
      else
        redirect_to :back, :notice => '请重试一次'
      end
    else
      redirect_to :back, :notice => '请输入你的名字'
    end
  end
  
  def yeah
    @gift = Gift.find params[:id]
    unless params[:token].present? or @gift.token != params[:token]
      redirect_to :back, :notice => 'Sorry!'
    end
  end
  
  def find_who
    who = params[:who].strip
    name_arr = Gift.name_list.map{|k,v| v}
    # 名字输入是否正确
    if name_arr.include?(who)
      # 是否还有没被抽中的
      if Gift.no_done.size > 0
        # 是否已抽过
        gift = Gift.where(who: who)
        if gift.blank?
          render json: 1
        else
          render json: 0
        end
      else
        render json: 2
      end
    else
      render json: 3
    end
  end
end
