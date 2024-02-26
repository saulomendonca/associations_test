class User < ApplicationRecord
  has_and_belongs_to_many :roles
  validate :can_change_role?

  def role_ids=(new_role_ids)
    @can_change_roles = true
    member_role = Role.select(:id).find_by(name: Rails.configuration.default_roles.find { |r| r[:is_member] }[:name])

    if self.role_ids.all? member_role.id
      @can_change_roles = new_role_ids.all?(member_role.id)
      return
    end

    super new_role_ids
  end

  private

  def can_change_role?
    return if @can_change_roles

    errors.add(:roles, :member_roles_cannot_be_changed)
  end
end
