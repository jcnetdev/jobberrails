Page.seed(:url) do |s|
  s.url = 'about'
  s.page_title = 'About Us'
  s.keywords = ''
  s.description = ''
  s.title = 'About Us'
  s.content = '<h4>Hello!</h4><p>This job board is an open source implementation of <a href="http://www.jobber.ro/">www.jobber.ro</a>.</p><p>Don\'t hesitate to <a href="http://localhost/jobber/contact/">contact us</a>!</p>'
  s.has_form = false
  s.form_message = ''
end

Page.seed(:url) do |s|
  s.url = 'contact'
  s.page_title = 'Contact Us'
  s.keywords = ''
  s.description = ''
  s.title = 'We really appreciate feedback!'
  s.content = '<p>E-mail us at <strong>hello [at] domain [dot] com</strong> or use the form below:</p>'
  s.has_form = true
  s.form_message = '<p>Thank you for your message! :)</p>'
end

Page.seed(:url) do |s|
  s.url = 'widgets'
  s.page_title = 'Widgets'
  s.keywords = ''
  s.description = ''
  s.title = 'Site widget'
  s.content = '<h4>Would you like to display our latest jobs on your site?</h4>
    <p>Insert one of the following snippets in your page\'s HTML code, in the position where the ads should appear:</p>
    <ol>
    <li>Get latest 5 jobs from all categories and all types, posted in the past 7 days, in random order:
    <pre>&lt;script src="http://localhost/jobber/api/api.php?action=getJobs<br />&amp;type=0&amp;category=0&amp;count=5&amp;random=1&amp;days_behind=7&amp;response=js" type="text/javascript"&gt;&lt;/script&gt;<br /><br />&lt;script type="text/javascript"&gt;<strong>showJobs(\'jobber-container\', \'jobber-list\');</strong>&lt;/script&gt;</pre>
    </li>
    <li>Get last 10 full-time jobs for programmers, posted in the past 15 days, ordered by publish date (newest on top):
    <pre>&lt;script src="http://localhost/jobber/api/api.php?action=getJobs<br />&amp;type=fulltime&amp;category=programmers&amp;count=10&amp;random=0&amp;days_behind=15&amp;response=js" <br />type="text/javascript"&gt;&lt;/script&gt;<br /><br />&lt;script type="text/javascript"&gt;<strong>showJobs(\'jobber-container\', \'jobber-list\');</strong>&lt;/script&gt;</pre>
    </li>
    <li>Get latest jobs published by a company (e.g. Google):
    <pre>&lt;script src="http://localhost/jobber/api/api.php?action=getJobsByCompany<br />&amp;company=google&amp;count=10&amp;response=js" type="text/javascript"&gt;&lt;/script&gt;<br /><br />&lt;script type="text/javascript"&gt;<strong>showJobs(\'jobber-container\',\'jobber-list\');</strong>&lt;/script&gt;</pre>
    </li>
    </ol>
    <h2>The parameters you can use when calling the API, are:</h2>
    <ul>
    <li><strong>action</strong>: "getJobs" - all jobs / "getJobsByCompany" - a single company\'s jobs</li>
    <li><strong>type</strong>: "0" - toate / "fulltime" / "parttime" / "freelance";</li>
    <li><strong>category</strong>: "0" - all / "programmers" / "designers" / "administrators" / "managers" / "testers" / "editors";</li>
    <li><strong>count</strong>: number of job ads to display;</li>
    <li><strong>random</strong>: "1" - display randomly / "0" - display ordered by publish date (newest on top);</li>
    <li><strong>days_behind</strong>: get only jobs posted in the past X days (type "0" if you don\'t want to limit this);</li>
    <li><strong>response</strong>: "js" - returns jobs as JavaScript code / "json" - returns only a JSON string / "xml" - returns an XML.</li>
    </ul>
    <h2>Use CSS to style the list:</h2>
    <pre>ul.jobber-list {<br />  list-style-type: none;<br />  margin: 0;<br />  padding: 0;<br />}<br />ul.jobber-list li {<br />  margin-bottom: 5px;<br />}</pre>'
  s.has_form = false
  s.form_message = ''
end