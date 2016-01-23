class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    if (not (priority == "high" or priority == "medium" or priority == "low"))
        raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority Type"
    end
  end
  def details
    format_description(@description) + "due: " +
    format_date(@due, task: "todo") +
    format_priority(@priority)
  end
end
