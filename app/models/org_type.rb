class OrgType < ActiveRecord::Base
  has_and_belongs_to_many :organizations
  belongs_to :synonym_of, :class_name => 'OrgType', :foreign_key => 'effective_id'
  has_many :synonyms, :class_name => 'OrgType', :foreign_key => 'effective_id'

   def get_organizations
     Organization.find(:all, :conditions => ['x.org_type_id = ? OR org_types.effective_id = ?', self.id, self.id],
       :joins => 'INNER JOIN org_types_organizations x ON x.organization_id = organizations.id
 INNER JOIN org_types ON x.org_type_id = org_types.id')
   end

   def root_term(original_root = self)
     return self if synonym_of.nil?
     if original_root == synonym_of  # prevent cirles
       logger.error("Detected a synonym circle! starting with: #{original_root.inspect}")
       return original_root 
     end
     return synonym_of.root_term(original_root)
   end

   def OrgType.get_available
     OrgType.find(:all, :conditions => 'custom = 0 AND (effective_id IS NULL OR effective_id = id)', :order => 'name')
   end
end