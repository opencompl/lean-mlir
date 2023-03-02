-- We create a verified conversion from SSA minus Regions (ie, a sequence
-- of let bindings) into an expression tree. We prove that this
-- conversion preserves program semantics.
import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Function
import Mathlib.Data.Set.Image
import Aesop

-- Kinds of values
inductive Kind where
| int
| unit
| pair : Kind → Kind → Kind
deriving DecidableEq

-- Kinds of expressions
inductive ExprKind
| O -- single op
| Os -- sequence of ops
abbrev Var := String

-- Well typed, simply typed kinds of ops. eg. 'add' takes two 'ints' and returns an 'int'
 inductive OpKind : Kind → Kind → Type
| add: OpKind (.pair int int) int
| const : OpKind unit int
| sub: OpKind (.pair int int) int
| negate: OpKind int int


inductive Expr : ExprKind → Type where
| assign (ret : Var) (kind: OpKind i o) (arg: Var) : Expr .O -- ret = kind (arg)
| pair (ret : Var) (arg1: Var) (k1: Kind) (arg2 : Var) (k2: Kind) : Expr .O -- ret = (arg1, arg2)
| ops: Expr .O → Expr .Os → Expr .Os -- op ;; ops.

-- the return kind of the expression. ie, what is the
-- type of the final value that this expression computes.
abbrev Expr.retKind : Expr k → Kind
| .assign (o := o) .. => o
| .pair (k1 := k1) (k2 := k2) .. => Kind.pair k1 k2
| .ops _ o2 => o2.retKind

-- the return variable of the expression. ie, what is the
-- name of the final value that this expression computes.
abbrev Expr.retVar : Expr k → Var
| .assign (ret := ret) .. => ret
| .pair (ret := ret)  .. => ret
| .ops _ o2 => o2.retVar

abbrev Op := Expr .O
abbrev Ops := Expr .Os

abbrev Op.retKind: Op → Kind := Expr.retKind

-- builder helpers
@[match_pattern]
abbrev Op.assign (ret : Var) (kind : OpKind i o) (arg : Var) : Op :=
  Expr.assign ret kind arg

@[match_pattern]
abbrev Op.pair (ret : Var) (arg1 : Var) (k1: Kind) (arg2: Var) (k2: Kind) : Op :=
  Expr.pair ret arg1 k1 arg2 k2

abbrev Op.ret : Expr .O → String
| .pair (ret := ret) .. => ret
| .assign (ret := ret) .. => ret


inductive ExprTree where
| pair: ExprTree → ExprTree → ExprTree
| compute: ExprTree → ExprKind → ExprTree

/-
TODO: make a section and use `variable` for reuse
-/


-- A TypingContext that tracks which variables have been defined.
def TypingContext := String → Option Kind

-- empty def context
def TypingContext.bottom : TypingContext := fun _ => .none

-- bind the name 'name' of kind 'kind' to the def context 'ctx.
def TypingContext.bind (bindname : String) (bindkind: Kind) (ctx: TypingContext): TypingContext :=
  fun name => if name = bindname then bindkind else ctx name

/-
Actually, I feel like I am stupid. We don't usually write the typing judgement
as 'returning' a context, we write it as 'having' a context. So, I think I need
to change the definition of ExprWellTyped to be
-/
-- inductive propsition which asserts when an expression is well formed.
inductive ExprWellTyped : TypingContext → Expr kind → TypingContext → Type where
| assign
    {ret arg : Var}
    {ctx : TypingContext}
    {kind: OpKind i o}
    (ARG : ctx arg = .some i)
    (RET: ctx ret = .none) :
    ExprWellTyped ctx (Op.assign ret kind arg) (ctx.bind ret o)
| pair
  {ctx : TypingContext}
  {ret arg1 arg2 : Var}
  {k1 k2 : Kind}
  (ARG1 : ctx arg1 = .some k1)
  (ARG2 : ctx arg2 = .some k2)
  (RET: ctx ret = .none) :
  ExprWellTyped ctx (Op.pair ret arg1 k1 arg2 k2) (ctx.bind ret (Kind.pair k1 k2))
| ops
  {ctxbegin ctxend : TypingContext}
  {ctxmid : TypingContext}
  (WF1: ExprWellTyped ctxbegin op1 ctxmid)
  (WF2: ExprWellTyped ctxmid op2 ctxend) :
  ExprWellTyped ctxbegin (Expr.ops op1 op2) ctxend

-- forded version of `assign` that allows an arbitrary `ctx'`, while stipuating
-- what conditions `ctx'` needs to satisfy
@[simp]
def ExprWellTyped.mk_assign
  {kind : OpKind i o}
  (ARG: ctx arg = .some i)
  (RET: ctx ret = .none)
  (CTX': ctx' = ctx.bind ret o)
  : ExprWellTyped ctx (Op.assign ret kind arg) ctx' :=
    CTX' ▸ (ExprWellTyped.assign ARG RET) -- @chris: is this evil?

-- forded version of `pair` that allows an arbitrary `ctx'`, while stipuating
-- what conditions `ctx'` needs to satisfy
@[simp]
def ExprWellTyped.mk_pair
  {k1 k2: Kind}
  (ARG1: ctx arg1 = .some k1)
  (ARG2: ctx arg2 = .some k2)
  (RET: ctx ret = .none)
  (CTX': ctx' = ctx.bind ret (Kind.pair k1 k2))
  : ExprWellTyped ctx (Op.pair ret arg1 k1 arg2 k2) ctx' :=
    CTX' ▸ (ExprWellTyped.pair ARG1 ARG2 RET) -- @chris: is this evil?

