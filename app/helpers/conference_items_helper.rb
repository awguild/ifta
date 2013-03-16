module ConferenceItemsHelper
  
  def display_conf_item(item)
    row = "<tr><td>" + item.name + add_description(item) + ": </td>"
    if item.multiple
      if item.max.nil? || item.max > 5
        row += add_dropdown item
      else
        row += add_textbox item
      end
    else
      row += add_checkbox item
    end
    row += "</tr>"
  end
  
  def add_description(item)
    if item.description.blank?
      return ""
    else
      "<br>More Details" 
    end
  end
  
  def add_checkbox(item)
    "<td>$" + item.price.to_s + "</td><td>Checkbox</td>"
  end
  
  def add_dropdown(item)
    
  end
  
  def add_textbox(item)
    
  end
end
