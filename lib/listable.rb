module Listable
  def format_description(description)
      "#{description}".ljust(30)
  end
  def format_date(date, options={})
      task = options[:task]
      if (task == "event")
          end_data = options[:end_date] || nil
          dates = date.strftime("%D") if date
          dates << " -- " + end_date.strftime("%D") if end_date
          dates = "N/A" if !dates
          return dates
      else
          date ? date.strftime("%D") : "No due date"
      end
  end
  def format_priority(priority)
      value = " ⇧" if priority == "high"
      value = " ⇨" if priority == "medium"
      value = " ⇩" if priority == "low"
      value = "" if !priority
      return value
  end
end
