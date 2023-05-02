5.times do |index|
  Task.create!({ title: "Todo #{index + 1}", completed: false})
end

puts "5 uncompleted tasks created"

5.times do |index|
  Task.create!({ title: "Todo #{index + 1}", completed: true})
end

puts "5 completed tasks created"