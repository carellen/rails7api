class ListItem < ApplicationRecord
  belongs_to :list

  acts_as_paranoid

  enum status: { not_started: 0, in_progress: 1, completed: 9 }
end
