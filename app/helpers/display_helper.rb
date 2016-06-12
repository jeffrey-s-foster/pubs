module DisplayHelper

  def self.empty(s)
    return s == nil || s == ""
  end

  def self.format_author(s, keep_supervised=false)
    return "[no authors]" if empty s
    authors = s.split(" and ")
    if not keep_supervised
      authors.each { |a| a.chomp!("*") }
    end
    return authors[0] if authors.length == 1
    return authors[0] + " and " + authors[1] if authors.length == 2
    exceptlast = authors[0..(authors.length - 2)]
    exceptlast.join(", ") + ", and " + authors[authors.length - 1]
  end

  def self.format_editor(paper)
    return "" if empty paper.editor
    out = ""
    out << (format_author paper.editor)
    if paper.editor.split(" and ").length == 1
      out << ", editor, "
    else
      out << ", editors, "
    end
    return out
  end

  def self.format_booktitle(paper)
    return "" if empty paper.booktitle
    return "<i>" + paper.booktitle + "</i>"
  end

  def self.format_bvolume(paper)
    return "" if empty paper.volume
    return "[can't have volume and number]" if !(empty paper.volume) && !(empty paper.number)
    out = ", volume " + paper.volume
    if !(empty paper.series)
      out << " of <i>" << paper.series << "</i>"
    end
  end

  def self.format_number_series(paper)
    return "" if not (empty paper.volume)
    return "" if empty paper.number
    return "[number but no series]" if empty paper.series
    return ", number " + paper.number + " in " + paper.series
  end

  def self.format_pages(paper)
    return "" if empty paper.page_start
    return ", page" + paper.page_start if (empty paper.page_end || (paper.page_start == paper.page_end))
    return ", pages " + paper.page_start + "&ndash;" + paper.page_end
    return ", article number " + paper.article_number if not (empty paper.article_number)
  end

  def self.format_date(paper)
    return "" if empty paper.year.to_s
    return " " + paper.year.to_s if empty paper.month
    i = ApplicationHelper::MONTHS_ABBRV.find_index paper.month
    if i then
      month = ApplicationHelper::MONTHS[i]
    else
      month = paper.month
    end
    return " " + month + " " + paper.year.to_s
  end

  def self.format_conf(paper)
    out = ""
    out << "In "
    out << format_editor(paper)
    out << format_booktitle(paper)
    out << format_bvolume(paper)
    out << format_number_series(paper)
    out << format_pages(paper)
    if empty paper.address
      out << " " + paper.organization if not (empty paper.organization)
      out << " " + paper.publisher if not (empty paper.publisher)
      out << format_date(paper)
    else
      out << ", " + paper.address + ", "
      out << format_date(paper) + "."
      out << " " + paper.organization if not (empty paper.organization)
      out << " " + paper.publisher if not (empty paper.publisher)
    end
    out << "."
    out << " " + paper.note if not empty paper.note
    out << "."
    return out
  end

  def self.format_vol_num_pages(paper)
    out = ""
    out << ", " + paper.volume if not (empty paper.volume)
    out << "(" + paper.number + ")" if not (empty paper.number)
    out << "[number but no volume]" if (empty paper.volume) && (not (empty paper.number))
    out << ":" + paper.page_start if not (empty paper.page_start)
    out << "&ndash;" + paper.page_end if not (empty paper.page_end)
    out << ":" + paper.article_number if (not (empty paper.article_number)) && (empty paper.page_start)
    return out
  end

  def self.format_article(paper)
    out = ""
    out << "<i>" + paper.journal + "</i>" if not empty paper.journal
    out << format_vol_num_pages(paper)
    date = format_date(paper)
    out << ", " + date if not (empty date)
    out << "."
    out << " " + paper.note + "." if not (empty paper.note)
    return out
  end

  def self.format_tr(paper)
    out = "Technical Report"
    out << " " + paper.number if not (empty paper.number)
    out << " " + paper.note + "." if not (empty paper.note)
    out << ", " + paper.institution if not (empty paper.institution)
    out << ", " + paper.address if not (empty paper.address)
    date = format_date(paper)
    out << ", " + date if not (empty date)
    out << "."
    out << " " + paper.note + "." if not (empty paper.note)
    return out
  end

  def self.format_thesis(paper)
    out = "PhD thesis"
    out << ", " + paper.school if not (empty paper.school)
    out << ", " + paper.address if not (empty paper.address)
    date = format_date(paper)
    out << ", " + date if not (empty date)
    out << "."
    out << " " + paper.note + "." if not (empty paper.note)
    return out
  end

  def self.fix_periods(out)
    while (out =~ /\.\./)
      out.sub!("..", ".")
    end
  end

  def self.format_loc(paper)
    out = ""
    if paper.draft
      date = format_date(paper)
      out << date + ", " if not (empty date)
      out << paper.note + "." if not (empty paper.note)
    else
      case paper.kind
      when /journal/
        out = format_article(paper)
      when /conf/
        out = format_conf(paper)
      when /tr/
        out = format_tr(paper)
      when /thesis/
        out = format_thesis(paper)
      else
        out = "[internal error &mdash; unknown paper kind]"
      end
    end
    fix_periods out
    return out
  end

  def self.get_abbrv(paper)
    case paper.kind
    when /journal/
    when /conf/
      return "conf"
    when /tr/
      return paper.number
    when /thesis/
      return "PhD Thesis"
    else
      return nil
    end
  end
  
  def self.format_short_ref(paper)
    out = ""
    if paper.draft
			  out = "Draft, #{format_date paper}"
		else
		  case paper.kind
      when /conf/
        paper.booktitle =~ /\((.*)\)/
        if $1 && (not empty paper.year)
          out = "#{$1} #{paper.year}"
        elsif $1
          out = $1
        elsif (not empty paper.year)
          out = format_date paper
        end
      when /journal/
        paper.journal =~ /\((.*)\)/
        if $1 && (not empty paper.year)
          out = "#{$1} #{paper.year}"
        elsif $1
          out = $1
        elsif (not empty paper.year)
          out = format_date paper
        end
      when /tr/
        out = "#{paper.number}, #{format_date paper}"
      when /thesis/
        out = "PhD Thesis, #{format_date paper}"
	    end
		end
		return out
	end

  BIBENTRIES = {
    "journal" => "article",
    "conf" => "inproceedings",
    "tr" => "techreport",
    "thesis" => "phdthesis",
  }

  FIELDS = {
    "conf" => ["author", "title", "booktitle", "pages", "year", "editor", "volume", "number", "series",
               "address", "month", "organization", "publisher", "note"], # also key, annote
    "journal" => ["author", "title", "journal", "year", "volume", "number", "pages", "month", "note"], # also key, annote
    "tr" => ["author", "title", "institution", "year", "number", "address", "month", "note"], # also key, type, annote
    "thesis" => ["author", "title", "school", "year", "address", "month", "note"], # also key, type, annote
  }

  Html_xlate = {
    /&auml;/ => {:tex => "{\\\"{a}}", :plain => "ae"},
    /&uuml;/ => {:tex => "{\\\"{u}}", :plain => "ue"},
    /&amp;/ => {:tex => "\\&"},
    /&ndash;/ => {:tex => "--", :plain => "--"},
    /#/ => {:tex => "\\#"},
    /$/ => {:tex => "\\$"},
    /%/ => {:tex => "\\%"},
    /_/ => {:tex => "\\_", :plain => "_"},
    /\{/ => {:tex => "\\{"},
    /\}/ => {:tex => "\\}"},
    /<i>/ => {:tex => "\\textit{"},
    /<\/i>/ => {:tex => "}"},
    /<b>/ => {:tex => "\\textbf{"},
    /<\/b>/ => {:tex => "}"},
    /<sup>/ => {:tex => "\\ensuremath{^{"},
    /<\/sup>/ => {:tex => "}}"},
  }

  def self.xlate(s, tgt)
    ss = StringScanner.new(s)
    out = ""
    while (not ss.eos?)
      Html_xlate.each { |k, v|
        if ss.scan(k)
          out.insert(-1, v[tgt] ? v[tgt] : "")
          break
        end
      }
      out.insert(-1, ss.getch)
    end
    return out
  end

  def self.to_bibtex(paper)
    out = ""
    out << "@" + BIBENTRIES[paper.kind] + "{"
    out << xlate(paper.author, :plain).split(" and ").first.split(" ").last.chomp("*").downcase
    out << ":"
    out << paper.url.split("/").last.split(".").first if not empty(paper.url)
    out << ",\n"
    FIELDS[paper.kind].each { |f|
      case f
      when /^author$/
        next if self.empty paper.author
        out << "  author = {" + xlate(paper.author.gsub("*", ""), :tex) + "},\n"
      when /^title$/
        next if self.empty paper.title
        out << "  title = {{" + xlate(paper.title, :tex) + "}},\n"
      when /^pages$/
        ps = paper.page_start
        pe = paper.page_end
        an = paper.article_number
        if (not (self.empty ps)) && (not (self.empty pe))
          out << "  pages = {" + ps + "--" + pe + "},\n"
        elsif (not (self.empty ps))
          out << "  pages = {" + ps + "}, \n"
        elsif (not (self.empty an))
          out << "  pages = {" + an + "}, \n"
        end
      when /^month$/
        m = paper.month
        next if self.empty m
        i = ApplicationHelper::MONTHS_ABBRV.find_index m
        m = ApplicationHelper::MONTHS[i] if i
        out << "  month = {" + m + "},\n"
      else
        s = (paper.send f).to_s
        next if self.empty s
        out << "  " + f + " = {" + xlate(s, :tex) + "},\n"
      end
    }
    out << "}\n"
    return out
  end
  	
	def self.format_latex(paper)
    out = ""
    out << "(Invited) " if paper.invited
    out << (self.format_author(paper.author, true))
    out << ". "
    out << paper.title
    out << ". "
    out << (self.format_loc paper)
    out << " doi:#{paper.doi}" if not (empty paper.doi)
    out = self.xlate(out, :tex)
    out = out.gsub("*", "\\\\supervised{}")
    if paper.num_accepted && paper.num_submitted
      rate = (100*(paper.num_accepted.to_f / paper.num_submitted.to_f)).round
      out << " \\ar{#{paper.num_accepted}/#{paper.num_submitted} (#{rate}\\%)}"
    end
    return out.html_safe
  end

