import Blase.Fast.Circuit
import Blase.Fast.FiniteStateMachine

structure InputVar (ι : Type) (npast : Nat) where
  inputIx : ι
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
    toFun := fun { inputIx, past } =>
      let instFinEnumFinNpast : FinEnum (Fin npast) := by infer_instance
      let finInput := instFinEnumI.equiv.toFun inputIx
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
  /-- The output value for the first n steps. -/
  initialOutputVal : Fin npast → Bool
  /-- The output as a circuit of the past 'npast' inputs. -/
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
def BitStream.appendLeft (n : Nat) (env : Fin n → Bool) (b : BitStream) : BitStream :=
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
    fun k =>
      if h : k < npast then
        s.initialOutputVal ⟨k, by omega⟩
      else
        s.outCircuit.eval (fun input =>
            inputStream input.inputIx (k - input.past.val)
        )


@[simp]
theorem StreamDiffEq.toStream_eq_initialOutputVal_of_lt [DecidableEq ι]
    (s : StreamDiffEq ι npast)
    (inputStream : ι → BitStream) (hn : k < npast) :
    (s.toStream inputStream) k = s.initialOutputVal ⟨k, hn⟩ := by
  simp [StreamDiffEq.toStream, hn]

@[simp]
theorem StreamDiffEq.toStream_eq_eval_of_le [DecidableEq ι]
    (s : StreamDiffEq ι npast)
    (inputStream : ι → BitStream) (hn : npast ≤ k) :
    (s.toStream inputStream) k =
      s.outCircuit.eval (fun input => inputStream input.inputIx (k - input.past.val) ) := by
  simp [StreamDiffEq.toStream, hn]

/--
Produce the output stream differential equation as a FSM
-/
def StreamDiffEq.toFSM [DecidableEq ι] [Hashable ι] [FinEnum ι]
    (s : StreamDiffEq ι npast) : FSM ι where
  α := InputVar ι npast
  initCarry := fun _ => true
  -- | completely ignore the current input?
  -- | No, that seems wrong! Instead, we just need to output the current circuit output.
  -- What we should do, is for the first N steps, output whatever the output
  -- says, and after that, just keep outputting the circuit output.
  outputCirc :=
    s.outCircuit.map fun iv =>
      if h : iv.past.val = 0 then
          .inr iv.inputIx
      else
          .inl (InputVar.mk (iv.inputIx) ⟨iv.past.val - 1, by omega⟩)
  -- | we need to rotate, and send bits to the more past state.
  nextStateCirc := fun iv =>
      if h : iv.past.val = 0 then
        Circuit.var true <| .inr iv.inputIx
      else
        Circuit.var true <| .inl ⟨iv.inputIx, ⟨iv.past.val - 1, by omega⟩⟩

/--
Make an FSM that overrides the output of another FSM for one clock cycle
to a constant value.
-/
def fsmOverrideOutput (f : FSM arity) (b : Bool) : FSM arity where
  α := Unit ⊕ f.α
  initCarry := fun i =>
    match i with
    | .inl () => true
    | .inr a => f.initCarry a
  outputCirc :=
    Circuit.ite (Circuit.var true <| .inl (.inl ()))
      (Circuit.ofBool b)
      (f.outputCirc.map fun v =>
        match v with
        | .inl fa => .inl (.inr fa)
        | .inr a => .inr a)
  nextStateCirc := fun i =>
    match i with
    | .inl () => .ofBool false -- make 'false'.
    | .inr a =>
      (f.nextStateCirc a).map fun v =>
        match v with
        | .inl fa => .inl (.inr fa)
        | .inr a => .inr a

@[simp]
theorem eval_FsmOverrideOutput_zero
    {f : FSM arity} {b : Bool} {env : arity → BitStream} :
    (fsmOverrideOutput f b).eval env 0 = b := by
  simp [FSM.eval, fsmOverrideOutput, FSM.nextBit]
  split_ifs
  case pos h => simp [h]
  case neg h => simp [h]

@[simp]
theorem carry_fsmOverrideOutput_eq
    {f : FSM arity} {b : Bool} {env : arity → BitStream} :
    ∀ (a : f.α), ((fsmOverrideOutput f b).carry env n) (.inr a) = (f.carry env n) a := by
  induction n generalizing env b
  case zero =>
    intros a
    simp [fsmOverrideOutput, FSM.carry, FSM.nextBit, Circuit.eval_map]
  case succ n ihn =>
    intros a
    simp [fsmOverrideOutput, FSM.carry, FSM.nextBit, Circuit.eval_map]
    congr
    ext i
    rcases i with a | i
    · simp only [Sum.elim_inl]
      rw [← ihn (env := env) (b := b)]
      simp [fsmOverrideOutput]
    · simp

@[simp]
theorem eval_FsmOverrideOutput_succ {f : FSM arity} {b : Bool} :
    (fsmOverrideOutput f b).eval env n =
      if n = 0 then b else f.eval env n := by
  -- | TODO: replace all FSM proofs with `eval_induction_1`?
  -- TODO: Write about this reasoning principle in the paper.
  induction n using FSM.eval_induction_1
    (fsm := fsmOverrideOutput f b)
    (inputs := env)
    (SInv := fun (i : Nat) (state : Unit ⊕ f.α → Bool) =>
      (∀ a, state (.inr a) = (f.carry env i) a) ∧ (state (.inl ()) = decide (i = 0)))
  case hstate0 =>
    constructor
    · intros a
      simp [fsmOverrideOutput]
    · simp [fsmOverrideOutput]
  case hStateSucc k state ih =>
    simp [fsmOverrideOutput, FSM.nextBitState, FSM.nextBit]
    simp [FSM.carry]
    simp [FSM.nextBit, Circuit.eval_map]
    intros a
    congr
    ext i
    rcases i with a | i
    · simp [ih]
    · simp
  case hEval k state ih =>
    simp [fsmOverrideOutput, FSM.nextBitOutput, FSM.nextBit]
    obtain ⟨ih1, ih2⟩ := ih
    simp [ih2]
    split
    case isTrue hk =>
      subst hk
      rcases hb : b <;> simp
    case isFalse hk =>
      simp [Circuit.eval_map]
      simp [FSM.eval, FSM.nextBit]
      congr
      ext i
      rcases i with a | i
      · simp [ih1]
      · simp
