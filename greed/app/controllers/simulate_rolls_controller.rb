class SimulateRollsController < ApplicationController
  def clear
    session[:simulation] = nil
    render_simulation
  end

  def simulate
    roll = params[:faces].split('-').map { |s| s.to_i }
    session[:simulation] ||= []
    sim_data.push(roll)
    render_simulation
  end

  private

  def render_simulation
    if sim_data
      render :text => "SIMULATING: #{sim_data.inspect}"
    else
      render :text => "SIMULATION IS OFF"
    end
  end

  def sim_data
    session[:simulation]
  end
end
