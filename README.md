# Information Retrieval

Notes on processing of text documents and unstructured data.

## Counting frequencies of unique words
... and return the the most frequent ```n``` words one per line in descending order.

### Raku
```$*IN```: Standard input filehandle, STDIN.

```raku
#!/usr/bin/env raku

sub MAIN {
    # Top 3 words
    say $*IN.words.Bag.sort(-*.value).head(3)
}
```

```bash
bin/counting-frequencies-of-unique-words.raku -n=3 -format=json -in=inputs/kjvbible.txt
```

# Create N-grams from strings

```raku
#!/usr/bin/env raku
use v6.e.PREVIEW;
sub MAIN {
    # create-n-grams-minimal.raku < inputs/kjvbible.txt
    # 5 most common 3-Grams
    say $*IN.words.grep(*.chars >= 3)».comb(3 => -2).Bag.sort(-*.value).head(5)
}
```

```bash
bin/create-n-grams.raku -n=3 -m=10 --format=json < inputs/kjvbible.txt
```
