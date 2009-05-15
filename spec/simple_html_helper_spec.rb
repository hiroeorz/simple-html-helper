
require File.join(File.dirname(__FILE__), 'spec_helper')

describe "SimpleHtmlHelper" do
  it "should replace html tags" do
    text =<<EOF
hello this is my blog

my home pege is http://my.home.page/blogs/20090515
please check this url

EOF

    http_text = "hello&nbsp;this&nbsp;is&nbsp;my&nbsp;blog<br /><br />my&nbsp;home&nbsp;pege&nbsp;is&nbsp;<a href=\"http://my.home.page/blogs/20090515\" target=\"_blank\">http://my.home.page/blogs/20090515</a><br />please&nbsp;check&nbsp;this&nbsp;url<br /><br />"

    text.to_html.should == http_text
  end

  it "should replace \n,\r\n,\r -> <br />" do
    "hello\nhello".to_html_br.should == "hello<br />hello"
    "hello\r\nhello".to_html_br.should == "hello<br />hello"
    "hello\rhello".to_html_br.should == "hello<br />hello"

    "hello\n\n\nhello".to_html_br.should == "hello<br /><br /><br />hello"

  end

  it "should replace & -> &amp;" do
    "hello&world".to_html_amp.should == "hello&amp;world"
    "hello&&world".to_html_amp.should == "hello&amp;&amp;world"
  end

  it "should replace special character" do
    "hello<good>world".to_html_special_char.should == "hello&lt;good&gt;world"
    "hello world".to_html_special_char.should == "hello&nbsp;world"
    'hello"world'.to_html_special_char.should == "hello&quot;world"
  end

  it "should replace url -> url link" do
    "helo http://google.co.jp world".to_html_link.should ==
      "helo <a href=\"http://google.co.jp\" target=\"_blank\">http://google.co.jp</a> world"

    "helohttp://google.co.jp world".to_html_link.should ==
      "helo<a href=\"http://google.co.jp\" target=\"_blank\">http://google.co.jp</a> world"

    "helo\nhttp://google.co.jp\nworld".to_html_link.should ==
      "helo\n<a href=\"http://google.co.jp\" target=\"_blank\">http://google.co.jp</a>\nworld"
  end

  it "should sanitize not allowed tag" do
    text = "hello<script type='text/javascript'>alert('script')</script>wolrd"
    text.sanitize.should == "helloalert(&#39;script&#39;)wolrd"

    text = "<embed src='../images/htmq.swf' />"
    text.sanitize.should == ""
  end
end
