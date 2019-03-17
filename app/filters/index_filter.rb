class IndexFilter
  def initialize(params)
    @params = params
    @base_rel = Hub.all
  end

  def results
    return @base_rel if empty_param?(@params)
    filter_unlocode
    filter_name
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
      or_functions_filter
    else
      and_function_filter
    end
  end

  def or_functions_filter
    @base_rel = @base_rel
      .joins(:functions)
      .where(functions: {code: @params[:functions]})
  end

  def and_function_filter
    @params[:functions].each do |function_code|
      select_hub_id = Function.where(code: function_code).select(:hub_id)
      @base_rel = @base_rel.where(id: select_hub_id)
    end
  end

  def filter_unlocode
    return if empty_param?(@params[:unlocode])
    @base_rel = @base_rel.where(unlocode: @params[:unlocode].upcase)
  end

  def filter_name
    return if empty_param?(@params[:name_wo_diacritics])
    name = Hub.arel_table[:name_wo_diacritics]
    @base_rel = @base_rel.where(name.matches("%#{@params[:name_wo_diacritics]}%"))
  end

  def filter_check_boxes(key)
    param_value = @params[key.to_s.pluralize.to_sym]
    return if empty_param?(param_value)
    @base_rel = @base_rel.where("#{key}": param_value)
  end

  def empty_param?(param_value)
    !param_value || param_value&.blank?
  end
end
