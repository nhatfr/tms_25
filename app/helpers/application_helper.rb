module ApplicationHelper
  def full_title page_title = ''
    base_title = t(:welcome)
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  
  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0);", onclick: h("remove_fields(this)"))
  end
  
  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render association.to_s.singularize + "_fields", f: builder
    end
    link_to name, "#", 
    onclick: h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), remote: true 
  end

  def user_task user_id, task_id
    UserTask.find_by user_id: user_id, task_id: task_id
  end

  def user_subject user_id, subject_id
    UserSubject.find_by user_id: user_id, subject_id: subject_id
  end
end
