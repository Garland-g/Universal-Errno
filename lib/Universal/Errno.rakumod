=begin pod

=head1 NAME

Universal::Errno - Errno wrapper for Linux, Unix, and Windows

=head1 SYNOPSIS

=begin code :lang<perl6>

use Universal::Errno;

  set_errno(2);

  say errno;
  say "failed: {errno}";
  say +errno;              #2

=end code

=head1 DESCRIPTION

Universal::Errno is an extension of and wrapper around lizmat´s C<Unix::errno>,
and exports the same C<errno> and C<set_errno> interface. It works on Linux,
Windows, and Macos. BSD support is untested, but should work.

One added feature is the C<strerror> method, which gets the string for the
error in a thread-safe way. On platforms that support it, it uses POSIX
C<strerror_l>. This allows getting the error string that corresponds to the
user´s set locale. On platforms that do not support it, strerror_r (XSI) is used.
On Windows, this is done using C<GetLastError()> and C<FormatMessageW>.
Windows also has a C<SetLastError> function which is used instead of masking the value.

This module provides an Exception class, X::Errno. To check the type of error
in a portable way, use the C<symbol> method and smartmatch against an entry in
the Errno enum.

It also provides a trait: error-model. Mark a sub or method with C<is error-model<errno>>
and the trait will automatically box the errno for you and reset errno to 0.

Important note: With a native sub, the C<is native> trait must come before C<is error-model>.

For calls that return C<-errno>, there is also the trait C<is error-model<neg-errno>>.

If high-performance is needed for a native sub that can return errno, use the
C<check-errno> and/or C<check-neg-errno> subs. These subs are interchangeable
with the traits, but cannot be directly applied to a nativecall subroutine.

As an example of a real-world scenario, this code sets up a socket using
socket(2) and handles the errors with a CATCH block.

=begin code :lang<raku>

use NativeCall;
use Constants::Sys::Socket;
use Universal::Errno;

sub socket(int32, int32, int32) returns int32 is native is error-model<errno> { ... }
my int32 $socket;

try {
  $socket = socket(AF::INET, SOCK_DGRAM, 0);

  # Do something with $socket

  CATCH {
    when X::Errno {
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

=end pod

use if;

use Universal::Errno::Constants;
use Universal::Errno::Windows:if($*DISTRO.is-win());
use Universal::Errno::Unix:if(not $*DISTRO.is-win());

#| Base exception class for errno
class X::Errno is Exception {
    has Errno:D $.errno is required;
    #| Get the Str message for this errno value.
    method message() {
        strerror(+$!errno)
    }
    #|
    method Str() {
        strerror(+$!errno)
    }

    #| Get the symbol of this errno value.
    method symbol() {
        $!errno
    }

    #| Get the integer that corresponds to this errno value.
    method Int() {
        +$!errno
    }

    #| Get the numeric value of this errno value.
    method Numeric() {
        +$!errno
    }

    method gist() {
        "{ self.Str } (errno = +$!errno)"
    }

    #| Get a new Errno exception from errno.
    #| This resets errno to 0.
    multi method new() {
        my $errno = Errno(+errno);
        set_errno(0);
        self.bless(:$errno)
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

    method WHICH() {
        "X::Errno|{+$!errno}"
    }
}
=begin pod

=head1 Subs

=end pod

module Universal::Errno:ver<0.2.0>:auth<cpan:GARLANDG> {
  #| Trait to check return value of subroutine and throw X::Errno if
  #| return value is less than 1.
  multi sub trait_mod:<is>(Routine $s, :$error-model where * ~~ "errno") is export {
    $s.wrap(-> |c {
      my $result := callwith(|c);
      $result < 0
      ?? do {
        my $error := X::Errno.new(:errno(errno.symbol));
        set_errno(0);
        Failure.new($error);
      }
      !! $result;
    });
  }

  #| Trait to check return value of subroutine and throw
  #| abs(return value) as X::Errno if return value is less than 1.
  multi sub trait_mod:<is>(Routine $s, :$error-model where * ~~ "neg-errno") is export {
    $s.wrap(-> |c {
      my $result := callwith(|c);
      $result < 0
        ?? Failure.new(X::Errno.new(:errno(Errno(-$result))))
        !! $result;
    });
  }

  #| Check the result against the negative errno form.
  sub check-neg-errno(Int $result) is inlinable is export {
    $result < 0
      ?? Failure.new(X::Errno.new(:errno(Errno(-$result))))
      !! $result;
  }

  #| Check the result against the errno() form.
  sub check-errno(Int $result) is inlinable is export {
    $result < 0
      ?? do {
        my $error := X::Errno.new(:errno(errno.symbol));
        set_errno(0);
        Failure.new($error)
      }
      !! $result;
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

=head1 AUTHOR

Travis Gibson <TGib.Travis@protonmail.com>

=head2 CREDIT

Uses a heavily-modified C<Unix::errno> module for Unix-like OSes. The Windows version
module borrows its structure and interface from lizmat's C<Unix::errno>.

Universal::Errno::Unix contains all of the modified code, and this README also
borrows the SYNOPSIS example above. The original README and COPYRIGHT
information for lizmat's C<Unix::errno> has been preserved in
C<Universal::Errno::Unix>.

lizmat's C<Unix::errno> can be found at L<https://github.com/lizmat/Unix-errno>

=head1 COPYRIGHT AND LICENSE

Copyright 2021 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
