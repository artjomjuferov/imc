class IndexFilter
  def initialize(params)
    @params = params
    @base_rel = Hub.all
  end

  def results
    return @base_rel if @params.blank?
    filter_unlocode
    filter_name
    filter_check_boxes(:change_code)
    filter_check_boxes(:status)
    filter_functions
    order
    @base_rel
  end

  private


  def filter_functions
    return if @params[:functions].blank?
    @base_rel = @base_rel.distinct
    if false_checkbox?(@params[:functions_and])
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
    return if @params[:unlocode].blank?
    @base_rel = @base_rel.where(unlocode: @params[:unlocode].upcase)
  end

  def filter_name
    return if @params[:name_wo_diacritics].blank?
    name = Hub.arel_table[:name_wo_diacritics]
    @base_rel = @base_rel.where(name.matches("%#{@params[:name_wo_diacritics]}%"))
  end

  def filter_check_boxes(key)
    param_value = @params[key.to_s.pluralize.to_sym]
    return if param_value.blank?
    @base_rel = @base_rel.where("#{key}": param_value)
  end
  
  def order
    if @params[:order_by] == 'country'
      @base_rel = @base_rel.joins(:country).order("countries.name #{order_asc_desc}")
    else
      @base_rel = @base_rel.order("name_wo_diacritics #{order_asc_desc}")
    end
  end
  
  
  def order_asc_desc
    false_checkbox?(@params[:order_desc]) ? 'ASC' : 'DESC'
  end
  
  def false_checkbox?(param_value)
    param_value.blank? || param_value == '0'
  end
end
