use v6.c;

module Universal::Errno::Codes {
my \OS =
  gather given $*KERNEL.name {
    when 'linux' { take 0 }
    when 'netbsd' { take 1 }
    when 'dragonflybsd' { take 2 }
    when 'freebsd' { take 3 }
    when 'openbsd' { take 4 }
    when 'macos' { take 5 }
};

#                       Linux  NetBSD DFBSD FreeBSD NetBSD macos
  my constant EAGAIN = [   11,     35,   35,     35,    35,   35]
}
