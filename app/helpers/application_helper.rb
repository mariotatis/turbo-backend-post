module ApplicationHelper
  def turbo?
    request.user_agent.include?("Turbo")
  end

end