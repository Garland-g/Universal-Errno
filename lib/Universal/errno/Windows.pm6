
die "Not on Windows" unless $*DISTRO.is-win();

use NativeCall;
use NativeHelpers::Blob;

enum FORMAT_MESSAGE (
  ALLOCATE_BUFFER => 0x100,
  IGNORE_INSERTS => 0x200,
  FROM_SYSTEM => 0x1000,
);

sub GetLastError() returns int32 is native("kernel32") { * }

sub SetLastError(int32 $ierror) is native("kernel32") { * }

sub LocalFree(Pointer[void]) returns Pointer[void] is native("kernel32") { * }

sub FormatMessage(
  uint32 $dwFlags,
  Pointer[void] $lpSource,
  uint32 $dwMessageId,
  uint32 $dwLanguageId,
  Pointer[uint16] $lpBuffer is rw,
  uint32 $nSize,
  Str:U $null
) returns uint32 is native("kernel32") is symbol('FormatMessageW') { * }

my class errno {
  method !index() {
    GetLastError();
  }

  method Str(--> Str:D) {
    my Pointer[uint16] $lptstr .= new;
    my $error = self!index;
    my $size = FormatMessage(
      FORMAT_MESSAGE::FROM_SYSTEM +|
      FORMAT_MESSAGE::ALLOCATE_BUFFER +|
      FORMAT_MESSAGE::IGNORE_INSERTS,
      Str,
      self!index,
      0,
      $lptstr,
      0,
      Str
    );
    my buf16 $b =  blob-from-pointer($lptstr, :elems($size), :type(buf16));
    my Str $out = $b.decode('utf16').split("\0")[0].chomp;
    LocalFree(nativecast(Pointer[void], $lptstr));
    SetLastError($error);
    $out;
  }

  method gist(--> Str:D) {
    if self!index -> $index {
      SetLastError($index);
      my Str $out = self.Str ~ " (errno = $index)";
    }
    else {
      ""
    }
  }

  method Numeric(--> Int:D) { self!index }
}

module Universal::errno::Windows {
  my $proxy := Proxy.new(
    FETCH => -> $ { UNIT::errno },
    STORE => -> $, $value { set_errno($value) }
  );

  my sub errno() is export is raw { $proxy }
  my sub set_errno(Int() $value) is export is raw {
    SetLastError($value);
    $proxy
  }
}


=begin pod

=head1 NAME

Universal::errno::Windows - Provide transparent Windows access to errno

=head1 DESCRIPTION

Universal::errno::Windows provides the same interface as C<Unix::errno> to
Windows and its GetLastError and SetLastError functions. Unlike
Windows, getting the error message will not reset the value of
errno. That has to be done manually.

Since this uses C<SetLastError>, the caveat about setting errno
in C<Unix::errno> should not apply, as this is a function call,
not setting an extern variable. This should not be relied upon
unless Universal::errno::Windows is loaded directly.

=head1 AUTHOR

Travis Gibson <TGib.Travis@protonmail.com>

=head2 CREDIT
Adapted from lizmat's C<Unix::errno>, which can be found at
L<https://github.com/lizmat/Unix-errno>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 Travis Gibson

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
