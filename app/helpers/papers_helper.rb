module PapersHelper

  FIELDS =
    [:kind,
     :invited,
     :draft,
     :hidden,
     :author,
     :title,
     :url,
     :institution,
     :school,
     :booktitle,
     :journal,
     :address,
     :month,
     :year,
     :page_start,
     :page_end,
     :article_number,
     :editor,
     :volume,
     :number,
     :series,
     :organization,
     :publisher,
     :note,
     :doi,
     :num_accepted,
     :num_submitted,
   ]

  def self.flags(paper)
 	 tmp = ""
 	 if paper.invited then tmp = "Invited" end
 	 if paper.draft then
 		tmp << ", " if tmp != ""
 		tmp << "Draft"
 	 end
 	 if paper.hidden then
 		tmp << ", " if tmp != ""
 		tmp << "Hidden"
 	 end
 	 tmp
  end

  def self.get_first_month(s)
    if (s =~ /(.*)[-\/](.*)/)
      return ApplicationHelper::MONTHS.find_index $1
    end
    return nil
  end

  # sort by draft status, then year, then month
  def self.compare_dates(paper1, paper2)
    return 1 if paper1.draft && !paper2.draft
    return -1 if !paper1.draft && paper2.draft
    
    y1 = paper1.year
    y2 = paper2.year
    return 1 if not y1
    return -1 if not y2
    y1 = y1.to_i
    y2 = y2.to_i
    return y1 - y2 if y1 != y2

    m1 = ApplicationHelper::MONTHS_ABBRV.find_index paper1.month
    m2 = ApplicationHelper::MONTHS_ABBRV.find_index paper2.month
    m1 = get_first_month paper1.month if not m1
    m2 = get_first_month paper2.month if not m2
    return 1 if not m1
    return -1 if not m2
    return m1 - m2 if m1 != m2

    b1 = paper1.booktitle
    b2 = paper2.booktitle
    return 1 if not b1
    return -1 if not b2
    cmp = b1 <=> b2
    return cmp if cmp != 0

    t1 = paper1.title
    t2 = paper2.title
    return 1 if not t1
    reutrn -1 if not t2
    return t1 <=> t2
  end

  def self.get_years(papers)
    years = []
    papers.each { |p|
      years.push p.year if (not p.draft) && (not p.kind == "tr") && (not years.include? p.year)
    }
    years.sort!.reverse!
  end

end
