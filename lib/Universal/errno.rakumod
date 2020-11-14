use if;

use Universal::errno::Constants;

use Universal::errno::Windows:if($*DISTRO.is-win());
use Universal::errno::Unix:if(not $*DISTRO.is-win());

class X::errno is Exception {
  has Errno:D $.errno is required;
  method message() { strerror(+$!errno) }
  method Str() { strerror(+$!errno) }
  method symbol() { $!errno }
  method Int() { +$!errno }
  method Numeric() { +$!errno }
  method gist() { "{self.Str} (errno = +$!errno)" }
  multi method new() {
    my $errno = Errno(+errno);
    set_errno(0);
    self.bless(:$errno);
  }
  multi method new(Int() $code) {
    my $errno = Errno($code);
    self.bless(:$errno);
  }

  multi method new(Errno $errno) {
    self.bless(:$errno);
  }

  multi method new(Errno :$errno) {
    self.bless(:$errno);
  }

  multi method new(Int() :errno($code)) {
    my $errno = Errno($code);
    self.bless(:$errno);
  }
}

module Universal::errno:ver<0.0.4>:auth<cpan:GARLANDG> {
  multi sub trait_mod:<is>(Routine $s, :$error-model where * ~~ "errno") is export {
    $s.wrap({
      my $result := callsame;
      $result < 0
      ?? do {
        my $error := X::errno.new(:errno(errno.symbol));
        set_errno(0);
        Failure.new($error);
      }
      !! $result;
    });
  }

  multi sub trait_mod:<is>(Routine $s, :$error-model where * ~~ "neg-errno") is export {
    $s.wrap({
      my $result := callsame;
      $result < 0
        ?? Failure.new(X::errno.new(:errno(Errno(-$result))))
        !! $result;
    });
  }
}

sub EXPORT() {
  %(
    '&errno' => &errno,
    '&set_errno' => &set_errno,
    '&strerror' => &strerror,
    'Errno' => Errno,
  );
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

Universal::errno is an extension of and wrapper around lizmat's C<Unix::errno>,
and exports the same C<errno> and C<set_errno> interface. It works on Linux,
Windows, and Macos. BSD support is untested, but should work.

One added feature is the C<strerror> method, which gets the string for the
error in a thread-safe way. On platforms that support it, it uses POSIX
C<strerror_l>. This allows getting the error string that corresponds to the
user's set locale. On platforms that don't support it, strerror_r (XSI) is used.
On Windows, this is done using C<GetLastError()> and C<FormatMessageW>.
Windows also has a C<SetLastError> function which is used instead of masking the value.

This module provides an Exception class, X::errno. To check the type of error
in a portable way, use the C<symbol> method and smartmatch against an entry in
the Errno enum.

It also provides a trait: error-model. Mark a sub or method with is error-model<errno>
and the trait will automatically box the errno for you and reset errno to 0.

For calls that return C<-errno>, there is also a trait error-model<neg-errno>.

As an example of a real-world scenario, this code sets up a socket using
socket(2) and handles the errors with a CATCH block.

=begin code :lang<raku>

use NativeCall;
sub socket(int32, int32, int32) returns int32 is native is error-model<errno> { ... }
my int32 $socket;

try {
  $socket = socket(AF::INET, SOCK_DGRAM, 0);
  CATCH {
    when X::errno {
      given .symbol {
        when Errno::EINVAL {
          die "Invalid socket type"
        }
        when Errno::EACCES {
          die "Permission denied"
        }
        ...
      }
    }
  }
}

=end code

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

Copyright 2020 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
