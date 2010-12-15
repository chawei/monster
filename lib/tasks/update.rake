namespace :update do
  desc "check if image_url is accessible."
  task :bite => :environment do
    Bite.all.each do |bite|
      bite.save
    end
  end
end