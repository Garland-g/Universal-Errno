NAME
====

Universal::errno - Wrapper for errno modules for Unix and Windows

SYNOPSIS
========

```perl6
use Universal::errno;

  set_errno(2);

  say errno;
  say "failed: {errno}";
  say +errno;              #2
```

DESCRIPTION
===========

Universal::errno is an extension of and wrapper around lizmat's `Unix::errno`, and exports the same `errno` and `set_errno` interface. It works on Linux, Windows, and Macos. BSD support is untested, but should work.

One added feature is the `strerror` method, which gets the string for the error in a thread-safe way. On platforms that support it, it uses POSIX `strerror_l`. This allows getting the error string that corresponds to the user's set locale. On platforms that don't support it, strerror_r (XSI) is used. On Windows, this is done using `GetLastError()` and `FormatMessageW`. Windows also has a `SetLastError` function which is used instead of masking the value.

This module provides an Exception class, X::errno. To check the type of error in a portable way, use the `symbol` method and smartmatch against an entry in the Errno enum.

It also provides a trait: error-model. Mark a sub or method with `is error-model<errno>` and the trait will automatically box the errno for you and reset errno to 0.

Important note: With a native sub, the `is native` trait must come before `is error-model`.

For calls that return `-errno`, there is also the trait `is error-model<neg-errno>`.

If high-performance is needed for a native sub that can return errno, use the `check-errno` and/or `check-neg-errno` subs. These subs are interchangeable with the traits, but cannot be directly applied to a nativecall subroutine.

As an example of a real-world scenario, this code sets up a socket using socket(2) and handles the errors with a CATCH block.

```raku
use NativeCall;
use Constants::Sys::Socket;

sub socket(int32, int32, int32) returns int32 is native is error-model<errno> { ... }
my int32 $socket;

try {
  $socket = socket(AF::INET, SOCK_DGRAM, 0);

  # Do something with $socket

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
```

class X::errno
--------------

Exception class for errno

### method message

```perl6
method message() returns Mu
```

Get the Str message for this errno value.

### method symbol

```perl6
method symbol() returns Mu
```

Get the symbol of this errno value.

### method Int

```perl6
method Int() returns Mu
```

Get the integer that corresponds to this errno value.

Subs
====

### sub check-neg-errno

```perl6
sub check-neg-errno(
    Int $result
) returns Mu
```

Check the result against the negative errno form.

### sub check-errno

```perl6
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

Uses a heavily-modified `Unix::errno` module for Unix-like OSes, and uses `Windows::errno` (also based on lizmat's `Unix::errno`) for Windows OSes.

Universal::errno::Unix contains all of the modified code, and this README also borrows the SYNOPSIS example above. The original README and COPYRIGHT information for lizmat's `Unix::errno` has been preserved in `Universal::errno::Unix`.

lizmat's `Unix::errno` can be found at [https://github.com/lizmat/Unix-errno](https://github.com/lizmat/Unix-errno)

COPYRIGHT AND LICENSE
=====================

Copyright 2020 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

