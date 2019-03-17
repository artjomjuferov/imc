class IndexFilter
  def initialize(params)
    @params = params
    @base_rel = Hub.all
  end

  def results
    return @base_rel if empty_param?(@params)
    filter_text_field(:name_wo_diacritics)
    filter_text_field(:unlocode)
    filter_check_boxes(:change_code)
    filter_check_boxes(:status)
    filter_functions
    @base_rel
  end

  private

  def empty_params?
    !@params || @params.empty?
  end

  def filter_functions
    return if empty_param?(@params[:functions])
    @base_rel = @base_rel.distinct
    if empty_param?(@params[:functions_and])
      @base_rel = @base_rel
        .joins(:functions)
        .where(functions: {code: @params[:functions]})
    else
      @params[:functions].each do |function_code|
        select_hub_id = Function.where(code: function_code).select(:hub_id)
        @base_rel = @base_rel.where(id: select_hub_id)
      end
    end
  end

  def filter_check_boxes(key)
    param_value = @params[key.to_s.pluralize.to_sym]
    return if empty_param?(param_value)
    @base_rel = @base_rel.where("#{key}": param_value)
  end

  def filter_text_field(key)
    return if empty_param?(@params[key])
    @base_rel = @base_rel.where("#{key}": @params[key])
  end

  def empty_param?(param_value)
    !param_value || param_value&.blank?
  end
end
