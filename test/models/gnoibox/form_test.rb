require 'test_helper'

class FormTest < ActiveSupport::TestCase

  test 'on invaild inquiry, no save and no mail' do
    url_parser = Gnoibox::UrlParser.new({first: "contact"})
    inquiry = Gnoibox::Form::Root.new_inquiry(content: {name: 'no email'})
    
    mock = Minitest::Mock.new.expect(:call, nil)
    Gnoibox::InquiryMailer.stub :notice, mock do
      assert_equal false, inquiry.save_and_notify(url_parser)
      assert_raises(MockExpectationError){ mock.verify }
    end
  end
  
  test 'on valid inquiry, attempt notice and thanks mail using inquiry and url_parser' do
    url_parser = Gnoibox::UrlParser.new({first: "contact"})
    inquiry = Gnoibox::Form::Root.new_inquiry(content: {name: 'test name', email: 'test@example.com'})
    
    nullmail = Minitest::Mock.new.expect(:deliver, nil)
    noticemock = Minitest::Mock.new.expect(:call, nullmail, [inquiry, url_parser])
    Gnoibox::InquiryMailer.stub :notice, noticemock do
      assert_equal true, inquiry.save_and_notify(url_parser)
      assert noticemock.verify && nullmail.verify
    end
  end

  test 'setup default notice mail' do
    url_parser = Gnoibox::UrlParser.new({first: "contact"})
    inquiry = Gnoibox::Form::Root.new_inquiry(content: {name: 'test name', email: 'test@example.com'})
    mail = Gnoibox::InquiryMailer.notice(inquiry, url_parser)
    assert_equal ["admin@gnoibox.com"], mail.to
    assert_equal "【テストサイト名】お問合せがありました", mail.subject
    assert mail.body.to_s.include? "root notice body"
  end

  test 'setup custom notice mail according to url_parser' do
    url_parser = Gnoibox::UrlParser.new({first: "building", second: "daikanyama_tower"})
    inquiry = Gnoibox::Form::Building.new_inquiry(content: {name: 'test name', email: 'test@example.com'})
    mail = Gnoibox::InquiryMailer.notice(inquiry, url_parser)
    assert_equal ["admin@gnoibox.com"], mail.to
    assert_equal "【代官山タワー】お問合せがありました", mail.subject
    assert mail.body.to_s.include? "custom notice body"
    assert mail.body.to_s.include? "代官山タワー"
  end

  test 'when inquirer_email is provided, send thanks mail' do
    url_parser = Gnoibox::UrlParser.new({first: "contact"})
    inquiry = Gnoibox::Form::Root.new_inquiry(content: {name: 'test name', dummy_email: 'dummy@exmple.com', email: 'test@example.com'})
    mail = Gnoibox::InquiryMailer.thank_if_possible(inquiry, url_parser)
    assert_equal "test@example.com", inquiry.inquirer_email
    assert_equal ["test@example.com"], mail.to
    assert_equal "【テストサイト名】お問合せありがとうございます", mail.subject
    assert mail.body.to_s.include? "root thanks body"
  end

  test 'setup custom thanks mail according to url_parser' do
    url_parser = Gnoibox::UrlParser.new({first: "building", second: "daikanyama_tower"})
    inquiry = Gnoibox::Form::Building.new_inquiry(content: {name: 'test name', email: 'test@example.com', auto_reply_email: 'inquirer@example.com'})
    mail = Gnoibox::InquiryMailer.thank_if_possible(inquiry, url_parser)

    assert_equal ["inquirer@example.com"], mail.to
    assert_equal "【代官山タワー】お問合せありがとうございます", mail.subject
    assert mail.body.to_s.include? "custom thanks body"
    assert mail.body.to_s.include? "代官山タワー"
  end
  
  test 'when inquirer_email is not provided, no thanks mail' do
    url_parser = Gnoibox::UrlParser.new({first: "building", second: "daikanyama_tower"})
    inquiry = Gnoibox::Form::Building.new_inquiry(content: {name: 'test name', email: 'test@example.com'})
    
    assert_equal nil, inquiry.inquirer_email
    assert_kind_of ActionMailer::Base::NullMail, Gnoibox::InquiryMailer.thank_if_possible(inquiry, url_parser)
  end

end
