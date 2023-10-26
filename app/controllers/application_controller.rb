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
      posts_path
    end
  end

  def after_sign_out_path_for(resource)
    # Redirect the user to the `SignOutsController` index action.
    home_path
  end

  # def after_sign_out_path_for(resource_or_scope)
  #   puts '----------------------------------signed out----------------------------------'
  #   root_path(turbolinks: false, notice: "You are now signed out...")
  # end
end