class SportsController < ApplicationController

  # currently it returns json, but it should return html/js
  def index
    resp =SportsHelper.get_sports_data.to_json
    respond_to do |format|
      format.html
      format.json {render :json => resp}
    end
  end

  def all_sports
    sports = SportsHelper.get_sports_data
    render :json => sports.to_json(:only => ["id", "desc", "pos"] )
  end

  def all_events_for_sport
    render json: {}, status: :bad_request and return if params[:sport_id].to_i.to_s != params[:sport_id]
    sport = SportsHelper.get_sports_data.find{ |sport| sport.id == params[:sport_id].to_i}
    if !sport.present?
      render json: {}, status: :not_found
    else
      render :json => sport.events.to_json(:only => ["id", "desc", "pos", "comp_desc"] ) 
   end
  end

  def all_outcomes_for_event
    render json: {}, status: :bad_request and return if params[:sport_id].to_i.to_s != params[:sport_id] || params[:event_id].to_i.to_s != params[:event_id]
    sport = SportsHelper.get_sports_data.find{ |sport| sport.id == params[:sport_id].to_i}
    if sport.present?
      event = sport.events.find{ |ev| ev.id == params[:event_id].to_i}
      if event.present?
        render :json => event.outcomes.to_json(:only => ["desc", "pr", "pos", "prd", "id"] ) and return
      end
    end
    render json: {}, status: :not_found
  end
end
