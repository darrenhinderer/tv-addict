require 'lib/tvdb.rb'

class ShowsController < ApplicationController
  before_filter :authenticate, :except => [:index]

  def index
    @shows = Show.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shows }
    end
  end

  def show
    @show = Show.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @show }
    end
  end

  def new
    @show = Show.new
    @series = []

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @show }
    end
  end

  def edit
    @show = Show.find(params[:id])
  end

  def create
    @show = Show.new(params[:show])

    respond_to do |format|
      if @show.save
        flash[:notice] = 'Show was successfully created.'
        format.html { redirect_to('/shows') }
        format.js
      else
        format.html { render :action => "new" }
        format.js
      end
    end
  end

  def update
    @show = Show.find(params[:id])

    respond_to do |format|
      if @show.update_attributes(params[:show])
        flash[:notice] = 'Show was successfully updated.'
        format.html { redirect_to(@show) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @show = Show.find(params[:id])
    @show.destroy

    respond_to do |format|
      format.html { redirect_to(shows_url) }
      format.xml  { head :ok }
    end
  end

  def search
    @series = TVDB.search(params[:query])
    
    respond_to do |format|
      format.html
    end
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "teevee" && password == "showz"
    end
  end

end
