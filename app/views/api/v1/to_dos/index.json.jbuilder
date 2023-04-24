json.to_dos do
  json.array! @to_dos, :id, :title, :body, :end_date, :created_at, :updated_at
end