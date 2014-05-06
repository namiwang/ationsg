module StatesLocaleHelper
  def locale_state(model, state)
    t "activerecord.attributes.#{model}.states.#{state}"
  end
end