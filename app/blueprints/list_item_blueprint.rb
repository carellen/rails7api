class ListItemBlueprint < Blueprinter::Base
  identifier :id

  fields :short_name, :status, :description, :created_at, :updated_at
end
