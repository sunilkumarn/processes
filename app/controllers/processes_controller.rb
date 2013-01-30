class ProcessesController < ApplicationController

  # Lists the currently process ids
  def list
    render :json => `ps -o "pid"`.strip.split("\n")[1..-1]
  end

  # Provides details on the process id supplied as the parameter
  # @param [id] process_id
  def show
    pid = params[:id]
    fields = "pid pcpu pmem time comm"
    process_details = `ps -o "#{fields}" | grep #{pid}`
    if process_details.blank?
      render :json => {status: :error, reason: 'No such process running at present!'}
    else
      render :json => hashify(process_details, fields)
    end
  end

  private

  def hashify(value_string, field_string)
    values = value_string.strip.split(" ")
    fields = field_string.strip.split(" ")
    Hash[fields.zip(values)]
  end

end
