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

Universal::errno is a modification and extension of lizmat's `Unix::errno`, and exports the same `errno` and `set_errno` interface. It works on Windows, Freebsd, Openbsd, Netbsd, Dragonflybsd, and Macos.

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

