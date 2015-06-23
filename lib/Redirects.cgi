#!/usr/bin/perl 
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.
use lib '../../../';
use strict;
use lib qw(. lib);
use Bugzilla;
use GetSimilares;
use Bugzilla::Constants;
use Bugzilla::Error;
use Bugzilla::Util;
use Bugzilla::Field;
use Bugzilla::Token;
use Logging;
my $cgi = Bugzilla->cgi;

my $idbugrecommended = $cgi->param('idbugrecommended');
my $idbugOri         = $cgi->param('idbugori');
my $idusu            = $cgi->param('idusu');
my $loggingString    = ";" . $idusu . ";" . $idbugOri . ";" . $idbugrecommended;

Logging->setLogging( $loggingString, "../log/nextbug-recommendations1.log" );

my $vars = {};
print $cgi->redirect("../../../show_bug.cgi?id=$idbugrecommended");
print $cgi->header(), $cgi->start_html(''),    # start the HTML

  "<div id='nextb_recommendations'><p>No recommendations for this search</p>",
  $cgi->h1($idbugrecommended);
"</div>", $cgi->end_html;

