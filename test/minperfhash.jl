using MinimalPerfectHashes
using Base.Test
using Graphs

# Test the is_cyclic method
G = graph(ExVertex, ExEdge{ExVertex}, is_directed = false)
add_vertex!(G, "a")
add_vertex!(G, "b")
add_vertex!(G, "c")
V = vertices(G)
add_edge!(G, V[1], V[2])
add_edge!(G, V[2], V[3])
@test is_cyclic(G) == false
add_edge!(G, V[3], V[1])
@test is_cyclic(G) == true

# Test the minperf hash itself
testAry = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"]
mph = MinimalPerfectHash(testAry)

results = Set(collect(map((x) -> hash(x, mph), testAry)))

@test length(results) == 12
@test max(results)    == 12
@test min(results)    == 1


