namespace :domicile do
  desc "Test the functionallity of whenever implementation"
  task test_whenever: :environment do
    puts "LOGGING FROM TASK TO SOMEWHERE..."
  end
end
