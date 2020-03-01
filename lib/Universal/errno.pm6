use Constants::Errno;

my Str $lib = $*DISTRO.is-win()
  ?? "Universal::errno::Windows"
  !! "Universal::errno::Unix";

require ::($lib);

my &real-errno := ::("{$lib}::EXPORT::DEFAULT::{'&errno'}");
my &real-set_errno := ::("{$lib}::EXPORT::DEFAULT::{'&set_errno'}");

#This uses a thread-safe strerror under the hood
my &real-strerror := ::("{$lib}::EXPORT::DEFAULT::{'&strerror'}");

module Universal::errno:ver<0.0.1>:auth<cpan:GARLANDG> {
  my sub errno() is export is raw { real-errno() }
  my sub set_errno(Int() $value) is export is raw { real-set_errno($value) }
  my sub strerror(Int() $value --> Str) is export { real-strerror($value) }
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

Universal::errno is a modification and extension of lizmat's C<Unix::errno>,
and exports the same C<errno> and C<set_errno> interface. It works on Linux,
Windows, Freebsd, Openbsd, Netbsd, Dragonflybsd, and Macos.

=head1 AUTHOR

Travis Gibson <TGib.Travis@protonmail.com>

=head2 CREDIT

Uses a heavily-modified C<Unix::errno> module for Unix-like OSes, and uses
C<Windows::errno> (also based on lizmat's C<Unix::errno>) for Windows OSes.

Universal::errno::Unix contains all of the modified code, and this README also
borrows the SYNOPSIS example above. The original README and COPYRIGHT
information for lizmat's C<Unix::errno> has been preserved in
C<Universal::errno::Unix>.

lizmat's C<Unix::errno> can be found at L<https://github.com/lizmat/Unix-errno>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
