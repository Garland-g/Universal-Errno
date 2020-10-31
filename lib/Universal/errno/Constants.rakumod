use v6.c;

=begin pod

=head1 NAME

Universal::errno::Constants - Errno codes

=head1 SYNOPSIS

=begin code :lang<perl6>

use Universal::errno::Constants;

say EAGAIN.Int;
say E2BIG.Int;

=end code

=head1 DESCRIPTION

Universal::errno::Contants maps errno constants in C to the
appropriate number for your platform.

This module should be compatible with windows, macos, linux, netbsd,
freebsd, openbsd, and dragonflybsd. Each platform will receive a
slightly different enumeration.

Based on C headers found on official sites and unofficial mirrors of
source trees.

=head1 AUTHOR

Travis Gibson <TGib.Travis@protonmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

unit module Universal::errno::Contants:ver<0.0.2>:auth<cpan:GARLAND_G>;

enum Errno is export ($*KERNEL.name eq 'linux' ?? do {
    EPERM => 1,
    ENOENT => 2,
    ESRCH => 3,
    EINTR => 4,
    EIO => 5,
    ENXIO => 6,
    E2BIG => 7,
    ENOEXEC => 8,
    EBADF => 9,
    ECHILD => 10,
    EAGAIN => 11,
    EWOULDBLOCK => 11,
    ENOMEM => 12,
    EACCES => 13,
    EFAULT => 14,
    ENOTBLK => 15,
    EBUSY => 16,
    EEXIST => 17,
    EXDEV => 18,
    ENODEV => 19,
    ENOTDIR => 20,
    EISDIR => 21,
    EINVAL => 22,
    ENFILE => 23,
    EMFILE => 24,
    ENOTTY => 25,
    ETXTBSY => 26,
    EFBIG => 27,
    ENOSPC => 28,
    ESPIPE => 29,
    EROFS => 30,
    EMLINK => 31,
    EPIPE => 32,
    EDOM => 33,
    ERANGE => 34,
    EDEADLK => 35,
    EDEADLOCK => 35,
    ENAMETOOLONG => 36,
    ENOLCK => 37,
    ENOSYS => 38,
    ENOTEMPTY => 39,
    ELOOP => 40,
    ENOMSG => 42,
    EIDRM => 43,
    ECHRNG => 44,
    EL2NSYNC => 45,
    EL3HLT => 46,
    EL3RST => 47,
    ELNRNG => 48,
    EUNATCH => 49,
    ENOCSI => 50,
    EL2HLT => 51,
    EBADE => 52,
    EBADR => 53,
    EXFULL => 54,
    ENOANO => 55,
    EBADRQC => 56,
    EBADSLT => 57,
    EBFONT => 59,
    ENOSTR => 60,
    ENODATA => 61,
    ETIME => 62,
    ENOSR => 63,
    ENONET => 64,
    ENOPKG => 65,
    EREMOTE => 66,
    ENOLINK => 67,
    EADV => 68,
    ESRMNT => 69,
    ECOMM => 70,
    EPROTO => 71,
    EMULTIHOP => 72,
    EDOTDOT => 73,
    EBADMSG => 74,
    EOVERFLOW => 75,
    ENOTUNIQ => 76,
    EBADFD => 77,
    EREMCHG => 78,
    ELIBACC => 79,
    ELIBBAD => 80,
    ELIBSCN => 81,
    ELIBMAX => 82,
    ELIBEXEC => 83,
    EILSEQ => 84,
    ERESTART => 85,
    ESTRPIPE => 86,
    EUSERS => 87,
    ENOTSOCK => 88,
    EDESTADDRREQ => 89,
    EMSGSIZE => 90,
    EPROTOTYPE => 91,
    ENOPROTOOPT => 92,
    EPROTONOSUPPORT => 93,
    ESOCKTNOSUPPORT => 94,
    EOPNOTSUPP => 95,
    ENOTSUP => 95,
    EPFNOSUPPORT => 96,
    EAFNOSUPPORT => 97,
    EADDRINUSE => 98,
    EADDRNOTAVAIL => 99,
    ENETDOWN => 100,
    ENETUNREACH => 101,
    ENETRESET => 102,
    ECONNABORTED => 103,
    ECONNRESET => 104,
    ENOBUFS => 105,
    EISCONN => 106,
    ENOTCONN => 107,
    ESHUTDOWN => 108,
    ETOOMANYREFS => 109,
    ETIMEDOUT => 110,
    ECONNREFUSED => 111,
    EHOSTDOWN => 112,
    EHOSTUNREACH => 113,
    EALREADY => 114,
    EINPROGRESS => 115,
    ESTALE => 116,
    EUCLEAN => 117,
    ENOTNAM => 118,
    ENAVAIL => 119,
    EISNAM => 120,
    EREMOTEIO => 121,
    EDQUOT => 122,
    ENOMEDIUM => 123,
    EMEDIUMTYPE => 124,
    ECANCELED => 125,
    ENOKEY => 126,
    EKEYEXPIRED => 127,
    EKEYREVOKED => 128,
    EKEYREJECTED => 129,
    EOWNERDEAD => 130,
    ENOTRECOVERABLE => 131,
    ERFKILL => 132,
    EHWPOISON => 133,
} !!  ($*KERNEL.name eq any('netbsd') ?? do {
    EPERM => 1,
    ENOENT => 2,
    ESRCH => 3,
    EINTR => 4,
    EIO => 5,
    ENXIO => 6,
    E2BIG => 7,
    ENOEXEC => 8,
    EBADF => 9,
    ECHILD => 10,
    EDEADLK => 11,
    EDEADLOCK => 11,
    ENOMEM => 12,
    EACCES => 13,
    EFAULT => 14,
    ENOTBLK => 15,
    EBUSY => 16,
    EEXIST => 17,
    EXDEV => 18,
    ENODEV => 19,
    ENOTDIR => 20,
    EISDIR => 21,
    EINVAL => 22,
    ENFILE => 23,
    EMFILE => 24,
    ENOTTY => 25,
    ETXTBSY => 26,
    EFBIG => 27,
    ENOSPC => 28,
    ESPIPE => 29,
    EROFS => 30,
    EMLINK => 31,
    EPIPE => 32,
    EDOM => 33,
    ERANGE => 34,
    EAGAIN => 35,
    EWOULDBLOCK => 35,
    EINPROGRESS => 36,
    EALREADY => 37,
    ENOTSOCK => 38,
    EDESTADDRREQ => 39,
    EMSGSIZE => 40,
    EPROTOTYPE => 41,
    ENOPROTOOPT => 42,
    EPROTONOSUPPORT => 43,
    ESOCKTNOSUPPORT => 44,
    EOPNOTSUPP => 45,
    EPFNOSUPPORT => 46,
    EAFNOSUPPORT => 47,
    EADDRINUSE => 48,
    EADDRNOTAVAIL => 49,
    ENETDOWN => 50,
    ENETUNREACH => 51,
    ENETRESET => 52,
    ECONNABORTED => 53,
    ECONNRESET => 54,
    ENOBUFS => 55,
    EISCONN => 56,
    ENOTCONN => 57,
    ESHUTDOWN => 58,
    ETOOMANYREFS => 59,
    ETIMEDOUT => 60,
    ECONNREFUSED => 61,
    ELOOP => 62,
    ENAMETOOLONG => 63,
    EHOSTDOWN => 64,
    EHOSTUNREACH => 65,
    ENOTEMPTY => 66,
    EPROCLIM => 67,
    EUSERS => 68,
    EDQUOT => 69,
    ESTALE => 70,
    EREMOTE => 71,
    EBADRPC => 72,
    ERPCMISMATCH => 73,
    EPROGUNAVAIL => 74,
    EPROGMISMATCH => 75,
    EPROCUNAVAIL => 76,
    ENOLCK => 77,
    ENOSYS => 78,
    EFTYPE => 79,
    EAUTH => 80,
    ENEEDAUTH => 81,
    EIDRM => 82,
    ENOMSG => 83,
    EOVERFLOW => 84,
    EILSEQ => 85,
    ENOTSUP => 86,
    ECANCELLED => 87,
    EBADMSG => 88,
    ENODATA => 89,
    ENOSR => 90,
    ENOSTR => 91,
    ETIME => 92,
    ENOATTR => 93,
    EMULTIHOP => 94,
    ENOLINK => 95,
    EPROTO => 96,
    ELAST => 96,
} !! ($*KERNEL.name eq 'dragonfly' ?? {
    EPERM => 1,
    ENOENT => 2,
    ESRCH => 3,
    EINTR => 4,
    EIO => 5,
    ENXIO => 6,
    E2BIG => 7,
    ENOEXEC => 8,
    EBADF => 9,
    ECHILD => 10,
    EDEADLK => 11,
    EDEADLOCK => 11,
    ENOMEM => 12,
    EACCES => 13,
    EFAULT => 14,
    ENOTBLK => 15,
    EBUSY => 16,
    EEXIST => 17,
    EXDEV => 18,
    ENODEV => 19,
    ENOTDIR => 20,
    EISDIR => 21,
    EINVAL => 22,
    ENFILE => 23,
    EMFILE => 24,
    ENOTTY => 25,
    ETXTBSY => 26,
    EFBIG => 27,
    ENOSPC => 28,
    ESPIPE => 29,
    EROFS => 30,
    EMLINK => 31,
    EPIPE => 32,
    EDOM => 33,
    ERANGE => 34,
    EAGAIN => 35,
    EWOULDBLOCK => 35,
    EINPROGRESS => 36,
    EALREADY => 37,
    ENOTSOCK => 38,
    EDESTADDRREQ => 39,
    EMSGSIZE => 40,
    EPROTOTYPE => 41,
    ENOPROTOOPT => 42,
    EPROTONOSUPPORT => 43,
    ESOCKTNOSUPPORT => 44,
    EOPNOTSUPP => 45,
    ENOTSUP => 45,
    EPFNOSUPPORT => 46,
    EAFNOSUPPORT => 47,
    EADDRINUSE => 48,
    EADDRNOTAVAIL => 49,
    ENETDOWN => 50,
    ENETUNREACH => 51,
    ENETRESET => 52,
    ECONNABORTED => 53,
    ECONNRESET => 54,
    ENOBUFS => 55,
    EISCONN => 56,
    ENOTCONN => 57,
    ESHUTDOWN => 58,
    ETOOMANYREFS => 59,
    ETIMEDOUT => 60,
    ECONNREFUSED => 61,
    ELOOP => 62,
    ENAMETOOLONG => 63,
    EHOSTDOWN => 64,
    EHOSTUNREACH => 65,
    ENOTEMPTY => 66,
    EPROCLIM => 67,
    EUSERS => 68,
    EDQUOT => 69,
    ESTALE => 70,
    EREMOTE => 71,
    EBADRPC => 72,
    ERPCMISMATCH => 73,
    EPROGUNAVAIL => 74,
    EPROGMISMATCH => 75,
    EPROCUNAVAIL => 76,
    ENOLCK => 77,
    ENOSYS => 78,
    EFTYPE => 79,
    EAUTH => 80,
    ENEEDAUTH => 81,
    EIDRM => 82,
    ENOMSG => 83,
    EOVERFLOW => 84,
    ECANCELLED => 85,
    EILSEQ => 86,
    ENOATTR => 87,
    EDOOFUS => 88,
    EBADMSG => 89,
    EMULTIHOP => 90,
    ENOLINK => 91,
    EPROTO => 92,
    ENOMEDIUM => 93,
    EASYNC => 99,
    ELAST => 99,
} !! ($*DISTRO.is-win() ?? do {
    EPERM => 1,
    ENOENT => 2,
    ESRCH => 3,
    EINTR => 4,
    EIO => 5,
    ENXIO => 6,
    E2BIG => 7,
    ENOEXEC => 8,
    EBADF => 9,
    ECHILD => 10,
    EAGAIN => 11,
    ENOMEM => 12,
    EACCES => 13,
    EFAULT => 14,
    EBUSY => 16,
    EEXIST => 17,
    EXDEV => 18,
    ENODEV => 19,
    ENOTDIR => 20,
    EISDIR => 21,
    ENFILE => 23,
    EMFILE => 24,
    ENOTTY => 25,
    EFBIG => 27,
    ENOSPC => 28,
    ESPIPE => 29,
    EROFS => 30,
    EMLINK => 31,
    EPIPE => 32,
    EDOM => 33,
    EDEADLK => 36,
    EDEADLOCK => 36,
    ENAMETOOLONG => 38,
    ENOLCK => 39,
    ENOSYS => 40,
    ENOTEMPTY => 41,
    EINVAL => 22,
    ERANGE => 34,
    EILSEQ => 42,
    ETRUNCATE => 80,
    EADDRINUSE => 100,
    EADDRNOTAVAIL => 101,
    EAFNOSUPPORT => 102,
    EALREADY => 103,
    EBADMSG => 104,
    ECANCELED => 105,
    ECONNABORTED => 106,
    ECONNREFUSED => 107,
    ECONNRESET => 108,
    EDESTADDRREQ => 109,
    EHOSTUNREACH => 110,
    EIDRM => 111,
    EINPROGRESS => 112,
    EISCONN => 113,
    ELOOP => 114,
    EMSGSIZE => 115,
    ENETDOWN => 116,
    ENETRESET => 117,
    ENETUNREACH => 118,
    ENOBUFS => 119,
    ENODATA => 120,
    ENOLINK => 121,
    ENOMSG => 122,
    ENOPROTOOPT => 123,
    ENOSR => 124,
    ENOSTR => 125,
    ENOTCONN => 126,
    ENOTRECOVERABLE => 127,
    ENOTSOCK => 128,
    ENOTSUP => 129,
    EOPNOTSUPP => 130,
    EOTHER => 131,
    EOVERFLOW => 132,
    EOWNERDEAD => 133,
    EPROTO => 134,
    EPROTONOSUPPORT => 135,
    EPROTOTYPE => 136,
    ETIME => 137,
    ETIMEDOUT => 138,
    ETXTBSY => 139,
    EWOULDBLOCK => 140,
} !! ($*KERNEL.name eq 'freebsd' ?? do {
    EPERM => 1,
    ENOENT => 2,
    ESRCH => 3,
    EINTR => 4,
    EIO => 5,
    ENXIO => 6,
    E2BIG => 7,
    ENOEXEC => 8,
    EBADF => 9,
    ECHILD => 10,
    EDEADLK => 11,
    EDEADLOCK => 11,
    ENOMEM => 12,
    EACCES => 13,
    EFAULT => 14,
    ENOTBLK => 15,
    EBUSY => 16,
    EEXIST => 17,
    EXDEV => 18,
    ENODEV => 19,
    ENOTDIR => 20,
    EISDIR => 21,
    EINVAL => 22,
    ENFILE => 23,
    EMFILE => 24,
    ENOTTY => 25,
    ETXTBSY => 26,
    EFBIG => 27,
    ENOSPC => 28,
    ESPIPE => 29,
    EROFS => 30,
    EMLINK => 31,
    EPIPE => 32,
    EDOM => 33,
    ERANGE => 34,
    EAGAIN => 35,
    EWOULDBLOCK => 35,
    EINPROGRESS => 36,
    EALREADY => 37,
    ENOTSOCK => 38,
    EDESTADDRREQ => 39,
    EMSGSIZE => 40,
    EPROTOTYPE => 41,
    ENOPROTOOPT => 42,
    EPROTONOSUPPORT => 43,
    ESOCKTNOSUPPORT => 44,
    EOPNOTSUPP => 45,
    ENOTSUP => 45,
    EPFNOSUPPORT => 46,
    EAFNOSUPPORT => 47,
    EADDRINUSE => 48,
    EADDRNOTAVAIL => 49,
    ENETDOWN => 50,
    ENETUNREACH => 51,
    ENETRESET => 52,
    ECONNABORTED => 53,
    ECONNRESET => 54,
    ENOBUFS => 55,
    EISCONN => 56,
    ENOTCONN => 57,
    ESHUTDOWN => 58,
    ETOOMANYREFS => 59,
    ETIMEDOUT => 60,
    ECONNREFUSED => 61,
    ELOOP => 62,
    ENAMETOOLONG => 63,
    EHOSTDOWN => 64,
    EHOSTUNREACH => 65,
    ENOTEMPTY => 66,
    EPROCLIM => 67,
    EUSERS => 68,
    EDQUOT => 69,
    ESTALE => 70,
    EREMOTE => 71,
    EBADRPC => 72,
    ERPCMISMATCH => 73,
    EPROGUNAVAIL => 74,
    EPROGMISMATCH => 75,
    EPROCUNAVAIL => 76,
    ENOLCK => 77,
    ENOSYS => 78,
    EFTYPE => 79,
    EAUTH => 80,
    ENEEDAUTH => 81,
    EIDRM => 82,
    ENOMSG => 83,
    EOVERFLOW => 84,
    ECANCELLED => 85,
    EILSEQ => 86,
    ENOATTR => 87,
    EDOOFUS => 88,
    EBADMSG => 89,
    EMULTIHOP => 90,
    ENOLINK => 91,
    EPROTO => 92,
    ENOTCAPABLE => 93,
    ECAPMODE => 94,
    ENOTRECOVERABLE => 95,
    EOWNERDEAD => 96,
    EINTEGRITY => 97,
    ELAST => 97,
} !! ($*KERNEL.name eq 'openbsd' ?? do {
    EPERM => 1,
    ENOENT => 2,
    ESRCH => 3,
    EINTR => 4,
    EIO => 5,
    ENXIO => 6,
    E2BIG => 7,
    ENOEXEC => 8,
    EBADF => 9,
    ECHILD => 10,
    EDEADLK => 11,
    EDEADLOCK => 11,
    ENOMEM => 12,
    EACCES => 13,
    EFAULT => 14,
    ENOTBLK => 15,
    EBUSY => 16,
    EEXIST => 17,
    EXDEV => 18,
    ENODEV => 19,
    ENOTDIR => 20,
    EISDIR => 21,
    EINVAL => 22,
    ENFILE => 23,
    EMFILE => 24,
    ENOTTY => 25,
    ETXTBSY => 26,
    EFBIG => 27,
    ENOSPC => 28,
    ESPIPE => 29,
    EROFS => 30,
    EMLINK => 31,
    EPIPE => 32,
    EDOM => 33,
    ERANGE => 34,
    EAGAIN => 35,
    EWOULDBLOCK => 35,
    EINPROGRESS => 36,
    EALREADY => 37,
    ENOTSOCK => 38,
    EDESTADDRREQ => 39,
    EMSGSIZE => 40,
    EPROTOTYPE => 41,
    ENOPROTOOPT => 42,
    EPROTONOSUPPORT => 43,
    ESOCKTNOSUPPORT => 44,
    EOPNOTSUPP => 45,
    EPFNOSUPPORT => 46,
    EAFNOSUPPORT => 47,
    EADDRINUSE => 48,
    EADDRNOTAVAIL => 49,
    ENETDOWN => 50,
    ENETUNREACH => 51,
    ENETRESET => 52,
    ECONNABORTED => 53,
    ECONNRESET => 54,
    ENOBUFS => 55,
    EISCONN => 56,
    ENOTCONN => 57,
    ESHUTDOWN => 58,
    ETOOMANYREFS => 59,
    ETIMEDOUT => 60,
    ECONNREFUSED => 61,
    ELOOP => 62,
    ENAMETOOLONG => 63,
    EHOSTDOWN => 64,
    EHOSTUNREACH => 65,
    ENOTEMPTY => 66,
    EPROCLIM => 67,
    EUSERS => 68,
    EDQUOT => 69,
    ESTALE => 70,
    EREMOTE => 71,
    EBADRPC => 72,
    ERPCMISMATCH => 73,
    EPROGUNAVAIL => 74,
    EPROGMISMATCH => 75,
    EPROCUNAVAIL => 76,
    ENOLCK => 77,
    ENOSYS => 78,
    EFTYPE => 79,
    EAUTH => 80,
    ENEEDAUTH => 81,
    EIPSEC => 82,
    ENOATTR => 83,
    EILSEQ => 84,
    ENOMEDIUM => 85,
    EMEDIUMTYPE => 86,
    EOVERFLOW => 87,
    ECANCELLED => 88,
    EIDRM => 89,
    ENOMSG => 90,
    ENOTSUP => 91,
    EBADMSG => 92,
    ENOTRECOVERABLE => 93,
    EOWNERDEAD => 94,
    EPROTO => 95,
    ELAST => 95,
} !! do {
    EPERM => 1,
    ENOENT => 2,
    ESRCH => 3,
    EINTR => 4,
    EIO => 5,
    ENXIO => 6,
    E2BIG => 7,
    ENOEXEC => 8,
    EBADF => 9,
    ECHILD => 10,
    EDEADLK => 11,
    EDEADLOCK => 11,
    ENOMEM => 12,
    EACCES => 13,
    EFAULT => 14,
    ENOTBLK => 15,
    EBUSY => 16,
    EEXIST => 17,
    EXDEV => 18,
    ENODEV => 19,
    ENOTDIR => 20,
    EISDIR => 21,
    EINVAL => 22,
    ENFILE => 23,
    EMFILE => 24,
    ENOTTY => 25,
    ETXTBSY => 26,
    EFBIG => 27,
    ENOSPC => 28,
    ESPIPE => 29,
    EROFS => 30,
    EMLINK => 31,
    EPIPE => 32,
    EDOM => 33,
    ERANGE => 34,
    EAGAIN => 35,
    EWOULDBLOCK => 35,
    EINPROGRESS => 36,
    EALREADY => 37,
    ENOTSOCK => 38,
    EDESTADDRREQ => 39,
    EMSGSIZE => 40,
    EPROTOTYPE => 41,
    ENOPROTOOPT => 42,
    EPROTONOSUPPORT => 43,
    ESOCKTNOSUPPORT => 44,
    ENOTSUP => 45,
    EPFNOSUPPORT => 46,
    EAFNOSUPPORT => 47,
    EADDRINUSE => 48,
    EADDRNOTAVAIL => 49,
    ENETDOWN => 50,
    ENETUNREACH => 51,
    ENETRESET => 52,
    ECONNABORTED => 53,
    ECONNRESET => 54,
    ENOBUFS => 55,
    EISCONN => 56,
    ENOTCONN => 57,
    ESHUTDOWN => 58,
    ETOOMANYREFS => 59,
    ETIMEDOUT => 60,
    ECONNREFUSED => 61,
    ELOOP => 62,
    ENAMETOOLONG => 63,
    EHOSTDOWN => 64,
    EHOSTUNREACH => 65,
    ENOTEMPTY => 66,
    EPROCLIM => 67,
    EUSERS => 68,
    EDQUOT => 69,
    ESTALE => 70,
    EREMOTE => 71,
    EBADRPC => 72,
    ERPCMISMATCH => 73,
    EPROGUNAVAIL => 74,
    EPROGMISMATCH => 75,
    EPROCUNAVAIL => 76,
    ENOLCK => 77,
    ENOSYS => 78,
    EFTYPE => 79,
    EAUTH => 80,
    ENEEDAUTH => 81,
    EPWROFF => 82,
    EDEVERR => 83,
    EOVERFLOW => 84,
    EBADEXEC => 85,
    EBADARCH => 86,
    ESHLIBVERS => 87,
    EBADMACHO => 88,
    ECANCELLED => 89,
    EIDRM => 90,
    ENOMSG => 91,
    EILSEQ => 92,
    ENOATTR => 93,
    EBADMSG => 94,
    EMULTIHOP => 95,
    ENODATA => 96,
    ENOLINK => 97,
    ENOSR => 98,
    ENOSTR => 99,
    EPROTO => 100,
    ETIME => 101,
    EOPNOTSUPP => 102,
    ENOPOLICY => 103,
    ENOTRECOVERABLE => 104,
    EOWNERDEAD => 105,
    EQFULL => 106,
    ELAST => 106,
}
))))));
