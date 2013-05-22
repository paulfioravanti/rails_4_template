def create_users
  puts "Seeding Users..."
  admin = User.create!(
    name: "<%= ENV['USER'] || ENV['USERNAME'] || 'Example User' %>".capitalize,
    email: "<%= ENV['USER'] || ENV['USERNAME'] || "\
           "'Example User' %>@example.com",
    password: "foobar",
    password_confirmation: "foobar")
  admin.toggle!(:admin)
end

create_users