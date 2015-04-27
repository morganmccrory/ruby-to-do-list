# PSEUDOCODE
# 1. Initialize an empty TODO list ( list = List.new)
# 2. Add a task (list.add(Task.new("walk the dog")))
# 3. Get the tasks from the list (tasks = list.tasks)
# 4. Delete a task from the list (list.delete(specific_task))
# 5. Complete a task from the list (list.completed(specific_task))

require 'csv'
require 'time'

class Task
  attr_reader :task, :brackets, :creation_date, :completed_date
  def initialize(task_details)
    @task = task_details[0]
    @brackets = task_details[1] ||= "[ ]"
    @creation_date = task_details[2] ||= Time.now
    @completed_date = task_details[3] ||= "Not Complete"
  end
end

class List
  attr_reader :task
  attr_accessor :brackets

  def get_list_from_csv(filepath)
    return @list if @list
    @list = []
    CSV.foreach(filepath) do |row|
      @list << Task.new(row)
    end
    @list
  end

  def save
    CSV.open("todo.csv", "wb") do |csv|
      @list.map do |item|
        csv << [item.task, item.brackets, item.creation_date, item.completed_date]
      end
    end
  end

  def list
    @list.each do |row|
      puts "#{@list.index(row)+1}. #{row.brackets} #{row.task}, #{row.creation_date}, #{row.completed_date}"
    end
  end

  def add(task)
    puts "Added \"#{task}\" to your TODO list."
    @list << Task.new([task])
    save
  end

  def delete(number)
    puts "Deleted \"#{@list[number.to_i-1].task}\" from your TODO list."
    @list.delete_at(number.to_i-1)
    save
  end

  def completed(number)
    @completed_date = Time.now
    puts "\"#{@list[number.to_i-1].task}\" has been marked as completed."
    @list[number.to_i-1].brackets[0..-1] = "[X]"
    save
  end

  def list_outstanding
    @list.reverse_each do |row|
      puts "#{@list.index(row)+1}. #{row.brackets} #{row.task}"
    end
  end

  def list_completed
  end
end

list = List.new
list.get_list_from_csv('todo.csv')

if ARGV[0] == "list"
  list.list
elsif ARGV[0] == "add"
  ARGV.delete_at(0)
  list.add(ARGV.join" ")
  list.list
elsif ARGV[0] == "delete"
  list.delete(ARGV[1])
  list.list
elsif ARGV[0] == "completed"
  list.completed(ARGV[1])
  list.list
elsif ARGV[0] == "list:outstanding"
  list.list_outstanding
elsif ARGV[0] == "list:completed"
  list.list_completed
end
