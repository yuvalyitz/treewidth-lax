import Lax689794.GraphWords
import Lax808846.Ram

/-!
---
title: Tree decompositions of approximately optimal width
type: theorem
---
**A constant-factor approximation of treewidth.** There is an algorithm that, given a graph and
an integer $k$, in time $2^{O(k)} \cdot n^2$ either outputs a tree decomposition of the graph of
width at most $4k + 4$ or concludes that its treewidth exceeds $k$.

N. Robertson and P. D. Seymour, *"Graph minors. XIII. The disjoint paths problem"*, Journal of
Combinatorial Theory Series B 63 (1995) 65–110; in the textbook form: M. Cygan, F. V. Fomin,
Ł. Kowalik, D. Lokshtanov, D. Marx, Marcin Pilipczuk, Michał Pilipczuk and S. Saurabh,
*Parameterized Algorithms*, Springer 2015, Chapter 7. The algorithm splits a graph along a
balanced separator of a bounded set of vertices, found by a maximum flow.

This is an **optional weaker alternative** to `Bodlaender`: a consumer that only needs a
decomposition whose width is bounded by a function of the treewidth — every dynamic program over
tree decompositions of fixed-parameter cost is of this kind — can use it in place of the
optimal one, at the price of restating its bound on the width, and its proof is far shorter
(a max-flow argument on balanced separators, in place of the Bodlaender–Kloks equivalence
classes).

# Formalization notes

Same encodings as `Bodlaender`; the output decomposition has width at most `4k + 4`, and the
bound is `c * 2 ^ (c * k) * (|g| + 2) ^ c` instructions.
-/

namespace Lax689794.TreewidthApproximation

open Lax808846.Ram Lax689794.GraphWords

open Classical in
/-- **Approximating treewidth on a word RAM.** On every word that fits, the program writes `[0]`
if the graph has no tree decomposition of width at most `k`, and `1` followed by the word of a
nice tree decomposition of width at most `4 * k + 4` otherwise. -/
axiom niceDecomposition_approx :
    ∃ (prog : Program) (c : ℕ), ∀ (W k n : ℕ) (G : SimpleGraph (Fin n)) (g : List ℕ),
      EncodesGraph g G →
      (∀ v ∈ g ++ [k], c * 2 ^ (c * k) * ((g ++ [k]).length + v + 1) ^ c ≤ 2 ^ W) →
      ∃ (out : List ℕ) (t : ℕ), t ≤ c * 2 ^ (c * k) * (g.length + 2) ^ c ∧
        RunsTo W prog (g ++ [k]) out t ∧
        (out = [0] ∧ ¬ Lax228581.Treewidth.HasTreewidthAtMost G k ∨
          ∃ D, out = 1 :: D ∧ NiceDecomposition G (4 * k + 4) D)

end Lax689794.TreewidthApproximation
