use v6.c;

use Constants::Errno;

use NativeCall;

class locale_t is repr('CPointer') {}

my sub freelocale(locale_t $locale) is native { ... }

my sub newlocale(int32 $mask, Str $locale, int32 $base) returns locale_t is native { ... }

my sub strerror_l(int32 $errno, locale_t $locale) returns Str is native { ... }

my constant CLIB = $*KERNEL.name eq 'darwin'
  ?? 'libSystem.B.dylib'
  !! 'libc.so.6';   # other variations may need to be added later
my int $last_set = 0;
my int $last_seen_native
  = my $ERRNO := cglobal(CLIB, "errno", int32);

my class errno {
    method !index() {
        my int $errno_now = $ERRNO;
        $last_set = $last_seen_native = $errno_now
          if $last_seen_native != $errno_now;
        $last_set
    }
    method Str(--> Str:D)  {
      my $index = self!index;
      my $current_errno = E($index);
      my $locale = newlocale(0, "C", 0);
      die "While handling error of type {$current_errno}, another error occurred:\n {self.symbol}" unless $locale ~~ locale_t;
      my Str $error = "" ~ strerror_l($index, $locale);
      freelocale($locale);
      return $error;
    }
    method gist(--> Str:D) {
        if self!index -> $index {
          "{self.Str} (errno = $index)"
        }
        else {
            ""
        }
    }
    method Numeric(--> Int:D) { self!index }
    method symbol(--> E:D) { E(self.Numeric) }
}

module Universal::errno::Unix:ver<0.0.2>:auth<cpan:ELIZABETH> {
    my $proxy := Proxy.new(
      FETCH => -> $ { UNIT::errno },
      STORE => -> $, $value { set_errno($value) }
    );

    my sub errno() is export is raw { $proxy }
    my sub set_errno(Int() $value) is export is raw {
        $last_seen_native = $ERRNO;  # ignore any changes until now
        $last_set = $value;
        $proxy
    }
}

=begin pod

=head1 NAME

Unix::errno - Provide transparent access to errno

=head1 SYNOPSIS

    use Unix::errno;  # exports errno, set_errno

    set_errno(2);

    say errno;              # No such file or directory (errno = 2)
    say "failed: {errno}";  # failed: No such file or directory
    say +errno;             # 2

=head1 DESCRIPTION

This module provides access to the C<errno> variable that is available on
all Unix-like systems.  Please note that in a threaded environment such as
Perl 6 is, the value of C<errno> is even more volatile than it has been
already.  For now, this issue is ignored.

=head1 CAVEATS

Since setting of any "extern" variables is not supported yet by C<NativeCall>,
the setting of C<errno> is faked.  If C<set_errno> is called, it will set
the value only in a shadow copy.  That value will be returned As long as
the underlying "real" errno doesn't change (at which point that value
will be returned.

=head1 AUTHOR

Elizabeth Mattijsen <liz@wenzperl.nl>

Source can be located at: https://github.com/lizmat/Unix-errno . Comments and
Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

