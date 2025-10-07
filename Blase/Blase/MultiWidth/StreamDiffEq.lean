import Blase.Fast.Circuit
import Blase.Fast.FiniteStateMachine

structure InputVar (ι : Type) (npast : Nat) where
  input : ι
  past : Fin npast
deriving DecidableEq, Hashable

private theorem Nat.mul_lt_mul_add {N M : Nat} {x y : Nat}
    (hx : x < N) (hy : y < M) : x * M + y < N * M := by
  have : 0 < N := by omega
  have : N * M ≥ M := by
    rcases N with rfl | N
    · omega
    · simp; rw [Nat.add_mul]; omega
  have : y ≤ M - 1 := by omega
  have : x * M ≤ N * M - M := by
    apply le_sub_of_add_le
    rw [← add_one_mul]
    apply mul_le_mul_right
    omega
  have : x * M + y ≤ (N * M - M) + (M - 1) := by omega
  have : x * M + y ≤ N * M - 1 := by
    apply Nat.le_trans this
    omega
  omega

@[simp]
theorem FinEnum_card_eq_self :
    FinEnum.card (Fin npast) = npast := by
  simp only [FinEnum.card_fin]

instance [instFinEnumI : FinEnum ι] : FinEnum (InputVar ι npast) where
  card :=
    let instFinEnumFinNpast : FinEnum (Fin npast) := by infer_instance
    instFinEnumI.card * instFinEnumFinNpast.card
  equiv := {
    toFun := fun { input, past } =>
      let instFinEnumFinNpast : FinEnum (Fin npast) := by infer_instance
      let finInput := instFinEnumI.equiv.toFun input
      let finPast := instFinEnumFinNpast.equiv.toFun past

      ⟨finInput.val * instFinEnumFinNpast.card + finPast.val, by
        apply Nat.mul_lt_mul_add
        · sorry
        · simp only [FinEnum.card_fin]
          have := finPast.isLt
          simpa using this
      ⟩
    invFun := fun x => sorry
    left_inv := sorry
    right_inv := sorry
  }

structure StreamDiffEq (ι : Type) (npast : Nat) where
  inInit : InputVar ι npast → Bool
  outCircuit : Circuit (InputVar ι npast)


/-- Cons a value onto a bitstream. -/
def BitStream.cons (b : Bool) (bs : BitStream) : BitStream :=
  fun n =>
    match n with
    | 0 => b
    | n + 1 => bs n

@[simp]
theorem BitStream.cons_zero (b : Bool) (bs : BitStream) :
    (BitStream.cons b bs) 0 = b := rfl

@[simp]
theorem BitStream.cons_succ (b : Bool) (bs : BitStream) (n : Nat) :
    (BitStream.cons b bs) (n + 1) = bs n := rfl


/-- Append n bits to the left of a bitstream. -/
def BitStream.appendLeft (b : BitStream)
    (n : Nat)
    (env : Fin n → Bool) : BitStream :=
    match n with
    | 0 => b
    | n + 1 => BitStream.cons (env 0) (b.appendLeft n (fun k => env k.succ))

@[simp]
theorem BitStream.appendLeft_zero (b : BitStream) (env : Fin 0 → Bool) :
    b.appendLeft 0 env = b := rfl


@[simp]
theorem BitStream.appendLeft_succ (b : BitStream) (n : Nat)
    (env : Fin (n + 1) → Bool) :
    b.appendLeft (n + 1) env =
      BitStream.cons (env 0) (b.appendLeft n (fun k => env k.succ)) := rfl

@[simp]
theorem BitStream.appendLeft_eq_ite (b : BitStream) (n : Nat)
    (env : Fin n → Bool) (k : Nat) :
    (b.appendLeft n env) k =
      if h : k < n then env ⟨k, h⟩ else b (k - n) := by
  induction n generalizing k with
  | zero =>
    simp [BitStream.appendLeft]
  | succ n ihn =>
    simp
    induction k
    case zero => simp
    case succ k ihk =>
      simp [ihn]

/-- Lift a circuit to a bitstream by pointwise evaluation. -/
def BitStream.ofCircuitPointwise(circ : Circuit α) (env : α → BitStream) : BitStream :=
  fun n => circ.eval (fun a => env a n)

@[simp]
theorem eval_ofCircuitPointwise (circ : Circuit α) (env : α → BitStream) (n : Nat) :
    (BitStream.ofCircuitPointwise circ env) n =
      circ.eval (fun a => env a n) := rfl

/-- Drop the first n bits of a bitstream. -/
def BitStream.drop (bs : BitStream) (n : Nat) : BitStream :=
  fun k => bs (k + n)

@[simp]
theorem BitStream.eval_drop (bs : BitStream) (n k : Nat) :
    (BitStream.drop bs n) k = bs (k + n) := rfl

/--
Produce the output stream differential equation as a bitstream.
-/
def StreamDiffEq.toStream [DecidableEq ι]
      (s : StreamDiffEq ι npast) (inputStream : ι → BitStream) : BitStream :=
  let newStreams : ι → BitStream := fun i =>
    BitStream.appendLeft (inputStream i) npast
      (fun kpast => s.inInit ⟨i, kpast⟩)
  BitStream.ofCircuitPointwise s.outCircuit fun iv =>
    (newStreams iv.input).drop iv.past

@[simp]
theorem StreamDiffEq.toStream_eq_eval_of_lt [DecidableEq ι]
    (s : StreamDiffEq ι npast)
    (env : InputVar ι npast → Bool)
    (inputStream : ι → BitStream) (n : Nat) (hn : ix < npast) :
    (s.toStream inputStream) ix = s.outCircuit.eval env := by
  simp [StreamDiffEq.toStream, BitStream.eval_drop]
  congr
  ext i
  sorry

/--
Produce the output stream differential equation as a FSM
-/
def StreamDiffEq.toFSM [DecidableEq ι] [Hashable ι] [FinEnum ι]
    (s : StreamDiffEq ι npast) : FSM ι where
  α := InputVar ι npast
  initCarry := s.inInit
  outputCirc := s.outCircuit.map Sum.inl
  -- | we need to rotate, and send bits to the more past state.
  nextStateCirc := fun iv =>
      if h : iv.past.val = 0 then
        Circuit.var true <| .inr iv.input
      else
        Circuit.var true <| .inl ⟨iv.input, ⟨iv.past.val - 1, by omega⟩⟩

theorem StreamDiffEq.toFsm_eval_eq_toStream [DecidableEq ι] [Hashable ι]
    [FinEnum ι] (s : StreamDiffEq ι npast) (inputStream : ι → BitStream) :
    (s.toFSM.eval inputStream) = (s.toStream inputStream) := by
  ext i
  by_cases hi : i < npast
  · simp
  · sorry
