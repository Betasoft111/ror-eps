class AddNoOfProfilesToUsersStaffPlans < ActiveRecord::Migration
  def change
    add_column :users_staff_plans, :no_of_profiles, :integer
  end
end
