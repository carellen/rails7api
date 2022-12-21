class ListBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :shared, :created_at, :updated_at
  association :list_items, blueprint: ListItemBlueprint
end
