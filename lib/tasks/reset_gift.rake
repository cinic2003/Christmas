#encoding:utf-8

namespace :chirs do
  desc '重置所有'
  task :reset_gift => :environment do |t, args|
    Gift.update_all(:who => nil, :is_done => false)
  end
  
  desc '插入名字'
  task :insert_name => :environment do |t, args|
    Gift.name_list.each do |key, val|
      Gift.create(:name => val, :is_done => false)
    end
  end
  
  desc '删除所有名字'
  task :delete_name => :environment do |t, args|
    Gift.delete_all
  end
  
  desc '备份数据'
  task :backup => :environment do |t, args|
    File.open("#{Rails.root}/config/data", 'w') do |f|
      Gift.all.each do |gift|
        f.puts("#{gift.name}|#{gift.giving}|#{gift.talk}|#{gift.who}")
      end
    end
  end
  
  desc '恢复数据'
  task :rebuild => :environment do |t, args|
    File.open("#{Rails.root}/config/data") do |f|
      f.each_line do |line|
        arr = line.strip.split('|')
        gift = Gift.find_or_create_by(name: arr[0])
        if gift
          gift.giving = arr[1] if arr[1].present?
          gift.talk = arr[2] if arr[2].present?
          if arr[3].present? 
            gift.who = arr[3]
            gift.is_done = true
          else
            gift.is_done = false
          end
          gift.save
        end
      end
    end
  end
  
end
