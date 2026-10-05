The treewidth of a graph measures how far it is from a tree. Many NP-hard problems can be solved
in time $f(k)\cdot\mathrm{poly}(n)$ on graphs of treewidth $k$, but only once a tree decomposition
of small width is at hand. Bodlaender showed that such a decomposition can itself be found in
time $2^{O(k^3)}$ times a polynomial for fixed $k$: given a graph, one decides whether its
treewidth is at most $k$ and, if so, outputs a tree decomposition of width at most $k$.

This submission states two results and proves both. The first is the second stage of Bodlaender's
algorithm, due to Bodlaender and Kloks: from a graph and a
nice tree decomposition of width at most $\ell$, it finds a nice decomposition of width at most
$k$ or reports that the treewidth exceeds $k$, in time $2^{O(\ell^3)}\cdot\mathrm{poly}$. The
second is an exact graph algorithm, which needs no
decomposition as input and runs in time $2^{O(k^3)}\cdot\mathrm{poly}$.

Running times are claims about the instructions a word RAM executes, against an explicit word
encoding of the graph, its adjacency matrix, and of a nice tree decomposition. Both statements
are proved from Lean's three standard axioms, by a dynamic program over characteristics of partial
decompositions that is run on a verified compiler pipeline down to the archive's word RAM.

The polynomial factors refer to the encoded input length, including the supplied decomposition
for the first result. The graph algorithm uses a vertex-by-vertex construction with characteristic
dynamic programming. The first result follows by returning the supplied decomposition when its
width bound is already sufficient, and otherwise running the graph algorithm.
