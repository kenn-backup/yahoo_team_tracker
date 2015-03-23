module ApplicationHelper

  def strip_empty(hash)
  	hash.delete_if do |key, value|
      value == "" || value == nil
  	end
  end

end
