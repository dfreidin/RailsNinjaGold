class RpgController < ApplicationController
  before_action :initialize_session

  def index
  end

  def farm
    gold = rand(10..20)
    process_activity(gold, "farm")
    redirect_to root_url
  end

  def cave
    gold = rand(5..10)
    process_activity(gold, "cave")
    redirect_to root_url
  end

  def house
    gold = rand(2..5)
    process_activity(gold, "house")
    redirect_to root_url
  end

  def casino
    gold = rand(-50..50)
    gold = -1 * session[:gold] if gold + session[:gold] < 0
    process_activity(gold, "casino")
    redirect_to root_url
  end

  def reset
    session[:gold] = 0
    session[:activities] = []
    redirect_to root_url
  end

  private
  def initialize_session
    session[:gold] = 0 unless session.include?(:gold)
    session[:activities] = [] unless session.include?(:activities)
  end
  def process_activity(gold, location)
    session[:gold] += gold
    act_str = "Earned #{gold} gold from the #{location}! (#{Time.current.ctime})"
    act_str = "Entered a casino and lost #{-1 * gold} gold... Ouch... (#{Time.current.ctime})" if gold < 0
    session[:activities] += [{class: if gold >= 0 then "pos" else "neg" end, activity: act_str}]
  end
end
