class AdminSeeder
  ADMIN = [
    {
      first_name: "Admin",
      last_name: "Head",
      email: "admin@gmail.com",
      role: "admin",
      password: "password",
      password_confirmation: "password",
      area_code: 510,
      first_digits: 499,
      last_digits: 9210
    }
  ]

  def self.seed!
    ADMIN.each do |admin_params|
      first_name = admin_params[:first_name]
      admin = User.find_or_initialize_by(first_name: first_name)
      admin.assign_attributes(admin_params)
      admin.save!
    end
  end
end
