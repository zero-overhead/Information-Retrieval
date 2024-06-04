#!/usr/bin/env raku

use v6.e.PREVIEW;

use JSON::Fast <!pretty immutable>;

subset file of IO::Path(Str);
subset n-gram of Int where * > 1;
subset count of Int;
enum format <json>;

sub n-gramify($file, $n){
    $file.words».lc.grep( *.chars >= $n )».comb( $n => -$n.pred ).flat.Bag
}

#| N-grams from single file, entire folder or STDIN. Output of json or one per line to STDOUT.
sub MAIN( file   :$in?,         #= input folder or filename, using STDIN if omitted.
          n-gram :$n?,          #= n-Grams
          count  :$m?,          #= just the m most frequent n-grams?
          format :$format?,     #= json, using one per line if omitted.
         ) {

    # ToDo: make lazy version
    my $n-grams = $in ~~ IO::Path:D
            ?? $in.f
                    ?? n-gramify($in, $n)
                    !! [⊎] flat $in.dir».map: {n-gramify($_, $n)}
            !! n-gramify($*IN, $n);

    $n-grams = $n-grams.sort(-*.value).head($m) with $m;

    given $format {
        when "json" { print to-json $n-grams }
        default { print join "\n", $n-grams.map: {.key ~ " " ~ .value}}
    }
    print("\n\n")
}
