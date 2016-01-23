require 'bundler/setup'
require 'chronic'
require 'colorize'
require 'highline'
require 'pp'
# Find a third gem of your choice and add it to your project
require 'date'
require_relative "lib/listable"
require_relative "lib/errors"
require_relative "lib/udacilist"
require_relative "lib/todo"
require_relative "lib/event"
require_relative "lib/link"

@lists = []
list = UdaciList.new(title: "Julia's Stuff")
list.add("todo", "Buy more cat food", due: "2016-02-03", priority: "low")
list.add("todo", "Sweep floors", due: "2016-01-30")
list.add("todo", "Buy groceries", priority: "high")
list.add("event", "Birthday Party", start_date: "2016-05-08")
list.add("event", "Vacation", start_date: "2016-05-28", end_date: "2016-05-31")
list.add("link", "https://github.com", site_name: "GitHub Homepage")
@lists << list
#
# # SHOULD CREATE AN UNTITLED LIST AND ADD ITEMS TO IT
# # --------------------------------------------------
new_list = UdaciList.new # Should create a list called "Untitled List"
new_list.add("todo", "Buy more dog food", due: "in 5 weeks", priority: "medium")
new_list.add("todo", "Go dancing", due: "in 2 hours")
new_list.add("todo", "Buy groceries", priority: "high")
new_list.add("event", "Birthday Party", start_date: "May 31")
new_list.add("event", "Vacation", start_date: "Dec 20", end_date: "Dec 30")
new_list.add("event", "Life happens")
new_list.add("link", "https://www.udacity.com/", site_name: "Udacity Homepage")
new_list.add("link", "http://ruby-doc.org")
@lists << new_list

@cli = HighLine.new
while (true)
    main_choice = @cli.ask "
1. Create a new list                        (1)
2. Add task to current list                 (2)
3. Delete item in list                      (3)
4. Delete items in list                     (4)
5. Print lists                              (5)
6. Print tasks in a specific list           (6)
7. Exit                                     (7)
What would you like to do? "
    main_choice = main_choice.to_i
    def print_list(id)
        @lists[id.to_i-1].all
    end
    def delete_item(list_id, item_id)
        @lists[list_id-1].delete(item_id-1)
    end
    def select_print_list
        list_id = @cli.ask "Id of the list:"
        print_list(list_id)
        list_id.to_i
    end
    def add_task_to_list(list_id, task_type)
        list = @lists[list_id-1]
        print_list(list_id)
        case task_type
        when 1
            event_desc = @cli.ask "Description of event: "
            list.add("event", "Life happens")
        when 2
            todo_desc = @cli.ask "Description of todo: "
            list.add("todo", todo_desc)
        else
            link_desc = @cli.ask "Description of link: "
            list.add("link", link_url)
        end
        print_list(list_id)
    end

    if (main_choice == 1)
        list_name = @cli.ask "Name of the list:"
        new_list = UdaciList.new(title: list_name.to_s)
        @lists << new_list
        puts "List #{list_name} has been created"
    elsif (main_choice == 2)
        list_id = select_print_list
        task_type = (@cli.ask "Task type:
        1. event    (1)
        2. todo     (2)
        3. link     (3)").to_i
        add_task_to_list(list_id, task_type)
    elsif (main_choice == 3)
        list_id = select_print_list
        item_id = (@cli.ask "Id of the item:").to_i
        delete_item(list_id, item_id)
        puts "Item #{item_id} has been deleted."
    elsif (main_choice == 4)
        list_id = select_print_list
        item_id_lst = @cli.ask "Ids of the items (e.g. 1, 2, 5):"
        item_id_lst = item_id_lst.split(",").map(&:strip).map(&:to_i).sort.reverse
        for item_id in item_id_lst
            delete_item(list_id, item_id)
        end
        puts "Items #{item_id_lst} has been deleted."
        print_list(list_id)
    elsif (main_choice == 5)
        @lists.each_with_index do |list, ind|
            puts "#{ind+1}. #{list.title}"
        end
    elsif (main_choice == 6)
        list_id = @cli.ask "Id of the list:"
        print_list(list_id)
    else
        break
    end
end
