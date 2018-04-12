class EventCalendarSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :title, :allDay 

  def title
    object.name + " By \n " + object.user.name
  end

  def start
    object.event_datetime
  end

  def end
    object.event_datetime
  end

  def allDay
    true
  end
end
