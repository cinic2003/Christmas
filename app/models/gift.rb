class Gift < ActiveRecord::Base
  # attr_accessible :name, :giving, :who, :is_done
  
  scope :no_done, ->{where(is_done: false)}
  
  def self.name_list
    lists = {}
    File.open("#{Rails.root}/config/list.yml") do |f|
      f.each_line do |line|
        arr = line.split(':')
        lists[arr[1].strip] = arr[0].strip
      end
    end
    lists
  end
  
  def self.pick_name(who)
    user = Gift.where(who: who).first
    if user.blank? and Gift.no_done.size > 0
      un_gifts = Gift.no_done.map{|g| g.id}
      index = rand(un_gifts.size)
      gift = Gift.find un_gifts[index]
      if who.present? and gift.who != who
        return gift
      else
        return false
      end
    else
      return false
    end
  end
  
end