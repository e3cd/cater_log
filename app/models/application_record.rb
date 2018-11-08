class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  #Function to remove whitespace from user input
  def remove_whitespace
    attribute_names.each do |name|
      if send(name).respond_to?(:strip)
        send("#{name}=", send(name).strip)
      end
    end
  end
end
