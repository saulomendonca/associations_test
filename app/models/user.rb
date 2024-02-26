class User < ApplicationRecord
  has_and_belongs_to_many :roles


  def update_model_and_roles(params)
    new_role_ids = params[:role_ids]

    member_role_id = Role.where(name: "member").pick(:id)

    old_roles_ids = Role.joins(:users)
      .where(users: { id: self.id })
      .pluck(:id)

    old_roles_is_member = old_roles_ids.all? member_role_id
    new_roles_is_member = new_role_ids.all? member_role_id

    if old_roles_is_member && !new_roles_is_member
      errors.add(:roles, :member_roles_cannot_be_changed)
      return false
    end

    self.update(params)
  end
end
