# NextBug

NextBug is a Bugzilla extension to recommend similar bugs using the textual description of bug reports.

<strong>Screenshot </strong>

This screenshot shows a bug related to the camera of a mobile device running FirefoxOS (Bug 937928). On the
lower right corner, three other bugs related to mobile device cameras are recommended by NextBug, including their textual similarity with the short description of the original bug.

<a href="http://aserg.labsoft.dcc.ufmg.br/wordpress/wp-content/uploads/2015/04/NextBug-1.0-screenshot1.png"><img src="http://aserg.labsoft.dcc.ufmg.br/wordpress/wp-content/uploads/2015/04/NextBug-1.0-screenshot1.png" alt="NextBug 1.0 Screenshot 1" title="NextBug-1.0-screenshot1" width="580" /></a>
<!-- [gallery columns="2" orderby="title"] -->


<strong>Download</strong>

Download <a href="http://aserg.labsoft.dcc.ufmg.br/nextbug-downloads/NextBug-1.0-release.zip">NextBug 1.0 full release</a>.

<strong>How to Install</strong>
<ul>
	<li>Install  Bugzilla</li>
	<li>Unpack the contents of the <a href="../nextbug-downloads/NextBug-1.0-release.zip">Nextbug file</a> in the "extensions/" folder inside Bugzilla (a NextBug folder will be created).</li>
	<li>In NextBug folder there is a "required_libs" subfolder with Perl libraries. Install the libraries to your Perl interpreter (follow the instructions for each library). NextBug-1.x requires four libraries: Lingua-Stem-Snowball, Lingua-StopWords, Log4perl, and Math-Random-ISAAC.</li>
	<li>Set the NextBug folder (and all its subfolders) permissions, ownership and group to be the same as Bugzilla. Examples:
<ul>
	<li>Setting the permissions: "chmod -R 751 NextBug/"</li>
	<li>Setting the owner: "chown -R &lt;bugzilla-owner&gt; NextBug/"</li>
	<li>Setting the group: "chgrp -R &lt;bugzilla-group&gt; NextBug/".</li>
</ul>
</li>
	<li>Remove the "disabled" file inside the NextBug folder.</li>
	<li>Enjoy the features of NextBug.</li>
</ul>

<strong> Help Us Improve NextBug</strong>

NextBug is an academic project developed by members of this research group. If you are a NextBug user and wish to help us improve this tool, you can do it in one of the following ways:
<ul>
   <li> <a href="mailto:henrique.rocha@dcc.ufmg.br?subject=NextBug Log Files">Send to us</a> the NextBug log files (two files inside a "log" folder in the NextBug). The log files contains only anynomous usage information that will help us analyse and improve NextBug according to a real usage enviroment. </li>
   <li> <a href="mailto:henrique.rocha@dcc.ufmg.br?subject=NextBug Improvement Suggestion">Send an email</a> to us, with your suggestions on how to improve NextBug.</li>
</ul>

<strong>More Info</strong>

<a href="http://www.dcc.ufmg.br/~mtov/pub/2015_jserd.pdf"> <img src="http://aserg.labsoft.dcc.ufmg.br/wordpress/wp-content/plugins/papercite/img/pdf.png" alt="[PDF]" /></a> Henrique Rocha, Guilherme Oliveira, Humberto Maques-Neto, Marco Tulio Valente. NextBug: a Bugzilla extension for recommending similar bugs. <em>Journal of Software Engineering Research and Development</em>, pages 1-14, 2015.

<a href="http://www.dcc.ufmg.br/~mtov/pub/2014_cbsoft_nextbug.pdf"> <img src="http://aserg.labsoft.dcc.ufmg.br/wordpress/wp-content/plugins/papercite/img/pdf.png" alt="[PDF]" /></a> Henrique Rocha; Guilherme Oliveira; Humberto Maques-Neto; Marco Tulio Valente. NextBug: A Tool for Recommending Similar Bugs in Open-Source Systems. V Brazilian Conference on Software: Theory and Practice (Tools Track), p. 1-8, 2014. (<strong>best tool award</strong>)


