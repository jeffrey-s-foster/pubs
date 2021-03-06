module ApplicationHelper

  MONTHS_ABBRV = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"]
  MONTHS = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ]

  def logout_url
    root_url + "logout?service=#{publications_url}"
  end

  def logged_in
    session['cas'] && (session['cas']['user'] == 'jfoster4')
  end
end
