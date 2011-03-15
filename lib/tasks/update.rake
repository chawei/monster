namespace :update do
  desc "check if image_url is accessible."
  task :bite => :environment do
    Bite.all.each do |bite|
      bite.save
    end
  end
  
  desc "save domain_name"
  task :bite_domain_name => :environment do
    Bite.where(:domain_name => nil).find_in_batches do |bites|
      bites.each do |bite|
        bite.get_domain_name
        if bite.save
          puts "== ID: #{bite.id} DOMAIN: #{bite.domain_name}"
        else
          puts "Error"
        end
      end
    end
  end
  
  desc "create photo by image_url"
  task :bite_photo => :environment do
    Bite.accessible.without_photo.readonly(false).find_in_batches(:batch_size => 100) do |bites|
      bites.each do |bite|
        bite.create_photo_by_image_url
        puts "== ID: #{bite.id} URL: #{bite.normalized_image_url} DOMAIN: #{bite.photo.try(:data).try(:url)}"
      end
    end
  end
  
  
end