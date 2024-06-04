#!/usr/bin/env raku

use JSON::Fast <!pretty immutable>;

subset file of IO::Path(Str);
subset words of Int;
enum format <json>;

sub bagify($f){
    $f.words».lc.Bag
}

#| Word count from single file, entire folder or STDIN. Sorted desc output of json or one per line to STDOUT.
sub MAIN( file   :$in?,         #= input folder or filename, using STDIN if omitted.
          words  :$n?,          #= only the n most frequent words.
          format :$format?,     #= json, using one per line if omitted.
         ) {
    # ToDo: make lazy version
    my $words_lc_bag = $in ~~ IO::Path:D                   # was $in passed as argument?
                                ?? $in.f                   # file?
                                     ??  bagify($in)       # "»" is hint to the compiler that parallelization can be applied
                                     !! [⊎] flat $in.dir».map: { bagify($_) }
                                !!  bagify($*IN);          # read from STDIN
    $words_lc_bag = $words_lc_bag.sort(-*.value).head($n) with $n;
    given $format {
        when "json" { print to-json $words_lc_bag }
        default { print join "\n", $words_lc_bag.map: {.key ~ " " ~ .value}}
    }
    print("\n\n")
}

