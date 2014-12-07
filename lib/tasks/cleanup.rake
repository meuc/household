namespace :cleanup do
  ["weekly", "daily", "monthly"].each do |interval|
    desc "Check #{interval} tasks as not done"
    task interval.to_sym => :environment do
      tasks = Interval.find_by(name: interval.titleize).tasks

      tasks.each do |task|
        task.done = nil
        task.save!
      end
    end
  end
end
