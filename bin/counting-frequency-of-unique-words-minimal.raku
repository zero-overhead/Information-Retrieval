#!/usr/bin/env raku
use v6.e.PREVIEW;

sub MAIN {
    my %dict := bag $*IN.words;
    say "Most common words: ", %dict.sort(-*.value).head: 5;
}
