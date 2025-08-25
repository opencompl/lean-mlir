
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.Tactic.SimpLLVM
import SSA.Projects.SLLVM.Tactic.SimpSet

macro "simp_sllvm" : tactic => `(tactic|(
  simp -failIfUnchanged only [simp_sllvm, simp_llvm, simp_llvm_option]
))

attribute [simp_sllvm]
  -- Poison lemmas
  PoisonOr.value_isRefinedBy_value PoisonOr.poison_isRefinedBy
  PoisonOr.not_value_isRefinedBy_poison
  PoisonOr.value_bind PoisonOr.bind_poison PoisonOr.poison_bind
  PoisonOr.value_ne_poison PoisonOr.poison_ne_value PoisonOr.value_inj
  PoisonOr.pure_def
  -- Poison ite lemmas
  PoisonOr.ite_value_value
  PoisonOr.bind_if_then_poison_eq_ite_bind
  PoisonOr.if_then_poison_isRefinedBy_iff
  PoisonOr.value_isRefinedBy_if_then_poison_iff
  -- Prop
  not_false_eq_true not_true_eq_false ne_eq
  true_and and_true false_and and_false
  true_or or_true false_or or_false
  imp_false implies_true
  or_self and_self
  not_or not_and Decidable.not_not
  -- Bool
  Bool.false_eq_true
  Bool.or_eq_true Bool.and_eq_true
  beq_iff_eq bne_iff_ne
  BitVec.ofBool_eq_one_iff
  decide_eq_true_iff
  -- Id
  Id
  -- Refinement
  StateT.isRefinedBy_iff Prod.isRefinedBy_iff
  -- Other general simp lemmas
  reduceIte bind_assoc

-- attribute [simp_sllvm_split(low)]
--   PoisonOr.ite_isRefinedBy_iff
--   PoisonOr.isRefinedBy_ite_iff

section ItePoison
open Lean Meta PoisonOr

/-!
### if-then-else and poison
We will now define simprocs and lemmas that normalize `if-then-else` expressions
involving poison. Together, they ensure that any occurence of `poison` in a
nested sequence of `if-then-else`s is pulled towards the top-level then branch,
for any further simp lemmas to easily match on.
-/

/--
Canonicalize `if c then _ else poison` to `if ¬c then poison else _`, whenever
the then-branch isn't already `poison`.

NOTE: this simproc causes an infinite loop if paired with either `ite_not` or
`Classical.ite_not`, both of which are in the global simpset. Neither of those
should thus be added to `simp_llvm`.
-/
simproc [simp_sllvm] commIfElsePoison (ite (α := no_index _) _ _ poison) := fun e => do
  let_expr ite α c inst x y := e | return .continue
  if x.isAppOf ``PoisonOr.poison then
    return .continue
  let u ← getLevel α
  let expr :=
    let c' := mkNot c
    let inst' := mkApp2 (mkConst ``instDecidableNot) c inst
    mkAppN (.const ``ite [u]) #[α, c', inst', y, x]
  let proof := mkAppN (.const ``ite_not [u]) #[α, c, inst, y, x]
  let proof ← mkEqSymm proof
  return .visit { expr, proof? := some proof }

/-- auxiliary lemma used in `assocIfElseIfThenPoison` simproc -/
private theorem if_else_if_then_poison_eq {α : Type} (c₁ c₂ : Prop) [Decidable c₁] [Decidable c₂]
      (x y : PoisonOr α):
    (if c₁ then x else (if c₂ then poison else y)) =
    (if ¬c₁ ∧ c₂ then poison else (if c₁ then x else y)) := by
  split <;> simp [*]

/--
Canonicalize using `if_else_if_then_poison_eq`, if the then branch (`x` in the
lemma) is not already poison.
-/
simproc [simp_sllvm] assocIfElseIfThenPoison
    (ite (α := no_index _) _ _ (ite (α := no_index _) _ poison _)) := fun e => do
  let_expr ite _α c₁ _inst₁ x py := e | return .continue
  if x.isAppOf ``PoisonOr.poison then
    return .continue
  let_expr ite _ c₂ _inst₂ p y := py | return .continue

  let c' := mkAnd (mkNot c₁) c₂
  let expr ← mkAppM ``ite #[c', p, ← mkAppM ``ite #[c₁, x, y]]
  let proof ← mkAppM ``if_else_if_then_poison_eq #[c₁, c₂, x, y]
  return .visit { expr, proof? := proof }

/--
Normalize a nested `if` in the `then` branch. Note: in this case it's impossible
for the first then branch to already be poison (since it's an if-then-else),
thus there is no need for a simproc; a regular simp lemma suffices
-/
@[simp_sllvm]
theorem PoisonOr.if_then_if_then_poison_eq {α : Type} (c₁ c₂ : Prop) [Decidable c₁] [Decidable c₂]
      (x y : PoisonOr α):
    (if c₁ then (if c₂ then poison else x : no_index _) else y : no_index _) =
    (if c₁ ∧ c₂ then poison else (if c₁ then x else y : no_index _) : no_index _) := by
  split <;> simp [*]

end ItePoison

/-! ## `simp_sllvm_split` -/

macro "simp_sllvm_split" : tactic => `(tactic|(
  all_goals
    try intros
    simp_all -failIfUnchanged -implicitDefEqProofs +contextual only [
      simp_sllvm, simp_llvm_split, simp_llvm, seval
    ]
    try intros -- introduce any new hypotheses that may have been added

    /- At this point, we should only have pure bitvector if-statements.
    `bv_decide` supports those natively, but unfortunately these if-statements
    tend to trigger time outs, whereas splitting them and feeding the subgoals
    to `bv_decide` seems to work pretty fast, so that's what we do. -/
    repeat' (split <;> simp_all -failIfUnchanged -implicitDefEqProofs +contextual only [
      simp_sllvm, simp_llvm_split, simp_llvm, seval
    ])
  ))


/-! ## `simp_sllvm_case_bash` -/

macro "simp_sllvm_case_bash" : tactic => `(tactic|
  simp_alive_case_bash <;> simp_sllvm
)
