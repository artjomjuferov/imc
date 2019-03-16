class FunctionDecorator < Draper::Decorator
  delegate_all

  def humane
    explanation = Function.explanation(object.code)
    "(#{object.code}) #{explanation}"
  end
end
