require 'faker'

Faker::Config.locale = 'en-US'

RECORDS = 252.times.map do |index|
  {
    ehr_id: Faker::Code.npi,
    name: Faker::Name.name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.cell_phone,
    gender: Faker::Gender.binary_type,
    is_billable: Faker::Boolean.boolean
  }
end

class ApiMock
  def self.call(page, per_page)
    RECORDS.slice(page * per_page, per_page) || []
  end
end
