["David", "Marie"].each do |name|
  User.find_or_create_by username: name
end

["Big", "Small"].each do |name|
  Size.find_or_create_by name: name
end

["Weekly", "Monthly", "Daily"].each do |name|
  Interval.find_or_create_by name: name
end
