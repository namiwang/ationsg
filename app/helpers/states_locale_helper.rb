module StatesLocaleHelper
  def locale_state(model, state)
    t "activerecord.attributes.#{model}.states.#{state}"
  end

  def locale_transition(model, transition)
    t "activerecord.attributes.#{model}.transitions.#{transition}"
  end
end