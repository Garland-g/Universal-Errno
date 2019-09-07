
my Str $lib = $*DISTRO.is-win()
  ?? "Windows::errno"
  !! "Unix::errno";

require ::($lib);

my &real-errno := ::("{$lib}::EXPORT::DEFAULT::{'&errno'}");
my &real-set_errno := ::("{$lib}::EXPORT::DEFAULT::{'&set_errno'}");

module Universal::errno:ver<0.0.1>:auth<cpan:GARLANDG> {
  my sub errno() is export is raw { real-errno() }
  my sub set_errno(Int() $value) is export is raw { real-set_errno($value) }

}

=begin pod

=head1 NAME

Universal::errno - Wrapper for errno modules for Unix and Windows

=head1 SYNOPSIS

=begin code :lang<perl6>

use Universal::errno;

  set_errno(2);

  say errno;
  say "failed: {errno}";
  say +errno;              #2

=end code

=head1 DESCRIPTION

Universal::errno loads the correct module based on your operating system and
exports the same C<errno> and C<set_errno> interface.

When installing this module, it will install C<Windows::errno> on Windows,
and C<Unix::errno> on everything else.

=head1 AUTHOR

Travis Gibson <TGib.Travis@protonmail.com>

=head2 CREDIT

Uses lizmat's C<Unix::errno> for Unix-like OSes, and uses C<Windows::errno>
(based on lizmat's C<Unix::errno>) for Windows OSes.

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
