class Gnoibox::InquiryMailerPreview < ActionMailer::Preview
  def notice
    Gnoibox::Form::Root
    inquiry = Gnoibox::Inquiry::Root.new(content: {name: 'name test', email: 'test@example.com', description: 'desc test'})
    Gnoibox::InquiryMailer.notice(inquiry).deliver
  end
end
