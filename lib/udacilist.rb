class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    # validate type
    if (not (type == "todo" or type == "event" or type == "link"))
        raise UdaciListErrors::InvalidItemType, "Invalid task type"
    end
    @items.push [type, TodoItem.new(description, options) ] if type == "todo"
    @items.push [type, EventItem.new(description, options)]  if type == "event"
    @items.push [type, LinkItem.new(description, options) ] if type == "link"
  end
  def delete(index)
    # check if index higher than items size
    if (index > index)
        raise UdaciListErrors::IndexExceedsListSize, "Index Out of Bounds"
    end
    @items.delete_at(index - 1)
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item[1].details}"
    end
  end
  def filter(task_type)
    filtered_tasks = []
    @items.each do |item|
      if(item[0] == task_type)
        filtered_tasks << item[1]
      end
    end
    if (filtered_tasks.empty?)
      puts "No items of type #{task_type} have been found."
    else
      cnt = 1
      msg = "Tasks filtered by #{task_type}"
      puts "-" * msg.length
      puts msg
      puts "-" * msg.length
      for result in filtered_tasks
        puts "#{cnt}) #{result.details}"
        cnt += 1
      end
    end
  end
end
