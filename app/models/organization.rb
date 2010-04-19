class Organization < ActiveRecord::Base
  has_many :locations, :dependent => :destroy
  belongs_to :primary_location, :class_name => 'Location'
  has_many :products_services, :dependent => :destroy, :class_name => 'ProductService'
  belongs_to :legal_structure
  belongs_to :access_rule
  has_and_belongs_to_many :org_types
  has_and_belongs_to_many :sectors
  has_and_belongs_to_many :member_orgs
  has_many :organizations_people, :dependent => :destroy
  has_many :people, :through => :organizations_people
  has_and_belongs_to_many :users

  acts_as_ferret(:fields => {
                   :name => {:boost => 2.0, :store => :yes },
                   :description => { :store => :yes },
                   :products_services_to_s => { :store => :yes }, # not working?
#                   :physical_zip => { :store => :yes },
#                   :public => { :store => :yes },
#                   :member_id => { :store => :yes }
                 } )

  acts_as_reportable

  before_save :save_ll
  
  def products_services_to_s
    self.products_services.collect{|ps| ps.name}.join(', ')
  end
  
  def set_access_rule(access_type)
    if self.access_rule.nil?
      self.access_rule = AccessRule.new(:access_type => access_type)
    else
      self.access_rule.access_type = access_type
    end
  end
  
  def accessible?(current_user)
    case self.access_rule.access_type
    when AccessRule::ACCESS_TYPE_PUBLIC # public data, always visible
      return true
    when AccessRule::ACCESS_TYPE_LOGGEDIN # only visible if the current user is logged in
      return true unless current_user.nil?
    when AccessRule::ACCESS_TYPE_PRIVATE  # only visible to the entry's editor(s)
      return true if self.users.include?(current_user)
    else
      throw "Unknown access type: '#{self.access_rule.access_type}'"
    end
    # if access was not grated above, it is denied by default
    return false
  end
  
  def public
    self.access_rule.access_type == AccessRule::ACCESS_TYPE_PUBLIC
  end
  
  def longitude
    if self.primary_location
      self.primary_location.longitude
    else
      nil
    end
  end
  
  def latitude
    if self.primary_location
      self.primary_location.latitude
    else
      nil
    end
  end
  
  def save_ll
    self.locations.each do |loc|
      loc.save_ll
      loc.save(false)
    end
  end

  def self.latest_changes
    user = User.current_user
    conditions = if user && user.is_admin?
                   nil
#TODO
#                 elsif user && user.member
#                   ['member_id is NULL or member_id = ?', user.member.id]
#                 else
#                   ['member_id is NULL']
                 end

    Organization.find(:all, :order => 'updated_at DESC', 
               :limit => 15,
               :conditions => conditions)
  end
  
	def create_address(attr)
		l = self.locations.create(attr)
		l.save!
		if self.locations.length == 1 then	# if this is the first address added, make it primary
			self.primary_location_id = l.id
			self.save(false)
		end
		return l
	end
end
