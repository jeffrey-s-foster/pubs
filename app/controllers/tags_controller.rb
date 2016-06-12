class TagsController < ApplicationController
  before_filter :login_required
  layout 'login_bar'

  # GET /tags
  def index
    @tags = Tag.all
    @tags.sort! { |t1, t2| t1.name <=> t2.name }
  end

  # PUT /tags
  def update
    flash[:notice] = ""
    flash[:error] = ""
    if params[:new_tag] && params[:new_tag] != ""
      t = Tag.new(:name => params[:new_tag])
      if t.valid?
        flash[:notice] = "Tag \"#{t.name}\" created"
        t.save
      else
        flash[:error] << "Tag \"#{t.name}\" not added; tags must be unique<br>"
      end
    end
    params.keys.each { |k|
      next unless k =~ /^tag_(.*)/
      t = Tag.find($1)
      next if params[k] == t.name
      old_name = t.name
      t.name = params[k]
      if t.valid?
        flash[:notice] << "Tag \"#{old_name}\" renamed to \"#{params[k]}\"<br>"
        t.save
      else
        flash[:error] << "Tag \"#{old_name}\" not renamed to \"#{params[k]}\"; tags must be unique<br>"
      end
    }
    redirect_to tags_url
  end

  # DELETE /tags/1
  def destroy
    @tag = Tag.find(params[:id])
    name = @tag.name
    @tag.destroy
    flash[:notice] = "Tag \"#{name}\" deleted"
    redirect_to tags_url
  end
end
