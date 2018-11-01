class HistoriesController < ApplicationController

  def index
    @histories = History.all
  end

  def new
    @history = History.new
  end

  def create
    @history = History.new
    @history.save
  end


end
