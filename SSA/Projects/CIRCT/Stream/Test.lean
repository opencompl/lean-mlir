import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas

namespace HandshakeStream


example (xs ys zs : Stream (BitVec 8)) : add₂ (add₂ xs ys) zs = add₃ xs ys zs := by
  simp [add₂, add₃]

/-- this is the shape of the decproc for comb parts -/
example (xs ys zs : Stream (BitVec 8)) : add₂ (add₂ xs zs) ys = add₃ xs ys zs := by
  simp only [add₂, add₃]
  simp only [syncMap2_syncMap2_eq_syncMap3]
  rw [syncMap3_flip23]
  congr
  funext a b c
  bv_decide
