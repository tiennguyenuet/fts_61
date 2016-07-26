module ApplicationHelper
  def full_title page_title = ""
    base_title = t "helpers.base_title"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, "#", class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def calculate_spent_time examination
    if examination.time_end - examination.time_start < examination.subject.duration * Settings.MINUTE
      time = examination.time_end - examination.time_start
    else
      time = examination.duration * Settings.MINUTE
    end
    Time.at(time).utc.strftime Settings.TIME_FORMAT
  end

  def default_spent_time examination
    if examination.start? or examination.time_end.nil?
      content_tag :p, I18n.t("controllers.exams_controller.default_spent_time")
    else
      calculate_spent_time examination
    end
  end
end
