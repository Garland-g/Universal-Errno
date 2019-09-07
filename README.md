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

Universal::errno loads the correct module based on your operating system and exports the same `errno` and `set_errno` interface.

When installing this module, it will install `Windows::errno` on Windows, and `Unix::errno` on everything else.

AUTHOR
======

Travis Gibson <TGib.Travis@protonmail.com>

CREDIT
------

Uses lizmat's `Unix::errno` for Unix-like OSes, and uses `Windows::errno` (based on lizmat's `Unix::errno`) for Windows OSes.

COPYRIGHT AND LICENSE
=====================

Copyright 2019 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

