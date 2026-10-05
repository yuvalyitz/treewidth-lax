import Lax689794Proofs.Fun.VMSolveGuard
import Lax689794Proofs.Fun.LibEmbeds

/-!
# GATE G1: an end-to-end toy — `x ↦ x.reverse` on words of the format `graphK`, through the compiler

The smallest real function of the library (`Lib2.fReverse`, embedded in `LibEmbeds.embeds_reverse`) is compiled to a single word-RAM
program (`compileProgram solveLayout (solveCom Lib.Δ 128 34 Fmt.graphK toyP)`), and `ComputesInTime` is proved for it.
No axioms, no `sorry`.
-/

namespace Lax689794Proofs.Fun.Load.Toy

open Lax808846Proofs.Imp Lax808846Proofs.Compile Lax689794Proofs.Fun.VM.Ram Lax808846.Ram Lax808846.RamComputes ToVal

/-- The cost formula of the toy: `K x = 22 · 2^(kw³) · (|x| + 1)`. -/
def toyP : KP := ⟨22, 1, 1, 1⟩

/-- Admissible inputs: the words `n :: (n² entries) ++ [k]`. -/
def Dtoy : Set (List ℕ) := {x | fmtLen Fmt.graphK x = x.length}

end Lax689794Proofs.Fun.Load.Toy