-- inversion theorems for 'ExprWellTyped'
def ExprWellTyped.assign_inv {ctx ctx' : TypingContext} {ret arg : Var} {kind: OpKind i o}
  (WF: ExprWellTyped ctx (Op.assign ret kind arg) ctx'):
  ctx arg = .some i ∧ ctx ret = .none ∧ ctx' = ctx.bind ret o :=
  match WF with
  | ExprWellTyped.assign ARG RET => ⟨ARG, RET, rfl⟩

def ExprWellTyped.pair_inv {ctx ctx' : TypingContext} {ret arg1 arg2 : Var} {k1 k2 : Kind}
  (WF: ExprWellTyped ctx (Op.pair ret arg1 k1 arg2 k2) ctx') :
  ctx arg1 = .some k1 ∧ ctx arg2 = .some k2 ∧ ctx ret = .none ∧ ctx' = ctx.bind ret (Kind.pair k1 k2) :=
  match WF with
  | ExprWellTyped.pair ARG1 ARG2 RET => ⟨ARG1, ARG2, RET, rfl⟩

def ExprWellTyped.ops_inv {ctxbegin ctxend : TypingContext} {op1 : Expr .O} {ops : Expr .Os}
  (WF: ExprWellTyped ctxbegin (Expr.ops op1 ops) ctxend) :
  Σ ctxmid, (ExprWellTyped ctxbegin op1 ctxmid) ×  (ExprWellTyped ctxmid ops ctxend) :=
  match WF with
  | ExprWellTyped.ops (ctxmid := ctxmid)  WF1 WF2 => ⟨ctxmid, WF1, WF2⟩


-- computational version of 'ExpreWellFormed' for reflection.
def ExprWellTyped.compute : Expr kind → TypingContext → Option TypingContext
| (.assign (i := i) (o := o) ret kind arg), ctx =>
    if ctx ret ≠ .none
    then .none
    else if ctx arg ≠ i
    then .none
    else .some (ctx.bind ret o)
| (.pair ret arg1 k1 arg2 k2), ctx =>
    if ctx ret ≠ .none then .none
    else if ctx arg1 ≠ k1 then .none
    else if ctx arg2 ≠ k2 then .none
    else .some (ctx.bind ret (Kind.pair k1 k2))
| (Expr.ops op1 op2), ctx =>
    Option.bind (ExprWellTyped.compute op1 ctx) (ExprWellTyped.compute op2)

-- completeness: if the inducitve propositoin holds, then the decision
-- procedure says yes.
theorem ExprWellTyped.prop_implies_compute:
  ∀ {ctx ctx' : TypingContext} {expr : Expr kind},
  ExprWellTyped ctx expr ctx' ->
  .some ctx' = ExprWellTyped.compute expr ctx := by {
  intros ctx ctx' expr;
  revert ctx ctx';
  induction expr;
  case assign ret kind arg => {
    intros ctx ctx' WELLFORMED;
    cases WELLFORMED;
    case assign RET ARG => {
      simp[compute]; aesop;
    }
  }
  case pair ret arg1 arg2 => {
    intros ctx ctx' WELLFORMED;
    cases WELLFORMED;
    case pair RET ARG1 ARG2 => {
      simp[compute]; aesop;
    }
  }
  case ops op1 op2 IH1 IH2 => {
    intros ctx ctx'' WELLFORMED;
    cases WELLFORMED;
    case ops ctx' WF1 WF2 => {
      simp[compute];
      specialize (IH1 WF1);
      specialize (IH2 WF2);
      cases OP1:(compute op1 ctx) <;> simp[OP1] at IH1;
      cases OP2:(compute op2 ctx') <;> simp[OP2] at IH2;
      aesop;
    }
  }
}

-- a expr and a ctx uniquely determine a ctx' if it exists.
-- @chris: is there a name for this? Should I make this a `FunLike`?
theorem ExprWellTyped.deterministic
  {ctx ctx' ctx'' : TypingContext} {expr : Expr kind}
  (WF1: ExprWellTyped ctx expr ctx') (WF2: ExprWellTyped ctx expr ctx'') : ctx' = ctx'' := by {
    have COMPUTE1 := ExprWellTyped.prop_implies_compute WF1;
    have COMPUTE2 := ExprWellTyped.prop_implies_compute WF2;
    rw[← COMPUTE1] at COMPUTE2;
    injection COMPUTE2 with EQ;
    exact (Eq.symm EQ); -- @chris: why is this not a simp lemma?
 }


instance : Subsingleton (@ExprWellTyped ek ctx op ctx') :=
 ⟨fun wf1 wf2 => by {
    induction wf1;
    case assign i o ret arg ctx kind ARG RET => {
      cases wf2; simp[proofIrrel];
    };
    case pair ret arg1 arg2 k1 k2 ARG1 ARG2 RET => {
      cases wf2; simp[proofIrrel];
    };
    case ops op' ops' ctxbegin ctxend ctxmid WF_OP WF_OPS IH_OP IH_OPS => {
      cases wf2;
      case ops ctxmid' WF_OP' WF_OPS' => {
        -- Need a theorem that ExprWellTyped returns a deterministic "ctx'"
        have CTXMID_EQ: ctxmid = ctxmid' := ExprWellTyped.deterministic WF_OP WF_OP';
        subst CTXMID_EQ;
        have IH_OP' := IH_OP WF_OP';
        have IH_OPS' := IH_OPS WF_OPS';
        simp[proofIrrel];
        constructor <;> assumption;
      }
    }
  }
⟩

-- (compute = true) => (stuff holds)
theorem ExprWellTyped.compute_implies_prop:
  ∀ {ctx ctx' : TypingContext} {expr : Expr kind},
  .some ctx' = ExprWellTyped.compute expr ctx ->
  ExprWellTyped ctx expr ctx' := by {
  intros ctx ctx' expr;
  revert ctx ctx';
  induction expr;
  case assign ret kind arg => {
    intros ctx ctx' COMPUTE;
    simp[compute] at COMPUTE;
    apply ExprWellTyped.mk_assign <;> aesop;
  }
  case pair ret arg1 arg2 => {
    intros ctx ctx' COMPUTE;
    simp[compute] at COMPUTE;
    apply ExprWellTyped.mk_pair <;> aesop;
  }
  case ops o1 o2 IH1 IH2 => {
    intros ctx ctx'' COMPUTE;
    simp[compute] at COMPUTE;
    cases CTXO1:(compute o1 ctx) <;> simp[CTXO1] at COMPUTE; case some ctx' => {
      cases CTXO2:(compute o2 ctx') <;> simp[CTXO2] at COMPUTE; case some ctx''_2 => {
        subst COMPUTE;
        apply ExprWellTyped.ops (ctxmid := ctx') <;> aesop;
      }
    }
  }
}


-- Reflection tactic to reflect the proof level 'ExprWellTyped'
-- into computation level 'ExprWellTyped.compute'
-- @chris: is this theorem even useful?
theorem ExprWellTyped.reflect (ctx : TypingContext) (expr : Expr kind) :
  { ctxfun : TypingContext // .some ctxfun = ExprWellTyped.compute expr ctx } ≃
  Σ (ctxprop : TypingContext), (ExprWellTyped ctx expr ctxprop) := {
    toFun := fun ctxfun => ⟨ctxfun.val, ExprWellTyped.compute_implies_prop ctxfun.property⟩
    invFun := fun WF => ⟨WF.fst, ExprWellTyped.prop_implies_compute WF.snd⟩,
    left_inv := by { intros CTXFUN; simp; },
    right_inv := by {
      intros WF; cases WF with | mk => simp;
    }
  }

-- An expression is said to well formed if it is well formed
-- starting from the given context.
def Expr.wellFormed (e: Expr k) (ctx: TypingContext := TypingContext.bottom) : Type
  := Σ ctx', ExprWellTyped ctx e ctx'

/-
TODO: make a section and use `variable` for reuse
-/

-- context necessary for evaluating expressions.
def EvalContext (kindMotive: Kind → Type) : Type
  := String → Option ((kind: Kind) × (kindMotive kind))


-- empty evaluation context.
def EvalContext.bottom (kindMotive: Kind → Type) : EvalContext kindMotive := fun _  => .none

-- add a binding into the evaluation context.
def EvalContext.bind {kindMotive: Kind → Type}
  (bindname : String) (bindk: Kind) (bindv: kindMotive bindk)
  (ctx: EvalContext kindMotive) : EvalContext kindMotive :=
  fun name => if (name = bindname) then .some ⟨bindk, bindv⟩ else ctx name

-- lookup a binding by both name and kind.
def EvalContext.lookupByKind {kindMotive: Kind → Type} (ctx: EvalContext kindMotive)
  (name : String) (needlekind: Kind) : Option (kindMotive needlekind) :=
  match ctx name with
  | .none => .none
  | .some ⟨k, kv⟩ =>
      if NEEDLE : needlekind = k
      then NEEDLE ▸ kv
      else .none

-- Simplify `lookupByKind` when we have a syntactically
-- matching `lookup`result.
theorem EvalContext.lookupByKind_lookup_some {kindMotive: Kind → Type} {evalctx: EvalContext kindMotive}
  {k: Kind} {v: kindMotive k} {name: String}
  (LOOKUP: evalctx name = some { fst := k, snd := v }) :
  (evalctx.lookupByKind name k = .some v) := by {
    simp[EvalContext.lookupByKind, LOOKUP];
  }

-- Simplify `lookupByKind` when we have a syntactically
-- matching `lookup`result.
theorem EvalContext.lookupByKind_lookup_none {kindMotive: Kind → Type} {evalctx: EvalContext kindMotive}
  {k: Kind} {name: String}
  (LOOKUP: evalctx name = none):
  (evalctx.lookupByKind name k = .none) := by {
    simp[EvalContext.lookupByKind, LOOKUP];
  }


-- Treat an eval context as a def context by ignoring the eval value.
def EvalContext.toTypingContext (ctx: EvalContext kindMotive): TypingContext :=
  fun name =>
    match ctx name with
    | .none => .none
    | .some ⟨k, _kv⟩ => k

-- show that 'evalcontext' and 'todefcontext' agree.
theorem EvalContext.toTypingContext.agreement:
∀ ⦃ctx: EvalContext kindMotive⦄  ⦃name: String⦄,
  (ctx name).isSome ↔ (ctx.toTypingContext name).isSome := by {
    intros ctx name;
    simp[toTypingContext];
    cases ctx name <;> simp;
}

section ExprFoldExtraction

/-
Showing that a value can be extracted out of Expr.fold?
whenever the expr is well formed.
-/

-- If 'dctx' has a value at 'name', then so does 'ectx' at 'name' if
-- 'dctx' came from 'ectx'.
-- @chris: what's the mathlib version of this?
def EvalContext.toTypingContext.preimage_some
  { kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {dctx: TypingContext}
  (DCTX: EvalContext.toTypingContext ectx = dctx)
  {name : String}
  {kind : Kind}
  (LOOKUP: dctx name = .some kind) :
  { val : kindMotive kind // ectx name = .some ⟨kind, val⟩ } := by {
    rewrite[← DCTX] at LOOKUP;
    simp[toTypingContext] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩ <;> aesop;
}

theorem EvalContext.toTypingContext.preimage_none
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {dctx: TypingContext}
  (DCTX: EvalContext.toTypingContext ectx = dctx)
  {name : String}
  (LOOKUP: dctx name = .none) :
  ectx name = .none := by {
    rewrite[← DCTX] at LOOKUP;
    simp[toTypingContext] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩ <;> aesop;
}

theorem EvalContext.toTypingContext.bind
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {dctx: TypingContext}
  (DCTX: EvalContext.toTypingContext ectx = dctx)
  {kind : Kind}
{val: kindMotive kind}
  {name: String} :
  (EvalContext.bind name kind val ectx).toTypingContext = TypingContext.bind name kind dctx := by {
    funext key;
    simp[toTypingContext, TypingContext.bind, EvalContext.bind];
    by_cases NAME:(key = name) <;> simp[NAME];
    case neg => {
      simp[NAME];
      simp[toTypingContext];
      cases DCTX_KEY:(dctx key);
      case none => {
        have ECTX_KEY := EvalContext.toTypingContext.preimage_none DCTX DCTX_KEY;
        simp[ECTX_KEY];
      }
      case some => {
        have ⟨ectx_val, ECTX_KEY⟩:= EvalContext.toTypingContext.preimage_some DCTX DCTX_KEY;
        simp[ECTX_KEY];
      }
    }
}

/-  Expression evalation as a relation. -/
-- (kernel) arg #10 of 'ExprEval.ops' contains a non valid occurrence of the datatypes being declared
inductive ExprEval {kindMotive : Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')) :
  (EvalContext kindMotive) → Expr ek → (EvalContext kindMotive) → Type where
  | assign {ctx: EvalContext kindMotive}
    {i o : Kind}
    {ret: String}
    {opkind: OpKind i o}
    {arg: String}
    {argv: kindMotive i}
    (ARG: ctx.lookupByKind arg i = .some argv)
    (RET: ctx ret = .none)
    : ExprEval opFold pairFold ctx (Op.assign ret opkind arg) (ctx.bind ret o (opFold opkind argv))
  | pair
    {ctx: EvalContext kindMotive}
    {ret : String}
    {arg1 arg2: Var}
    {k1 k2: Kind}
    {v1: kindMotive k1}
    {v2: kindMotive k2}
    (ARG1: ctx.lookupByKind arg1 k1 = .some v1)
    (ARG2: ctx.lookupByKind arg2 k2 = .some v2)
    (RET: ctx ret = .none)
    : ExprEval opFold pairFold ctx (Op.pair ret arg1 k1 arg2 k2) (ctx.bind ret (Kind.pair k1 k2) (pairFold v1 v2))
  | ops
    {ctxbegin: EvalContext kindMotive} (ctxmid: EvalContext kindMotive)
    {ctxend: EvalContext kindMotive}
    {op: Expr .O}
    {ops: Expr .Os}
    (EVAL_OP: @ExprEval kindMotive @opFold @pairFold .O ctxbegin op ctxmid)
    (EVAL_OPS: @ExprEval kindMotive @opFold @pairFold .Os ctxmid ops ctxend)
    : ExprEval opFold pairFold ctxbegin (Expr.ops op ops) ctxend


-- forded version of 'ExprEval.assign' that allows any `ctx'`, with a hypothesis
-- that `ctx'` needs to satisfy.
@[simp]
def ExprEval.mk_assign
  {kindMotive: Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ctx: EvalContext kindMotive}
  {i o : Kind}
  {ret: String}
  {opkind: OpKind i o}
  {arg: String}
  {argv: kindMotive i}
  (ARG: ctx.lookupByKind arg i = .some argv)
  (RET: ctx ret = .none)
  (ctx': EvalContext kindMotive)
  (CTX': ctx' = ctx.bind ret o (opFold opkind argv))
  : ExprEval opFold pairFold ctx (Op.assign ret opkind arg) ctx' :=
  by { subst CTX'; apply ExprEval.assign ARG RET }

-- forded version of 'ExprEval.pair'
@[simp]
def ExprEval.mk_pair
  {kindMotive: Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ctx: EvalContext kindMotive}
  {ret : String}
  {arg1 arg2: Var}
  {k1 k2: Kind}
  {v1: kindMotive k1}
  {v2: kindMotive k2}
  (ARG1: ctx.lookupByKind arg1 k1 = .some v1)
  (ARG2: ctx.lookupByKind arg2 k2 = .some v2)
  (RET: ctx ret = .none)
  {ctx': EvalContext kindMotive}
  (CTX': ctx' = ctx.bind ret (Kind.pair k1 k2) (pairFold v1 v2))
  : ExprEval opFold pairFold ctx (Op.pair ret arg1 k1 arg2 k2) ctx' :=
  by { subst CTX'; apply ExprEval.pair ARG1 ARG2 RET }

@[simp]
def ExprEval.mk_ops
  {kindMotive: Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ctxbegin: EvalContext kindMotive} (ctxmid: EvalContext kindMotive)
  {ctxend: EvalContext kindMotive}
  {op: Expr .O}
  {ops: Expr .Os}
  (EVAL_OP: @ExprEval kindMotive @opFold @pairFold .O ctxbegin op ctxmid)
  (EVAL_OPS: @ExprEval kindMotive @opFold @pairFold .Os ctxmid ops ctxend)
  (ctx': EvalContext kindMotive)
  (CTX': ctx' = ctxend)
  : ExprEval opFold pairFold ctxbegin (Expr.ops op ops) ctx' :=
  by { subst CTX'; apply ExprEval.ops (ctxmid := ctxmid) EVAL_OP EVAL_OPS; }


-- if we have `ExprEval[ctx op ctx']` then we can extract the result of the operation `op` from `ctx'`.
def ExprEval.extractResult
  {kindMotive: Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ctx : EvalContext kindMotive}
  {ek: ExprKind} {e: Expr ek}
  {ctx': EvalContext kindMotive}
  (EVAL: ExprEval opFold pairFold ctx e ctx') :
  kindMotive e.retKind :=
  match EVAL with
  | .assign (opkind := opkind) (argv := argv) .. =>   opFold opkind argv
  |  .pair (v1 := v1) (v2 := v2) .. => pairFold v1 v2
  | @ExprEval.ops (ops := rest) (EVAL_OPS := EVAL_OPS) .. =>
      (ExprEval.extractResult opFold pairFold EVAL_OPS : kindMotive (Expr.retKind rest))


/-
TODO: @chris why is this 'noncomputable' ?
failed to compile definition, consider marking it as 'noncomputable'
because it depends on 'Expr.fold?.match_3',
and it does not have executable code
-/
def Expr.fold? -- version of fold that returns option.
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ctx : EvalContext kindMotive): (e : Expr ek) → Option (EvalContext kindMotive)
| .assign (i := i) (o := o) ret opkind arg =>
    match ctx.lookupByKind arg i with
    | .none => .none
    | .some argv =>
        match ctx ret with
        | .some _ => .none
        | .none => ctx.bind ret o (opFold opkind argv)
| .pair ret arg1 k1 arg2 k2 =>
  match ctx.lookupByKind arg1 k1, ctx.lookupByKind arg2 k2 with
    | .some arg1v, .some arg2v =>
      match ctx ret with
      | .some _ => .none
      | .none => ctx.bind ret (Kind.pair k1 k2) (pairFold arg1v arg2v)
    | _, _ => .none
| .ops o1 o2 =>
  match o1.fold? opFold pairFold ctx with
  | .none => .none
  | .some ctx' =>
      o2.fold? opFold pairFold ctx'
#print Expr.fold?.match_3

theorem Expr.fold?_succeeds_implies_ret_exists
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (evalctx evalctx' : EvalContext kindMotive)
  (e : Expr ek)
  (SUCCESS: .some evalctx' = e.fold? opFold pairFold evalctx):
  { val: kindMotive e.retKind // evalctx'.lookupByKind e.retVar e.retKind = .some val } := by {
    revert evalctx' evalctx;
    induction e <;> intros evalctx evalctx' SUCCESS;
    case assign i o ret kind arg => {
      simp[fold?] at *;
      simp[EvalContext.lookupByKind] at *;
      -- | TODO: @chris: how to avoid nesting?
      cases ARG_VAL:(evalctx arg) <;> simp[ARG_VAL] at SUCCESS; case some arg_val => {
        by_cases ARG_VAL_FST:(i = arg_val.fst); case neg => {aesop; }; case pos => {
            subst ARG_VAL_FST; simp at *;
            cases RET_VAL:(evalctx ret) <;> simp[RET_VAL] at SUCCESS; case none => {
              simp[SUCCESS, EvalContext.bind];
                aesop_subst SUCCESS;
                apply Subtype.mk;
                apply Eq.refl;
            }
        }
      }
    }
    case pair ret arg1 kind1 arg2 kind2 => {
      simp[fold?] at *;
      simp[EvalContext.lookupByKind] at *;
      cases ARG1_VAL:(evalctx arg1) <;> simp[ARG1_VAL] at SUCCESS;
      case some arg1_val => {
       by_cases ARG1_KIND:(kind1 = arg1_val.fst); case neg => { aesop }; case pos => {
        subst ARG1_KIND; simp at SUCCESS;
          cases ARG2_VAL:(evalctx arg2) <;> simp[ARG2_VAL] at SUCCESS;
          case some arg2_val => {
            by_cases ARG2_KIND:(kind2 = arg2_val.fst); case neg => { aesop }; case pos => {
              subst ARG2_KIND; simp at SUCCESS;
              cases RET_VAL:(evalctx ret) <;> simp[RET_VAL] at SUCCESS; case none => {
                simp[SUCCESS];
                rw[retVar];
                simp[EvalContext.bind];
                aesop;
              }
            }
          }
        }
      }
    }
    case ops op1 op2 IH1 IH2 => {
      simp[fold?] at *;
      cases OP1_VAL:(fold? (fun {i o} => opFold) (fun {i i'} => pairFold) evalctx op1) <;>
      simp[OP1_VAL] at SUCCESS; case some op1_val => {
          cases OP2_VAL:(fold? (fun {i o} => opFold) (fun {i i'} => pairFold) op1_val op2) <;>
          simp[OP2_VAL] at SUCCESS; case some op2_val => {
            rw[retVar];
            subst SUCCESS;
            specialize (IH2 _ _ (Eq.symm OP2_VAL));
            rw[retKind];
            exact IH2;
          }
        }
    }
}



-- 'fold?' will return a 'some' value
-- Note that here, we must ford DEFCTX, since to perform induction on 'wellformed',
-- we need the indexes of 'wellformed' to be variables.
theorem Expr.fold?_succeeds_if_expr_wellformed
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {evalctx : EvalContext kindMotive}
  {defctx defctx': TypingContext}
  (DEFCTX: evalctx.toTypingContext = defctx)
  {e : Expr ek}
  (WF: ExprWellTyped defctx e defctx') :  ∃ evalctx',
  (e.fold? opFold pairFold evalctx = .some evalctx') ∧
  (evalctx'.toTypingContext = defctx') := by {
    revert evalctx;
    induction WF;
    case assign i o ret arg evalctx_defctx name ARG RET => {
      intros evalctx EVALCTX_DEFCTX;
      have ⟨arg_val, ARG_VAL⟩ := EvalContext.toTypingContext.preimage_some EVALCTX_DEFCTX ARG;
      have RET_VAL := EvalContext.toTypingContext.preimage_none EVALCTX_DEFCTX RET;
      simp[fold?] at *;
      simp[EvalContext.lookupByKind] at *;
      simp[ARG_VAL];
      simp[RET_VAL];
      apply EvalContext.toTypingContext.bind EVALCTX_DEFCTX;
    }
    case pair defctx  ret arg1 arg2 k1 k2 ARG1 ARG2 RET  => {
      intros evalctx EVALCTX_DEFCTX;
      have ⟨arg1_val, ARG1_VAL⟩ := EvalContext.toTypingContext.preimage_some EVALCTX_DEFCTX ARG1;
      have ⟨arg2_val, ARG2_VAL⟩ := EvalContext.toTypingContext.preimage_some EVALCTX_DEFCTX ARG2;
      have RET_VAL := EvalContext.toTypingContext.preimage_none EVALCTX_DEFCTX RET;
      simp[fold?];
      simp[EvalContext.lookupByKind, ARG1_VAL, ARG2_VAL, RET_VAL];
      apply EvalContext.toTypingContext.bind EVALCTX_DEFCTX;
    }
    case ops op ops ctxbegin ctxend ctxmid WF_OP WF_OPS IH1 IH2 => {
      intros evalctx EVALCTX_DEFCTX;
      simp[fold?];
      obtain ⟨evalctx1, EVALCTX1, EVALCTX1_DEFCTX⟩ := IH1 EVALCTX_DEFCTX;
      simp[EVALCTX1];
      obtain ⟨evalctx2, EVALCTX2, EVALCTX2_DEFCTX⟩ := IH2 EVALCTX1_DEFCTX;
      simp[EVALCTX2];
      apply EVALCTX2_DEFCTX;
    }
}

-- 'Expr.fold?' returns a value that 'isSome' if the expression is well formed.
theorem Expr.fold?_isSome_if_expr_wellformed
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {evalctx : EvalContext kindMotive}
  (DEFCTX: evalctx.toTypingContext = defctx)
  {e : Expr ek}
  (WF: Σ defctx', ExprWellTyped defctx e defctx') :
  (e.fold? opFold pairFold evalctx).isSome := by{
    rcases WF with ⟨defctx', WF⟩;
    obtain ⟨evalctx', EVALCTX', EVALCTX_DEFCTX'⟩ := Expr.fold?_succeeds_if_expr_wellformed DEFCTX WF;
    simp[Option.isSome];
    rw[EVALCTX'];
}


abbrev ExprEval.compute? {kindMotive: Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (e: Expr ek) (ctx: EvalContext kindMotive) : Option (EvalContext kindMotive) :=
  e.fold? opFold pairFold ctx


theorem ExprEval.prop_implies_compute?
  {kindMotive: Kind → Type}
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {ctx: EvalContext kindMotive}
  {e: Expr ek}
  {ctx': EvalContext kindMotive}
  (PROP: ExprEval opFold pairFold ctx e ctx'):
  ExprEval.compute? opFold pairFold e ctx = .some ctx' := by {
    induction PROP;
    case assign ctx_assign i o ret opkind arg argv ARG RET => {
      simp[ExprEval.compute?,Expr.fold?,ARG, RET];
    }
    case pair ctx1 ret arg1 arg2 k1 k2 v1 v2 ARG1 ARG2 RET => {
      simp[ExprEval.compute?,Expr.fold?, ARG1, ARG2, RET];
    }
    case ops ctxbegin ctxmid ctxend  op ops EVAL_OP EVAL_OPS IH_OP IH_OPS => {
      simp[ExprEval.compute?,Expr.fold?] at *;
      simp[IH_OP, IH_OPS];
    }
  }

theorem ExprEval.deterministic
  {kindMotive: Kind → Type}
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {ctx: EvalContext kindMotive}
  {e: Expr ek}
  {ctx1 ctx2: EvalContext kindMotive}
  (PROP1: ExprEval opFold pairFold ctx e ctx1)
  (PROP2: ExprEval opFold pairFold ctx e ctx2):
  ctx1 = ctx2 := by {
    have COMPUTE1 := ExprEval.prop_implies_compute? PROP1;
    have COMPUTE2 := ExprEval.prop_implies_compute? PROP2;
    rw[COMPUTE1] at COMPUTE2;
    injection COMPUTE2 with EQ;
 }

theorem ExprEval.compute?_implies_prop
  {kindMotive: Kind → Type}
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {ctx: EvalContext kindMotive}
  {e: Expr ek}
  {ctx': EvalContext kindMotive}
  (COMPUTE: ExprEval.compute? opFold pairFold e ctx = .some ctx'):
    ExprEval opFold pairFold ctx e ctx' := by {
      revert ctx ctx';
      induction e <;> intros ctx ctx' COMPUTE;
      case assign i o ret opkind arg => {
        simp[compute?, Expr.fold?] at COMPUTE;
        cases ARG: ctx.lookupByKind arg i <;> simp [ARG] at COMPUTE; case some arg => {
          cases RET:ctx ret <;> simp[RET] at COMPUTE; case none => {
            apply ExprEval.mk_assign (ARG := ARG) (RET := RET) (CTX' := Eq.symm COMPUTE);
          }
        }
      }
      case pair ret arg1 k1 arg2 k2 => {
        simp[compute?, Expr.fold?] at COMPUTE;
        cases ARG1: ctx.lookupByKind arg1 k1 <;> simp [ARG1] at COMPUTE; case some arg1 => {
          cases ARG2: ctx.lookupByKind arg2 k2 <;> simp [ARG2] at COMPUTE; case some arg2 => {
            cases RET:ctx ret <;> simp[RET] at COMPUTE; case none => {
              apply ExprEval.mk_pair (ARG1 := ARG1) (ARG2 := ARG2) (RET := RET) (CTX' := Eq.symm COMPUTE);
            }
          }
        }
      }
      case ops op ops IH_OP IH_OPS => {
        simp[compute?, Expr.fold?] at IH_OP IH_OPS COMPUTE;
        cases EVAL_OP: op.fold? opFold pairFold ctx <;> simp[EVAL_OP] at COMPUTE; case some ctxmid => {
          cases EVAL_OPS: ops.fold? opFold pairFold ctxmid <;> simp[EVAL_OPS] at COMPUTE; case some ctxend => {
            apply ExprEval.mk_ops (EVAL_OP := IH_OP EVAL_OP) (EVAL_OPS := IH_OPS EVAL_OPS) (CTX' := Eq.symm COMPUTE);
          }
        }
      }
  }

-- If `ExprEval ctx e ctx'` holds, then `ctx` is well typed
theorem ExprEval.well_typed
  {kindMotive: Kind → Type}
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {ctx: EvalContext kindMotive}
  {e: Expr ek}
  {ctx': EvalContext kindMotive}
  (PROP: ExprEval opFold pairFold ctx e ctx') :
  ExprWellTyped ctx.toTypingContext e ctx'.toTypingContext := by sorry



end ExprFoldExtraction

-- ERROR: IR check failed at 'Expr.fold', error: unknown declaration EvalContext.toTypingContext.preimage_
def Expr.fold
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {evalctx : EvalContext kindMotive}
  {e : Expr ek}
  {defctx defctx' : TypingContext}
  (DEFCTX: evalctx.toTypingContext = defctx)
  (WF: ExprWellTyped defctx e defctx') :
  Σ (evalctx' : EvalContext kindMotive), ExprEval opFold pairFold evalctx e evalctx'  :=
  match ek, e, WF with
  | .O, .assign (i := i) (o := o)  ret ekind arg, .assign ARG RET =>
    let ⟨arg_val, ARG_VAL⟩ := EvalContext.toTypingContext.preimage_some DEFCTX ARG;
    let evalctx' := evalctx.bind ret o (opFold ekind arg_val);
    { fst := evalctx',
      snd := ExprEval.mk_assign
                (opFold := opFold)
                (pairFold := pairFold)
                (ARG := EvalContext.lookupByKind_lookup_some ARG_VAL)
                (RET := EvalContext.toTypingContext.preimage_none (DCTX := DEFCTX) RET)
                (CTX' := rfl) }
  | .O, .pair ret arg1 k1 arg2 k2, .pair ARG1 ARG2 RET =>
      let ⟨arg1_val, ARG1_VAL⟩ := EvalContext.toTypingContext.preimage_some DEFCTX ARG1;
      let ⟨arg2_val, ARG2_VAL⟩ := EvalContext.toTypingContext.preimage_some DEFCTX ARG2;
      let evalctx' := evalctx.bind ret (Kind.pair k1 k2) (pairFold arg1_val arg2_val);
      { fst := evalctx',
        snd := ExprEval.mk_pair
                    (opFold := opFold)
                    (pairFold := pairFold)
                    (ARG1 := EvalContext.lookupByKind_lookup_some ARG1_VAL)
                    (ARG2 := EvalContext.lookupByKind_lookup_some ARG2_VAL)
                    (RET := EvalContext.toTypingContext.preimage_none (DCTX := DEFCTX) RET)
                    (CTX' := rfl) }
  | .Os, .ops op ops', .ops (ctxmid := ctxmid) (ctxend := ctxend) OP OPS =>
      let ⟨ectxmid, ECTXMID⟩ := Expr.fold opFold pairFold DEFCTX OP;
      let defctx1 := ectxmid.toTypingContext;
      let DEFCTX1 : ectxmid.toTypingContext = defctx1 := rfl;
      /-
      since we have:
       WellTyped[defctx; op; ctxmid]
      as well as:
        ExprEval[evalctx; op; ectxmid],
      we derive:
          WellTyped[evalctx.toTypingContext; op; ectxmid.toTypingContext]
      but since WellTyped is deterministic, we can derive:
          ectxmid.toTypingContext = ctxmid
      from this, we can continue to evaluate `OPS`, since we now know that:
        1. ectxmid.toTypingContext = ctxmid
        2. ExprWellTyped ctxmid ops' ctxend
        ie, we know that 'evalctxmid' corresponds to the well typed IH about ctxmid.

      -/
      let WELLTYPED_ECTX : ExprWellTyped defctx op (EvalContext.toTypingContext ectxmid) := DEFCTX ▸ ECTXMID.well_typed;
      let DEFCTX_MID : ectxmid.toTypingContext = ctxmid :=
        ExprWellTyped.deterministic WELLTYPED_ECTX OP;
      let ⟨evalctx2, EVALCTX2⟩ := Expr.fold opFold pairFold DEFCTX_MID OPS;
      { fst := evalctx2,
        snd := ExprEval.mk_ops (EVAL_OP := ECTXMID) (EVAL_OPS := EVALCTX2) (CTX' := rfl) }


-- Expression tree which produces a value of kind 'Kind'.
-- This is the initial algebra of the fold.
inductive Tree : Kind → Type where
| assign:  OpKind i o → Tree i → Tree o
| pair: Tree a → Tree b → Tree (Kind.pair a b)

-- Convert an expression to a tree by folding into the tree algebra
def Expr.toTree {ectx: EvalContext Tree} {ctx': TypingContext} (e : Expr ek)
  (WELLTYPED: ExprWellTyped ectx.toTypingContext e ctx'): Tree (e.retKind) :=
    (e.fold
        (opFold := fun opk ti => Tree.assign opk ti)
        (pairFold := fun  ti ti' => Tree.pair ti ti')
        (DEFCTX := rfl)
        (WF := WELLTYPED)).snd.extractResult

section Evaluation
/-
we define 'Expr.eval', 'Expr.toTree', and 'Tree.eval' and show that the diagram below commutes:
  Expr.eval = Tree.eval ∘ Expr.toTree
-/
variable (kindMotive: Kind → Type)
variable (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
variable (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))

def Tree.eval : Tree k → kindMotive k
| .assign opk ti => opFold opk ti.eval
| .pair ta tb =>
    pairFold ta.eval tb.eval

-- Convert a well typed 'Expr' into a tree
def Expr.eval {ectx : EvalContext kindMotive} {ctx': TypingContext}
  (WELLTYPED: ExprWellTyped ectx.toTypingContext e ctx'): kindMotive (e.retKind) :=
  (e.fold (opFold := opFold) (pairFold := pairFold) (WF := WELLTYPED) (DEFCTX := rfl)).snd.extractResult

-- the diagram commutes for closd terms: Expr.eval = Tree.eval ∘ Expr.toTree
theorem Tree.eval.sound_closed
  {ctx' : TypingContext}
  {ek: ExprKind}
  {e: Expr ek}
  (WELLTYPED_KIND: ExprWellTyped (@EvalContext.bottom kindMotive).toTypingContext  e ctx')
  (WELLTYPED_TREE: ExprWellTyped (@EvalContext.bottom Tree).toTypingContext  e ctx')
  : e.eval kindMotive opFold pairFold (WELLTYPED_KIND) =
      (e.toTree WELLTYPED_TREE).eval kindMotive opFold pairFold := by {
        cases WELLTYPED_KIND;
        case assign i o ret kind arg ARG RET => {
          cases WELLTYPED_TREE;
          case assign  ARG' RET' => {
            simp[Expr.eval, Expr.toTree, Expr.fold, ExprEval.extractResult, eval];
            sorry
          }
        }
        case pair => sorry
        case ops => sorry
}



end Evaluation

section OpenEvaluation


-- Expression tree which produces a value of kind 'Kind'.
-- This is the initial algebra of the fold.
inductive OpenTree (kindMotive: Kind → Type) : Kind → Type where
| assign:  OpKind i o → OpenTree kindMotive i → OpenTree kindMotive o
| pair: OpenTree kindMotive a → OpenTree kindMotive b → OpenTree kindMotive (Kind.pair a b)
| var: {k: Kind} → kindMotive k → OpenTree kindMotive k


def EvalContext.map
  {kindMotive: Kind → Type}
  {kindMotive': Kind → Type}
  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k) -- naturality.
  : EvalContext kindMotive → EvalContext kindMotive' :=
  fun ectx k => match ectx k with
    | .none => .none
    | .some ⟨k, vk⟩ => .some ⟨k, f vk⟩

/-
We need a way to transport well-typedness along evaluation context morphisms.
If we know that an expression is well typed, then we should be able to transport
it along a 'EvalContext.map' [which is yet to be defined.]
-/
def ExprWellTyped.transportAlongMap
 {kindMotive: Kind → Type}
 {kindMotive': Kind → Type}
  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k) -- naturality.
  {ectx: EvalContext kindMotive}
  {ek: ExprKind}
  {e: Expr ek}
  {ctx': TypingContext}
  (WELLTYPED: ExprWellTyped ectx.toTypingContext e ctx')
  : ExprWellTyped (ectx.map f).toTypingContext e ctx' := sorry


-- Convert an expression to a tree by folding into the tree algebra
def Expr.toOpenTree {ectx: EvalContext kindMotive} {ctx': TypingContext} (e : Expr ek)
  (WELLTYPED: ExprWellTyped ectx.toTypingContext e ctx'): OpenTree kindMotive (e.retKind) :=
    (e.fold
        (opFold := fun opk ti => OpenTree.assign opk ti)
        (pairFold := fun  ti ti' => OpenTree.pair ti ti')
        (DEFCTX := rfl)
        (WF := WELLTYPED.transportAlongMap OpenTree.var)).snd.extractResult

-- the diagram commutes for open terms: Expr.eval = OpenTree.eval ∘ Expr.toOpenTree
-- for open terms, we need to add variables to our trees.

theorem OpenTree.eval.sound_open : Type := sorry

end OpenEvaluation

-- Annoying, this does not help, since it does not let us talk about program fragments.
-- In theory, we could say that we have some kind of input
