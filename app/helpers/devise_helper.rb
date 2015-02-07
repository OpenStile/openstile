module DeviseHelper
 def devise_error_messages!
  return '' if resource.errors.empty?

   messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    if resource.class == RetailUser
      sentence = I18n.t('errors.messages.not_saved.retail_user_due_to_passwd',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)
    else
      sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)
    end

   html = <<-HTML
   <div class="alert alert-error alert-block"> <button type="button"
    class="close" data-dismiss="alert">x</button>
    <h4 style="color: #ff0000;">#{sentence}</h4>
    #{messages}
   </div>
   HTML

   html.html_safe
 end
end