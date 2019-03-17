class HubDecorator < Draper::Decorator
  delegate_all

  def change_code_humane
    explanation = Hub.change_code_explanation(object.change_code)
    return unless explanation
    "(#{object.change_code}) #{explanation}"
  end

  def status_humane
    explanation = Hub.status_explanation(object.status)
    "(#{object.status}) #{explanation}"
  end
end
