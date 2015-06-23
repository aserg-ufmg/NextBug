# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This Source Code Form is "Incompatible With Secondary Licenses", as
# defined by the Mozilla Public License, v. 2.0.

package Bugzilla::Extension::NextBug;
use strict;
use base qw(Bugzilla::Extension);

sub votes {
    my $cgi = Bugzilla->cgi;
   my $template = Bugzilla->template;
my $vars = {
    serial_no => 271828,
};

	$template->process("psages/nextbug/bug.html.tmpl",$vars)|| die $template->error();

 
}


__PACKAGE__->NAME;
