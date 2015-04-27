# ruby-to-do-list
CRUD To-Do list built exclusively in Ruby by parsing a CSV document

```
$ ruby todo.rb add <task>
$ ruby todo.rb list
$ ruby todo.rb delete <task_id>
$ ruby todo.rb complete <task_id>
```

The CSV document is saved in this format:
```
1. [ ]  Bake a delicious blueberry-glazed cheesecake
2. [X]  Write up that memo and fax it out
3. [ ]  Conquer the world
```
