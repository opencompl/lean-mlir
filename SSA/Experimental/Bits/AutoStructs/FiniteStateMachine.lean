import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.Fast.FiniteStateMachine

open Sum

section FSM
variable {α β α' β' : Type} {γ : β → Type}

namespace FSM

attribute [instance] FSM.i FSM.dec_eq

variable {ar : Type} (p : FSM ar)

def carryBV (x : ar → BitVec w) : p.State :=
  p.carry (fun ar => BitStream.ofBitVec (x ar)) w

def evalBV {w} (x : ar → BitVec w) : BitVec w :=
  BitVec.ofFn fun k => p.eval (fun ar => BitStream.ofBitVec (x ar)) k

instance {α β : Type} [Fintype α] [Fintype β] (b : Bool) :
    Fintype (cond b α β) := by
  cases b <;> simp <;> infer_instance

open Term

abbrev ofTerm (t : Term) : FSM (Fin t.arity) := termEvalEqFSM t |>.toFSM

@[simp]
lemma carry_eq_up_to :
    (∀ ar k, k < n → x ar k = y ar k) →
    p.carry x n = p.carry y n := by
  induction n generalizing x y
  case zero => intros; rfl
  case succ n ih =>
    rintro heq
    simp [carry, @ih x y (by tauto)]
    congr; simp_all only [lt_add_iff_pos_right, zero_lt_one]

lemma eval_eq_up_to :
    (∀ ar k, k ≤ n → x ar k = y ar k) →
    p.eval x n = p.eval y n := by
  rintro h
  simp [eval]
  congr 2
  apply carry_eq_up_to p (by rintro ar k hlt; apply h; omega)
  ext; apply h; rfl

end FSM
