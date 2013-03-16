module DeviseHelper
  def devise_error_messages!
    render :partial => 'shared/error_messages', :locals => {:object => resource}
  end
end