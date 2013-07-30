Minimal Perfect Hashes
======================

A Julia module for generating minimal perfect hash functions for an array of strings:
```
julia> months = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"]
julia> mph = MinimalPerfectHash(months)
julia> results = map((x) -> hash(x, mph), months)
12-element Int64 Array:
  1
  2
  3
  4
  5
  6
  5
  8
  9
 10
 11
 12
```
This is great for creating memory efficient lookup tables with an O(1) access time.

## Metadata

  * Owner: Matt Weiden (weiden@soundcloud.com), TSS (tss@soundcloud.com)
  * Status: Research/prototyping
