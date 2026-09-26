# Finding tree decompositions of small treewidth

A [Lax archive](https://github.com/lax-archive/lax) submission (`lax-689794`) stating
Bodlaender's theorem and its second stage, the theorem of Bodlaender and Kloks, and proving them
as programs for the word RAM, so that other submissions can cite them. See `abstract.md`.

**Status: both statements are proved.** Four concept modules (`GraphWords` holds the encodings),
three statements, two proofs. `lax build --nonstrict .` reports `4 concepts · 2 proofs`, and both
proofs depend on Lean's three standard axioms only. The third statement,
`TreewidthApproximation.niceDecomposition_approx`, is an optional statement that no proof
discharges. Nothing is registered or submitted.

| Statement | Says | Source | Proved by |
|---|---|---|---|
| `BodlaenderKloks.improveDecomposition` | from a graph and a nice decomposition of width ≤ ℓ, a nice decomposition of width ≤ k or "treewidth > k", in `2^{O(ℓ³)}·poly` | Bodlaender–Kloks 1996; Althaus–Ziegler 2020, §3 | `Fun/Final.lean`, `improveDecomposition_proved` |
| `Bodlaender.niceDecomposition_computable` | from a graph alone, the same, in `2^{O(k³)}·poly` | Bodlaender 1996; Kloks 1994 (niceness) | `Fun/Final.lean`, `niceDecomposition_computable_proved` |
| `TreewidthApproximation.niceDecomposition_approx` | optional: width ≤ 4k+4 or "treewidth > k", in `2^{O(k)}·poly` | Robertson–Seymour 1995; Cygan et al. 2015, ch. 7 | not proved |

The second statement is the one the fair-repetitive-interval-scheduling submission
(`fairris-lax`, `lax-117284`) uses for its Theorem 4; its own copy is this statement specialised
to the overall conflict graph of an instance, and it is derived from this one there.

## What is proved, and how

The algorithm proved is **not** the linear-time algorithm of Bodlaender's paper. It is the
exact dynamic program of Bodlaender and Kloks over *characteristics* of partial decompositions
(typical sequences, normal forms, introduce, forget and join steps), wrapped vertex by vertex
(insert the next vertex into every bag of the nice decomposition found for the previous vertices,
so that the width grows by one, and apply the improvement step). The time is polynomial in the
length of the word and `2^{O(k³)}` in the bound, which is what the statements ask.

* **Correctness** (`Seq/`, `Trees/`, `Chars/`, `Wrap/`): the sequences and their laws, decompositions
  as rooted trees with the two bridges to the archive's tree decompositions and to the word
  format, the characteristics and their normal form, the exact layers of the four kinds of node,
  the realisation of a characteristic by an actual decomposition, the correctness of the
  tables and of the extraction, and the wrapper. About 23,700 lines.
* **Size bounds** (`Size/`): the number of plans, characteristics and table entries, and the size
  of every intermediate tree, all at most a polynomial times `2^{O((k+2)³)}`.
* **Running time** (`Fun/`): the Lean functions themselves are run on a virtual machine for a
  first-order functional language (`Defs`, `Meta`, `Lib*`), whose semantics carries a cost; a
  verified compiler takes that language to a bytecode machine written in IMP+ and transfers its
  runs to the word RAM through the archive's compiler (`VM*`). Each function of the algorithm
  is embedded with an explicit cost (`E1`–`E6b`), the whole run is assembled and bounded (`A1`), and
  the two statements are derived from it (`A2`, `A3`, `Final`). About 26,300 lines.

Points where the printed material needed repair, all recorded in the proofs: the wrapper as
first written produced nice trees of exponential size (a compression step before conversion to
a nice tree repairs it, `Wrap/Compress*`); several lemmas of the exposition need connectedness or
symmetric adjacency, or a slightly stronger join condition.

## Prerequisites and verifying

Lean `v4.33.0` via [elan](https://github.com/leanprover/elan), and the
[`lax` CLI](https://github.com/lax-archive/lax). The mathlib revision is pinned in `manifest.yaml`.

    lax build --nonstrict .

is the one command that checks everything; `--nonstrict` only because the proofs package requires
the packages of the word RAM and of Turing machines as proof dependencies. The full build takes a
while and a lot of memory; cap Lake's parallelism, for example `LEAN_NUM_THREADS=2 lake build`
from `proofs/`. To audit axioms, write a scratch file **outside** the package, import
`Lax689794Proofs`, `#print axioms Lax689794Proofs.Fun.Final.niceDecomposition_computable_proved`
(and `improveDecomposition_proved`), and run `lake env lean` from `proofs/`.

> Anything placed inside `proofs/Lax689794Proofs/` must also be imported by
> `Lax689794Proofs.lean`, or the build is rejected; and the proofs package may hold Lean files
> only. Working notes are under `notes/`.

## Reading it

Read `concepts/` and let the build vouch for `proofs/` (about 52,000 lines in 251 modules).
Start with `GraphWords.lean`, which fixes the word format of graphs and of nice decompositions,
then `Bodlaender.lean` and `BodlaenderKloks.lean`.

    manifest.yaml     id, title, authors, pinned Lean + mathlib, bibliography
    abstract.md       the prose account, rendered on the archive website
    concepts/         statements only, as axioms
    proofs/           the proofs, each tagged with the statement it discharges
    reference/        a Python implementation of the algorithm, used as a test oracle while proving
    notes/            working notes (plans, design of the machine layer)

## Dependencies

Beyond mathlib: `lax-808846` (the word RAM, IMP+ and its verified compiler), `lax-759944` (word RAM
and Turing machine polynomial time), `lax-434930` (classical complexity classes) and `lax-228581`
(treewidth). The proofs packages of the first three are required as proof dependencies, and the
build warns about each (`proof-dependency`).

## License

Apache 2.0, as required by the archive. See `LICENSE`.
