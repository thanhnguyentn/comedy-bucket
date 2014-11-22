class Api::SchedulesController < ApplicationController

  protect_from_forgery with: :reset_session

  def index
    @schedules = Schedule.all
    render json: @schedules
  end

  def create
    @schedule = Schedule.new(params.require(:schedules).permit(:place_name, :time, :location, :artist_id))
    @schedule.save
    render json: @schedule
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule = Schedule.update(params.require(:schedules).permit(:place_name, :time, :location, :artist_id))
    render json: @schedule
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.delete
    render json: {ok: true}
  end
end
