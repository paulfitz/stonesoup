# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define() do

  create_table "entries", :force => true do |t|
    t.column "name", :string
    t.column "physical_address1", :string
    t.column "physical_address2", :string
    t.column "physical_city", :string
    t.column "physical_state", :string
    t.column "physical_zip", :string
    t.column "physical_country", :string
    t.column "mailing_address1", :string
    t.column "mailing_address2", :string
    t.column "mailing_city", :string
    t.column "mailing_state", :string
    t.column "mailing_zip", :string
    t.column "mailing_country", :string
    t.column "phone1", :string
    t.column "phone2", :string
    t.column "fax", :string
    t.column "email", :string
    t.column "website", :string
    t.column "preferred_contact", :string
    t.column "description", :text
    t.column "created_at", :datetime
    t.column "updated_at", :datetime
    t.column "created_by_id", :integer
    t.column "updated_by_id", :integer
  end

end
