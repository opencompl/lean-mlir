import Mathlib.Data.Bitvec.Lemmas

namespace Std.BitVec

@[simp]
lemma ofInt_ofNat (w n : Nat) : -- (inst : OfNat ℤ n) :
    BitVec.ofInt w (OfNat.ofNat n) = BitVec.ofNat w n :=
  rfl
