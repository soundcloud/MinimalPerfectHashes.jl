## Minimal Perfect Hashes

[![Build Status](https://travis-ci.org/soundcloud/MinimalPerfectHashes.jl.png)](https://travis-ci.org/soundcloud/MinimalPerfectHashes.jl)

A Julia module for generating minimal perfect hash functions for an array of strings:
```julia
julia> using MinimalPerfectHashes
julia> months = ["jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"]
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

### Requirements

Using MinimalPerfectHashes.jl requires that the following software be installed:

- [Julia](https://github.com/JuliaLang/julia) — The Julia language itself.
- [Graphs.jl](https://github.com/JuliaLang/Graphs.jl) — Julia's graphs package, version 0.2.4 or greater.

### Installation

MinimalPerfectHashes.jl should be available from METADATA.jl. To install MinimalPerfectHashes.jl, use the following:

```julia
Pkg.add("MinimalPerfectHashes")
```

If this does not work, git clone the repository in your ```~/.julia/``` directory.

MinimalPerfectHashes.jl has one main module named `MinimalPerfectHashes`. You can load it as:

```julia
using MinimalPerfectHashes
```

### Support

You can check for @mweiden on the [#julia IRC channel](http://webchat.freenode.net/?channels=julia) on Freenode.

### Metadata

  * Owner: [Matt Weiden](https://github.com/mweiden), [SoundCloud Ltd.](http://soundcloud.com)
  * Status: Research/prototyping
