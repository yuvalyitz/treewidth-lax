import Lax689794Proofs.Chars.Forget
import Lax689794Proofs.Chars.Alg

/-!
# The base case (work package C2a): `char_leaf`
-/

set_option linter.unusedVariables false

namespace Lax689794Proofs.Chars

open Lax689794Proofs.Seq Lax689794Proofs.Trees

/-- The base case: a partial decomposition of the empty graph has the initial characteristic. -/
theorem char_leaf {adj : Adj} {k : ℕ} (t : RT) (h : PTD adj .leaf k t) : t.char ∅ = CT.start := by
  obtain ⟨hTD, -⟩ := h
  have hv : t.verts = ∅ := hTD.verts_eq
  have hconn : CT.Conn (t.prof ∅) := RT.conn_prof ∅ t hTD.conn
  have hsub : CT.verts (t.prof ∅) ⊆ (t.prof ∅).S := by
    intro v hvv
    rw [RT.mem_verts_prof] at hvv
    exact absurd hvv.2 (by simp)
  unfold RT.char
  rw [CT.norm_collapse _ hconn hsub]
  cases t with
  | node X ks =>
    have hX : X = ∅ := by
      apply Finset.eq_empty_of_forall_notMem
      intro v hv'
      have : v ∈ (RT.node X ks).verts := by rw [RT.verts]; exact Finset.mem_union_left _ hv'
      rw [hv] at this; simp at this
    subst hX
    simp [RT.prof, CT.start, CT.S, CT.y]

end Lax689794Proofs.Chars
