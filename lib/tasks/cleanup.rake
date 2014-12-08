namespace :cleanup do
  task daily: :environment do
    tasks = Interval.find_by(name: "Daily").tasks

    daily do
      tasks.each do |task|
        task.done = nil
        task.save!
      end
    end

    weekly do
      swap_who_is_in_chage_of_task(tasks)
    end
  end

  task weekly: :environment do
    weekly do
      tasks = Interval.find_by(name: "Weekly").tasks

      swap_who_is_in_chage_of_task(tasks)

      tasks.each do |task|
        task.done = nil
        task.save!
      end
    end
  end

  task monthly: :environment do
    monthly do
      tasks = Interval.find_by(name: "Monthly").tasks

      swap_who_is_in_chage_of_task(tasks)

      tasks.each do |task|
        task.done = nil
        task.save!
      end
    end
  end
end

def swap_who_is_in_chage_of_task(tasks)
  david = User.find_by(username: "David")
  marie = User.find_by(username: "Marie")

  davids_tasks = tasks.select { |task| task.assigned == david }
  maries_tasks = tasks.select { |task| task.assigned == marie }

  davids_tasks.each { |task| task.user = marie }
  maries_tasks.each { |task| task.user = david }
end

def daily(&block)
  block.call
end

def weekly(&block)
  if Time.now.monday?
    block.call
  end
end

def monthly(&block)
  if Time.now.day == 1
    block.call
  end
end
