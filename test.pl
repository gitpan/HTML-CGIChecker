
# $Id: test.pl,v 1.13 2001/06/02 16:13:09 trip Exp $

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

BEGIN { $| = 1; print "1..last_test_to_print\n"; }
END { print "not ok 1\n" unless $loaded; }

use CGIChecker;

##############################################################################

print "---------------------------\n";
print "2..checkHTML - valid HTML\n";

$str = '
<A HREF="www.cpan.org" TARGET=_top>CPAN</A>
<A HREF="www.cpan.org">CPAN</A>
<A HREF=www.cpan.org>CPAN</A>
<A TEST="" HREF=www.cpan.org>CPAN</A>
<A TEST="" HREF=www.cpan.org ALT="test">CPAN</A>

<TABLE>
	<TR>
		<TD>One column</TD>
	</TR>
</TABLE>
<BR>
This is a new Perl module.
" Arrays & variables "

Dave > hello !

And now some Perl code:
<PRE>
	print "
	<HTML><BODY>
	</BODY></HTML>
	";
</PRE>

<IMG ALT="pokus" SRC="my.server.com/a.gif" HEIGHT=60 WIDTH=70>
<IMG ALT="pokus" SRC="http://my.server.com/a.gif">
<IMG SRC=http://my.server.com/a.gif>
<IMG SRC=http://my.server.com/a.gif WIDTH="40">

<HR>
';

$checker = new HTML::CGIChecker (
	mode => 'allow',
	allowclasses => [ qw( tables images ) ],
	allowtags => [ qw ( B I A U STRONG BR HR ) ],	
	jscript => 0,
	html => 0,
	pre => 1,
	debug => 0,
	img_to_link => 1,
	check_http => 1
);

($str_new, $Errors) = $checker->checkHTML($str);

print $str_new."\n";
print "ok 2\n" if ($str_new and not @{$Errors});

##############################################################################

print "---------------------------\n";
print "3..checkHTML - invalid HTML\n";

$str = '
<HTML>
<BODY>
    <TABLE>
    <TR>
    <TD></TD>

    </TABLE>
</BODY>
</HTML>
';

$checker = new HTML::CGIChecker (
	mode => 'allow',
	allowclasses => [ qw( tables images ) ],
	allowtags => [ qw ( B I A U STRONG BR HR ) ],	
	jscript => 0,
	html => 0,
	pre => 1,
	debug => 0,
	err_notclosed => 'The fucking pair tag {tag} was not closed !'
);

print $str."\n\n";

($str_new, $Errors) = $checker->checkHTML($str);

print join ("\n", @{$Errors});
print "\n";
print "ok 3\n" if (!$str_new and @{$Errors});

##############################################################################

print "---------------------------\n";
print "4..checkHTML - invalid HTML\n";

$str = '
<HTML>
<BODY>
    <TR>
    <TD></TD>

    </TABLE>
	<H1>Pokus</H1>
	<A HREF="javascript:func()">test</A>
</BODY>
</HTML>
';

$checker = new HTML::CGIChecker (
	mode => 'deny',
	denytags => [ qw ( H1 ) ],	
	jscript => 0,
	html => 0,
	pre => 1,
	debug => 0
);

print $str."\n\n";

($str_new, $Errors) = $checker->checkHTML($str);

print join ("\n", @{$Errors});
print "\n";
print "ok 4\n" if (!$str_new and @{$Errors});

##############################################################################

print "---------------------------\n";
print "5..checkHTML - check_attrib\n";

$str = '
<HTML>
<BODY COLOR=blue>
  <IMG src="test.gif" width="40" test="value" height="60">
</BODY>
</HTML>
';

$checker = new HTML::CGIChecker (
	mode => 'deny',
	denytags => [ qw ( H1 ) ],	
	jscript => 0,
	html => 0,
	pre => 1,
	debug => 0,
	check_attribs => {
	  img => [ 'src', 'width', 'height' ]
	}
);

print $str."\n\n";

($str_new, $Errors) = $checker->checkHTML($str);

print join ("\n", @{$Errors});
print "\n";
print "ok 4\n" if (!$str_new and @{$Errors});

##############################################################################


$loaded = 1;
print "ok 1\n";

