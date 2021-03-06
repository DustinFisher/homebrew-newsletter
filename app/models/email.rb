# == Schema Information
#
# Table name: emails
#
#  id            :integer          not null, primary key
#  name          :string
#  newsletter_id :integer
#  send_date     :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Email < ActiveRecord::Base
  belongs_to :newsletter
  has_many :links

  def category_ids
    links.map { |link| link.category.id }.compact.uniq
  end

  def build
    html = header
    html += body
    html += footer

    File.open("email.html", "w") { |file| file.write html }
  end

  def header
    <<-HTML
<!doctype html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>Homebrew Weekly</title>

<style type="text/css">
	.ReadMsgBody {width: 100%; background-color: #ffffff;}
	.ExternalClass {width: 100%; background-color: #ffffff;}
	body	 {width: 100%; background-color: #ffffff; margin:0; padding:0; -webkit-font-smoothing: antialiased;font-family: Georgia, Times, serif}
	table {border-collapse: collapse;}

	@media only screen and (max-width: 640px)  {
    body[yahoo] .deviceWidth {width:440px!important; padding:0;}
    body[yahoo] .center {text-align: center!important;}
  }

	@media only screen and (max-width: 479px) {
    body[yahoo] .deviceWidth {width:280px!important; padding:0;}
    body[yahoo] .center {text-align: center!important;}
  }
</style>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" yahoo="fix" style="font-family: Georgia, Times, serif">

<!-- Wrapper -->
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td width="100%" valign="top" bgcolor="#ffffff" style="padding-top:20px">

			<!-- Start Header-->
			<table width="580" border="0" cellpadding="0" cellspacing="0" align="center" class="deviceWidth" style="margin:0 auto;">
				<tr>
					<td width="100%" bgcolor="#ffffff">
            <!-- Logo -->
            <table border="0" cellpadding="0" cellspacing="0" align="left" class="deviceWidth">
              <tr>
                <td style="padding:10px 5px; font-size: 24px;" class="center">
                  Homebrew Weekly
                </td>
              </tr>
            </table>
            <!-- End Logo -->

            <!-- Nav -->
            <table border="0" cellpadding="0" cellspacing="0" align="right" class="deviceWidth">
              <tr>
                <td class="center" style="font-size: 13px; color: #272727; font-weight: light; text-align: right; font-family: Georgia, Times, serif; line-height: 20px; vertical-align: middle; padding:10px 20px; padding-bottom: 0px; font-style:italic">
                  Your weekly source for homebrew news.
                </td>
              </tr>
              <tr>
                <td class="center" style="font-size: 13px; color: #272727; font-weight: light; text-align: right; font-family: Georgia, Times, serif; vertical-align: middle; padding:0px; padding-right: 20px; font-style:italic">
                  #{name}
                </td>
              </tr>
            </table>
            <!-- End Nav -->
					</td>
				</tr>
			</table>
      <!-- End Header -->
    HTML
  end

  def body
    result = ""

    category_ids.each do |category_id|
      category_links = links.where(category_id: category_id)
      category = Category.find category_id
      result += <<-HTML
      <!-- #{category.name} One Column -->
			<table width="580"  class="deviceWidth" border="0" cellpadding="0" cellspacing="0" align="center" bgcolor="#eeeeed" style="margin:0 auto;">
        <tr>
          <td style="font-size: 13px; color: #3E3A3A; font-weight: normal; text-align: left; font-family: Georgia, Times, serif; line-height: 24px; vertical-align: top; padding:10px 8px 10px 8px" bgcolor="#eeeeed">
            <table>
              <tr>
                <td valign="middle" style="padding:0 10px 10px 0">
                  <p style="text-decoration: none; color: #272727; font-size: 20px; color: #272727; font-weight: bold; font-family:Arial, sans-serif; margin: 0px;">#{category.name}</p>
                </td>
              </tr>
              #{build_section(category_links)}
            </table>
          </td>
        </tr>
			</table>
      <!-- End #{category.name} One Column -->
      HTML
    end

    result
  end

  def build_section(links)
    result = ""
    links.each do |link|
      link
      result += <<-HTML
        <tr>
          <td style="text-align:left;padding-left:2px;" valign="middle">
            <a href="#{link.url}" style="font-size:16px;font-weight:bold;color:#CA2929;text-align:left;text-decoration:underline;">#{link.name}</a><br />
            #{link.description}
            <br /><br />
          </td>
        </tr>
      HTML
    end

    result
  end

  def footer
    <<-HTML
      <div style="height:15px;margin:0 auto;">&nbsp;</div><!-- spacer -->

			<!-- 4 Columns -->
			<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<td bgcolor="#363636" style="padding:30px 0">
            <table width="580" border="0" cellpadding="10" cellspacing="0" align="center" class="deviceWidth" style="margin:0 auto;">
              <tr>
                <td>
                  <table width="100%" cellpadding="0" cellspacing="0"  border="0" align="right" class="deviceWidth">
                    <tr>
                      <td valign="top" style="font-size: 11px; color: #f1f1f1; font-weight: normal; font-family: Georgia, Times, serif; line-height: 26px; vertical-align: top; text-align:right" class="center">
                        <a href="https://www.facebook.com/mashandbrew/"><img src="http://mashandbrew.com/newsletters/issue1/footer_twitter.gif" width="42" height="42" alt="Twitter" title="Twitter" border="0" /></a>
                        <a href="https://twitter.com/mashandbrew"><img src="http://mashandbrew.com/newsletters/issue1/footer_fb.gif" width="42" height="42" alt="Facebook" title="Facebook" border="0" /></a><br />

                        <a href="http://mashandbrew.com/" style="font-size: 22px; text-decoration: none; color: #ffffff;">Mash & Brew</a><br/>
                        <a href="#" style="text-decoration: none; color: #848484; font-weight: normal;">dustin@mashandbrew.com</a>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <!-- End 4 Columns -->

		</td>
	</tr>
</table>
<!-- End Wrapper -->
<div style="display:none; white-space:nowrap; font:15px courier; color:#ffffff;">
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
</div>
</body>
</html>
    HTML
  end

end
