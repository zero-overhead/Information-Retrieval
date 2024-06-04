#!/usr/bin/env raku
use v6.e.PREVIEW;
sub MAIN {
    # create-n-grams-minimal.raku < inputs/kjvbible.txt
    # 5 most common 3-Grams
    say $*IN.words.grep(*.chars >= 3)».comb(3 => -2).Bag.sort(-*.value).head(5)
}
