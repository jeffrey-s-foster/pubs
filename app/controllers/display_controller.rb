class DisplayController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:recent]

  def publications
    @tag_name = :all
    publications_by_year (Paper.all)
  end

  def tagged
    @tag = Tag.find(params[:id])
    @tag_name = @tag
    publications_by_year (@tag.papers)
  end

  def bibtex
    @paper = Paper.find(params[:id])
    render :layout => false, :content_type => "text/plain"
  end

  def bibtexall
    @papers = Paper.where(hidden: false, draft: false)
    @papers = @papers.sort { |p1, p2| PapersHelper.compare_dates(p1, p2) }
    render :layout => false, :content_type => "text/plain"
  end

  def cv
    papers = Paper.where(hidden: false)
    papers = papers.sort { |p1, p2| PapersHelper.compare_dates(p1, p2) }
    @papers_journal = papers.reject { |p| not (p.kind == "journal" && !p.draft) }
    @papers_journal_drafts = papers.reject { |p| not (p.kind == "journal" && p.draft) }
    @papers_conf = papers.reject { |p| not (p.kind == "conf" && !p.draft) }
    @papers_conf_drafts = papers.reject { |p| not (p.kind == "conf" && p.draft) }
    @papers_tr = papers.reject { |p| not (p.kind == "tr") }
    @papers_thesis = papers.reject { |p| not (p.kind == "thesis") }
    render :layout => false, :content_type => "text/plain"
  end

  def recent
    @papers = Paper.where(hidden: false)
    @papers = @papers.sort { |p1, p2| PapersHelper.compare_dates(p1, p2) }.reverse.first(10)
#    @papers = @papers.map { |p| {title: p.title, url: p.url, short_name: DisplayHelper.format_short_ref(p) } }
#    render json: @papers
    render :layout => false
  end

private

  def publications_by_year(papers)
    @years = PapersHelper.get_years(papers)
    @papers = {}
    papers.each { |p|
      if p.draft
        year = "draft"
      elsif p.kind == "tr"
        year = "tr"
      else
        year = p.year
      end
      @papers[year] = [] if not @papers.has_key? year
      @papers[year].push p
    }
    @papers.each_value { |v|
      v.sort! { |p1, p2| PapersHelper.compare_dates(p2, p1) }
    }
    puts @papers
    render :publications, :layout => 'publications'
  end

end
