NAME
====

Universal::errno - Wrapper for errno modules for Unix and Windows

SYNOPSIS
========

```raku
use Universal::errno;

  set_errno(2);

  say errno;
  say "failed: {errno}";
  say +errno;              #2
```

DESCRIPTION
===========

Universal::errno is an extension of and wrapper around lizmat's `Unix::errno`, and exports the same `errno` and `set_errno` interface. It works on Linux, Windows, Freebsd, Openbsd, Netbsd, Dragonflybsd, and Macos.

One added feature is the `strerror` method, which gets the string for the error in a thread-safe way using POSIX `strerror_l`. This allows getting the error string that corresponds to the user's set locale. On Windows, this is done using `GetLastError()` and `FormatMessageW`. Windows also has a `SetLastError` function which is used instead of masking the value.

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

Copyright 2019 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

