namespace :cleanup do
  ["weekly", "daily", "monthly"].each do |interval|
    desc "Check #{interval} tasks as not done"
    task interval.to_sym => :environment do
      send interval.to_sym do
        tasks = Interval.find_by(name: interval.titleize).tasks

        tasks.each do |task|
          task.done = nil
          task.save!
        end
      end
    end
  end
end

def daily(&block)
  block.call
end

def weekly(&block)
  if Time.now.monday?
    block.call
  else
    puts "Not time for weekly task"
  end
end

def monthly(&block)
  if Time.now.day == 1
    block.call
  else
    puts "Not time for monthly task"
  end
end
