class Activity < ActiveRecord::Base
  enum target_type: [:learned, :learning]
end
