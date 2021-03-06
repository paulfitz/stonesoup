class OrganizationsPerson < ActiveRecord::Base
  belongs_to :organization
  belongs_to :person

  validates_presence_of :organization_id, :person_id

  def to_s
    "#{person} at #{organization} as #{role_name} [#{phone} / #{email}]"
  end

  def <=>(other)
    self.to_s <=> other.to_s
  end
end
