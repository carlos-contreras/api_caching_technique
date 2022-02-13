class ApiFilter
  def self.call(response)
    response.select { |r| r.fetch(:is_billable) }
  end
end
