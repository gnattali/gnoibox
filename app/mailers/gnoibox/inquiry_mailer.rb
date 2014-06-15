class Gnoibox::InquiryMailer < ActionMailer::Base
  default from: "no-reply@gnoibox.com"

  def notice(inquiry)
    @inquiry = inquiry
    mail(to: Gnoibox::Author.pluck(:email), subject: 'GNOIBOX : お問合せがありました')
  end
end
