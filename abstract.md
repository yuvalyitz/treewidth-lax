The treewidth of a graph measures how far it is from a tree, and many NP-hard problems are
solvable in time $f(k)\cdot\mathrm{poly}(n)$ on graphs of treewidth $k$ when a tree decomposition
of small width is at hand. Bodlaender showed that one can find such a decomposition itself in linear
time for fixed $k$: given a graph, decide whether its treewidth is at most $k$, and if so output a
tree decomposition of width at most $k$, in time $2^{O(k^3)} n$.

The algorithm has two stages. The first reduces the graph to one with a constant fraction fewer
vertices — either by contracting a maximal matching among the low-degree vertices, or by removing
the vertices whose neighbourhoods form cliques after edges are added between vertices with $k+1$
common low-degree neighbours — solves that recursively, and lifts the answer to a tree
decomposition of width at most $2k+1$. The second stage, due to Bodlaender and Kloks, turns a tree
decomposition of any bounded width into an optimal one, by enumerating the tree decompositions of
the subgraphs below each node of the given one and keeping one representative per equivalence
class, of which there are $2^{O(\ell^3)}$.

This submission states three results and does not prove them: the second stage
(`BodlaenderKloks.improveDecomposition`), the whole algorithm producing a nice tree decomposition
(`Bodlaender.niceDecomposition_computable`), and, as an optional weaker alternative, the classical
constant-factor approximation that either outputs a decomposition of width at most $4k+4$ or
concludes that the treewidth exceeds $k$ (`TreewidthApproximation.niceDecomposition_approx`).
Running times are stated on the word RAM of the archive against an explicit word encoding of the
graph, its adjacency matrix, and of a nice tree decomposition, so they are claims about the
instructions a machine executes.
