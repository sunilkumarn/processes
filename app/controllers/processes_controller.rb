class ProcessesController < ApplicationController

  def list
    render :json => `ps -o "pid"`.strip.split("\n")[1..-1]
  end

  def show
    pid = params[:id]
    process_details = `ps -o "pid pcpu pmem time comm" | grep #{pid}`
    if process_details.blank?
      render :json => {status: :error, reason: 'No such process running at present!'}
    else
      render :json => hashify(process_details, [:pid, :pcpu, :pmem, :time, :comm])
    end
  end

  private

  def hashify(value_string, keys=[])
    values = value_string.strip.split(" ")
    Hash[keys.zip(values)]
  end
end
