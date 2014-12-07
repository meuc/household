set :output, "#{path}/log/cron.log"

every 1.day do
  rake "cleanup:daily"
end

every 1.week do
  rake "cleanup:weekly"
end

every 1.month do
  rake "cleanup:monthly"
end
