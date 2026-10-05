# Finding Tree Decompositions of Small Treewidth

A [Lax archive](https://github.com/lax-archive/lax) submission (`lax-689794`) proving
algorithms for finding nice tree decompositions on the word RAM.

Both exported statements are proved. The submission contains three concept modules,
two proofs of exported statements, and an annotated paper. Both proofs depend only on
Lean's three standard axioms.

## Results

- **Exact decomposition:** given a graph and a bound `k`, find a nice decomposition of
  width at most `k`, or report that the treewidth exceeds `k`, within
  `2^{O(k³)}` times a polynomial in the encoded graph length.
- **Improvement:** given a graph, bounds `k` and `ℓ`, and a nice decomposition of width
  at most `ℓ`, produce the same result within `2^{O(ℓ³)}` times a polynomial in the
  complete encoded input length, including the supplied decomposition.

The exact graph algorithm uses characteristic dynamic programming and inserts vertices
one at a time. Compression keeps intermediate decompositions within the proved size bound.
The exported improvement result follows by returning the supplied decomposition when
`ℓ ≤ k`, and otherwise running the exact graph algorithm with bound `k`.

These are polynomial-time variants of the classical results of Bodlaender and Kloks;
the classical linear dependence on graph size is not claimed by the formal statements.
The word-length hypotheses ensure that the machine can represent the intermediate data.

## Proof Organization

- `Seq/`, `Trees/`, `Chars/`, and `Wrap/` establish the mathematical correctness of
  typical sequences, tree encodings, characteristics, dynamic-programming tables,
  extraction, and the vertex-by-vertex construction.
- `Size/` bounds the number and size of intermediate objects.
- `Fun/` implements the algorithm in a functional language with explicit execution costs
  and transfers its runs through a verified compiler to the word RAM.
- `Fun/Final.lean` assembles the complete algorithm and proves both exported statements.

## Verification

Use Lean `v4.33.0` via [elan](https://github.com/leanprover/elan) and the
[`lax` CLI](https://github.com/lax-archive/lax). The mathlib revision is pinned in `manifest.yaml`.

```sh
lax build .
```

To inspect the assumptions, import `Lax689794Proofs.Fun.Final` in a scratch Lean file
outside the submission and use `#print axioms` on
`Lax689794Proofs.Fun.Final.niceDecomposition_computable_proved` and
`Lax689794Proofs.Fun.Final.improveDecomposition_proved`.
Run that file with `lake env lean` from `proofs/`.

## Reading Guide

Start with `concepts/Lax689794/GraphWords.lean` for the graph and decomposition encodings,
then read `Bodlaender.lean` and `BodlaenderKloks.lean` for the statements and machine bounds.
The annotated note in `paper/` connects these statements to their proofs.

- `manifest.yaml`: submission metadata and bibliography.
- `abstract.md`: the archive abstract.
- `paper/`: the annotated paper and figure.
- `concepts/`: definitions and theorem statements.
- `proofs/`: Lean proofs.
- `reference/`: a Python reference implementation used for algorithm checks.

## Dependencies

Beyond mathlib, the submission uses `lax-808846` (word RAM, IMP+, and its verified compiler),
`lax-759944` (word RAM and Turing machine polynomial time), `lax-434930` (classical complexity
classes), and `lax-228581` (treewidth). The proofs packages of the first three are also
required as proof dependencies.

## License

Apache 2.0. See `LICENSE`.
