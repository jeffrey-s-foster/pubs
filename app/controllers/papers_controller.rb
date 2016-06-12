class PapersController < ApplicationController

  before_filter :login_required
  layout 'login_bar'

  # GET /papers
  def index
    @papers = Paper.all
  end

  # GET /papers/1
  def show
    @paper = Paper.find(params[:id])
    @paper.tag_list = (@paper.tags.map { |t| t.name }).sort.join(", ")
  end

  # GET /papers/new
  def new
    @paper = Paper.new
    render :action => "edit"
  end

  # GET /papers/1/edit
  def edit
    @paper = Paper.find(params[:id])
    @paper.tag_list = (@paper.tags.map { |t| t.name }).sort.join(", ")
  end

  # POST /papers
  def create
    adjust params
    @paper = Paper.new(params[:paper])

    if flash[:error]
      render :action => "edit"
    elsif @paper.save
      flash.now[:notice] = "" if !flash.now[:notice]
      flash.now[:notice] << "Paper was successfully created."
      redirect_to @paper
    else
      render :action => "edit"
    end
  end

  # PUT /papers/1
  def update
    @paper = Paper.find(params[:id])
    adjust params
    if flash[:error]
      @paper.attributes = params[:paper]
      render :action => "edit"
    elsif @paper.update_attributes(params[:paper])
      flash.now[:notice] = "" if !flash.now[:notice]
      flash.now[:notice] = "Paper was successfully updated."
      redirect_to @paper
    else
      render :action => "edit"
    end
  end

  # DELETE /papers/1
  def destroy
    @paper = Paper.find(params[:id])
    @paper.destroy

    redirect_to papers_url
  end

  private
  
  def adjust(params)
    if params[:paper][:month] == "other" then
      params[:paper][:month] = params[:paper][:month_other]
    end
    tags = []
    (params[:paper][:tag_list].split(",").map { |t| t.strip }).each { |s|
      t = Tag.find_by_name s
      if t
        tags << t
      else
        flash.now[:error] = "" if !flash.now[:error]
        flash.now[:error] << "Tag \"#{s}\" does not exist<br>"
      end
    }
    params[:paper][:tags] = tags
  end
end
