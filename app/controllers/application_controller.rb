class ApplicationController < ActionController::Base
  
  def turbo_visit(url, frame: nil, action: nil)
    options = {frame: frame, action: action}.compact
    turbo_stream.append_all("head") do
      helpers.javascript_tag(<<~SCRIPT.strip, nonce: true, data: {turbo_cache: false})
        window.Turbo.visit("#{helpers.escape_javascript(url)}", #{options.to_json})
        document.currentScript.remove()
      SCRIPT
    end
  end
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      resource.update(token: SecureRandom.hex)
      request.user_agent.include?("Turbo Native") ?  posts_path(token: resource.token) :  posts_path
      posts_path
    end
  end

  def after_sign_out_path_for(resource)
    home_path
  end
  
end