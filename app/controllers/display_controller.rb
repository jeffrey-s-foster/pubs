class DisplayController < ApplicationController

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
    @papers = Paper.all(:conditions => { "hidden" => false, "draft" => false })
    @papers.sort! { |p1, p2| PapersHelper.compare_dates(p1, p2) }
    render :layout => false, :content_type => "text/plain"
  end

  def cv
    papers = Paper.all(:conditions => {"hidden" => false})
    papers.sort! { |p1, p2| PapersHelper.compare_dates(p1, p2) }
    @papers_journal = papers.reject { |p| not (p.kind == "journal" && !p.draft) }
    @papers_journal_drafts = papers.reject { |p| not (p.kind == "journal" && p.draft) }
    @papers_conf = papers.reject { |p| not (p.kind == "conf" && !p.draft) }
    @papers_conf_drafts = papers.reject { |p| not (p.kind == "conf" && p.draft) }
    @papers_tr = papers.reject { |p| not (p.kind == "tr") }
    @papers_thesis = papers.reject { |p| not (p.kind == "thesis") }
    render :layout => false, :content_type => "text/plain"
  end

  def recent
    @papers = Paper.all(:conditions => {"hidden" => false})
    @papers.sort! { |p1, p2| PapersHelper.compare_dates(p1, p2) }
    @papers.reverse!
    @papers = @papers.first 10
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
