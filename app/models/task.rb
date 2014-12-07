class Task < ActiveRecord::Base
  belongs_to :size
  belongs_to :interval
  belongs_to :user

  validates :text, presence: true
  validates :size, presence: true
  validates :interval, presence: true
  validates :user, presence: true

  def assigned
    user
  end

  [:interval, :size, :assigned].each do |prefix|
    define_method("#{prefix.to_s}_name") do
      send(prefix).name
    end
  end
end
