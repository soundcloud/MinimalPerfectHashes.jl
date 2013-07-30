using Graphs

function wordindices{T <: String}(word::T)
  wordInd = map((x) -> int(x), collect(word))
  wordLen = length(wordInd)
  return wordInd, wordLen
end


function flooredmod(a::Int, n::Int)
  return int(a - n * floor(a/n))
end


type MinimalPerfectHash
  t1::Array{Int64,1}
  t2::Array{Int64,1}
  G::GenericGraph{
    ExVertex,
    ExEdge{ExVertex},
    Array{ExVertex,1},
    Array{ExEdge{ExVertex},1},
    Array{Array{ExVertex,1},1},
    Array{Array{ExEdge{ExVertex},1},1}}
  g::Array{Int64,1}
  m::Int64
  n::Int64

  function MinimalPerfectHash{T <: String}(rawwords::Vector{T})
    words = unique(rawwords)
    numwords = int64(length(words))

    G, t1, t2, n = mapping(words)

    # Set all edges to unvisited state
    for v in vertices(G)
      v.attributes["visited"] = false
    end

    # Initialize g functions
    g = Array(Int64, length(vertices(G)))

    mphbase = new(t1, t2, G, g, numwords, n)

    for v in vertices(G)
      if v.attributes["visited"] == false
        g[v.index] = 0
        traverse(v, mphbase)
      end
    end

    return mphbase
  end
end


function hash{T <: String}(word::T, mph::MinimalPerfectHash)
  wordInd, wordLen = wordindices(word)
  u = flooredmod((mph.t1[1:wordLen]' * wordInd)[1], mph.n)
  v = flooredmod((mph.t2[1:wordLen]' * wordInd)[1], mph.n)
  hashval = flooredmod((mph.g[u+1] + mph.g[v+1]), mph.m) + 1
  return hashval
end


function buildgraph(n::Int)
  G = graph(ExVertex, ExEdge{ExVertex}, is_directed = false)
  for i = 1:n
    add_vertex!(G, "edge:" * string(i))
  end
  return G
end


function mapping{T <: String}(words::Array{T})
  numwords = length(words)
  uniqChars = unique(collect(join(words)))
  maxwl = max(collect(map((x) -> length(x), words)))

  n = int(25/12 * numwords)
  t1 = Array(Int64, maxwl)
  t2 = Array(Int64, maxwl)

  G = buildgraph(n)

  isCyclic = true
  loopCounter = 0

  while isCyclic
    G = buildgraph(n)
    V = vertices(G)

    rand!(0:(n-1), t1)
    rand!(0:(n-1), t2)

    for i = 1:numwords
      wordInd, wordLen = wordindices(words[i])
      u = flooredmod((t1[1:wordLen]' * wordInd)[1], n)
      v = flooredmod((t2[1:wordLen]' * wordInd)[1], n)
      edg = add_edge!(G, V[u+1], V[v+1])
      #edg.attributes["word"] = words[i]
      edg.attributes["h"] = i - 1
    end

    isCyclic = test_cyclic_by_dfs(G)

    if loopCounter > 20
      throw(ArgumentError("[MPHF:mapping] Could not find acyclic graph for input.\n"))
    end

    loopCounter += 1
  end

  return G, t1, t2, n
end


function traverse(u::ExVertex, mph::MinimalPerfectHash)
  u.attributes["visited"] = true
  for edg in out_edges(u, mph.G)
    w = edg.target
    if !w.attributes["visited"]

      mph.g[w.index] = flooredmod(edg.attributes["h"] - mph.g[u.index], mph.m)
      traverse(w, mph)
    end
  end
end

