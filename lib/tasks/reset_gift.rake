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
end
