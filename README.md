NAME
====

Universal::Errno - Errno wrapper for Linux, Unix, and Windows

SYNOPSIS
========

```perl6
use Universal::Errno;

  set_errno(2);

  say errno;
  say "failed: {errno}";
  say +errno;              #2
```

DESCRIPTION
===========

Universal::Errno is an extension of and wrapper around lizmat´s `Unix::errno`, and exports the same `errno` and `set_errno` interface. It works on Linux, Windows, and Macos. BSD support is untested, but should work.

One added feature is the `strerror` method, which gets the string for the error in a thread-safe way. On platforms that support it, it uses POSIX `strerror_l`. This allows getting the error string that corresponds to the user´s set locale. On platforms that do not support it, strerror_r (XSI) is used. On Windows, this is done using `GetLastError()` and `FormatMessageW`. Windows also has a `SetLastError` function which is used instead of masking the value.

This module provides an Exception class, X::Errno. To check the type of error in a portable way, use the `symbol` method and smartmatch against an entry in the Errno enum.

It also provides a trait: error-model. Mark a sub or method with `is error-model<errno>` and the trait will automatically box the errno for you and reset errno to 0.

Important note: With a native sub, the `is native` trait must come before `is error-model`.

For calls that return `-errno`, there is also the trait `is error-model<neg-errno>`.

If high-performance is needed for a native sub that can return errno, use the `check-errno` and/or `check-neg-errno` subs. These subs are interchangeable with the traits, but cannot be directly applied to a nativecall subroutine.

As an example of a real-world scenario, this code sets up a socket using socket(2) and handles the errors with a CATCH block.

```raku
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
```

class X::Errno
--------------

Base exception class for errno

### method message

```raku
method message() returns Mu
```

Get the Str message for this errno value.

### method symbol

```raku
method symbol() returns Mu
```

Get the symbol of this errno value.

### method Int

```raku
method Int() returns Mu
```

Get the integer that corresponds to this errno value.

### method Numeric

```raku
method Numeric() returns Mu
```

Get the numeric value of this errno value.

### multi method new

```raku
multi method new() returns Mu
```

Get a new Errno exception from errno. This resets errno to 0.

Subs
====

### multi sub trait_mod:<is>

```raku
multi sub trait_mod:<is>(
    Routine $s,
    :$error-model where { ... }
) returns Mu
```

Trait to check return value of subroutine and throw X::Errno if return value is less than 1.

### multi sub trait_mod:<is>

```raku
multi sub trait_mod:<is>(
    Routine $s,
    :$error-model where { ... }
) returns Mu
```

Trait to check return value of subroutine and throw abs(return value) as X::Errno if return value is less than 1.

### sub check-neg-errno

```raku
sub check-neg-errno(
    Int $result
) returns Mu
```

Check the result against the negative errno form.

### sub check-errno

```raku
sub check-errno(
    Int $result
) returns Mu
```

Check the result against the errno() form.

AUTHOR
======

Travis Gibson <TGib.Travis@protonmail.com>

CREDIT
------

Uses a heavily-modified `Unix::errno` module for Unix-like OSes. The Windows version module borrows its structure and interface from lizmat's `Unix::errno`.

Universal::Errno::Unix contains all of the modified code, and this README also borrows the SYNOPSIS example above. The original README and COPYRIGHT information for lizmat's `Unix::errno` has been preserved in `Universal::Errno::Unix`.

lizmat's `Unix::errno` can be found at [https://github.com/lizmat/Unix-errno](https://github.com/lizmat/Unix-errno)

COPYRIGHT AND LICENSE
=====================

Copyright 2021 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