end

# @InProceedings{,
#   author =   {},
#   title =    {},
#   OPTcrossref =  {},
#   OPTkey =   {},
#   OPTbooktitle = {},
#   OPTpages =   {},
#   OPTyear =    {},
#   OPTeditor =    {},
#   OPTvolume =    {},
#   OPTnumber =    {},
#   OPTseries =    {},
#   OPTaddress =   {},
#   OPTmonth =   {},
#   OPTorganization = {},
#   OPTpublisher = {},
#   OPTnote =    {},
#   OPTannote =    {}
# }

# @Article{,
#   author =   {},
#   title =    {},
#   journal =    {},
#   year =   {},
#   OPTkey =   {},
#   OPTvolume =    {},
#   OPTnumber =    {},
#   OPTpages =   {},
#   OPTmonth =   {},
#   OPTnote =    {},
#   OPTannote =    {}
# }

# @TechReport{,
#   author =   {},
#   title =    {},
#   institution =  {},
#   year =   {},
#   OPTkey =   {},
#   OPTtype =    {},
#   OPTnumber =    {},
#   OPTaddress =   {},
#   OPTmonth =   {},
#   OPTnote =    {},
#   OPTannote =    {}
# }

# @PhdThesis{,
#   author =   {},
#   title =    {},
#   school =   {},
#   year =   {},
#   OPTkey =   {},
#   OPTtype =    {},
#   OPTaddress =   {},
#   OPTmonth =   {},
#   OPTnote =    {},
#   OPTannote =    {}
# }
