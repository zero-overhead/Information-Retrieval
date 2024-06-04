#!/usr/bin/env raku

sub MAIN {
    my %dict := bag $*IN.words;
    say "Most common words: ", %dict.sort(-*.value).head: 5;
}
