class Entry < ApplicationRecord
  belongs_to :blog, counter_cache: true
  has_many :comments
end
