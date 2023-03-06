-- We create a verified conversion from SSA minus Regions (ie, a sequence
-- of let bindings) into an expression tree. We prove that this
-- conversion preserves program semantics.
import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Function
import Mathlib.Data.Set.Image
import Aesop

def Sigma.mapRight {T: Type} {f f': T → Type} (map: ∀ {t: T}, f t → f' t):
  (Σ (a: T), f a) → Σ (a: T), f' a :=
  fun ⟨a, fa⟩ => ⟨a, map fa⟩


namespace ToTree

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


inductive Expr : ExprKind → Kind → Type where
| assign (ret : Var) (kind: OpKind i o) (arg: Var) : Expr .O o -- ret = kind (arg)
| pair (ret : Var) (arg1: Var) (k1: Kind) (arg2 : Var) (k2: Kind) : Expr .O (Kind.pair k1 k2) -- ret = (arg1, arg2)
| ops: Expr .O kop → Expr .Os ks → Expr .Os ks -- op ;; ops.

-- the return variable of the expression. ie, what is the
-- name of the final value that this expression computes.
abbrev Expr.retVar : Expr ek k → Var
| .assign (ret := ret) .. => ret
| .pair (ret := ret)  .. => ret
| .ops _ o2 => o2.retVar

abbrev Op := Expr .O
abbrev Ops := Expr .Os

abbrev Op.retKind: Op k → Kind := fun _ => k

-- builder helpers
@[match_pattern]
abbrev Op.assign (ret : Var) (kind : OpKind i o) (arg : Var) : Op o :=
  Expr.assign ret kind arg

@[match_pattern]
abbrev Op.pair (ret : Var) (arg1 : Var) (k1: Kind) (arg2: Var) (k2: Kind) : Op (Kind.pair k1 k2) :=
  Expr.pair ret arg1 k1 arg2 k2

abbrev Op.ret : Expr .O k → String
| .pair (ret := ret) .. => ret
| .assign (ret := ret) .. => ret


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


Key insight: Do not phrase it as a function that returns a context, phrase it
as a relation between a context and an expression. This forces us to be "productive"
in the case where we concatenate two expressions. This means that we get stronger
induction hypotheses. Furthermore, this is morally the correct way to think about the
situation. We are not "returning" a context, we "have" a context to define well typedness.
This solves the entire collection of problems around showing that we return a context
deterministically and so on.
-/
-- inductive propsition which asserts when an expression is well formed.
inductive ExprWellTyped : {ek: ExprKind} → {k: Kind} → TypingContext → Expr ek k →  Type where
| assign
    {ret arg : Var}
    {ctx : TypingContext}
    {kind: OpKind i o}
    (ARG : ctx arg = .some i)
    (RET: ctx ret = .none) :
    ExprWellTyped ctx (Op.assign ret kind arg)
| pair
  {ctx : TypingContext}
  {ret arg1 arg2 : Var}
  {k1 k2 : Kind}
  (ARG1 : ctx arg1 = .some k1)
  (ARG2 : ctx arg2 = .some k2)
  (RET: ctx ret = .none) :
  ExprWellTyped ctx (Op.pair ret arg1 k1 arg2 k2)
| ops
  {ctxbegin : TypingContext}
  (op1: Op k)
  (op2: Ops ks)
  (WT1: ExprWellTyped ctxbegin op1)
  (WT2: ExprWellTyped (ctxbegin.bind op1.retVar k) op2) :
  ExprWellTyped ctxbegin (Expr.ops op1 op2)



-- forded version of `assign` that allows an arbitrary `ctx'`, while stipuating
-- what conditions `ctx'` needs to satisfy
@[simp]
def ExprWellTyped.mk_assign
  {kind : OpKind i o}
  (ARG: ctx arg = .some i)
  (RET: ctx ret = .none)
  : ExprWellTyped ctx (Op.assign ret kind arg) :=
    (ExprWellTyped.assign ARG RET) -- @chris: is this evil?

-- forded version of `pair` that allows an arbitrary `ctx'`, while stipuating
-- what conditions `ctx'` needs to satisfy
@[simp]
def ExprWellTyped.mk_pair
  {k1 k2: Kind}
  (ARG1: ctx arg1 = .some k1)
  (ARG2: ctx arg2 = .some k2)
  (RET: ctx ret = .none)
  : ExprWellTyped ctx (Op.pair ret arg1 k1 arg2 k2) :=
    (ExprWellTyped.pair ARG1 ARG2 RET) -- @chris: is this evil?

-- inversion theorems for 'ExprWellTyped'
def ExprWellTyped.assign_inv {ctx : TypingContext} {ret arg : Var} {kind: OpKind i o}
  (WT: ExprWellTyped ctx (Op.assign ret kind arg)):
  ctx arg = .some i ∧ ctx ret = .none  :=
  match WT with
  | ExprWellTyped.assign ARG RET => ⟨ARG, RET⟩

def ExprWellTyped.pair_inv {ctx : TypingContext} {ret arg1 arg2 : Var} {k1 k2 : Kind}
  (WT: ExprWellTyped ctx (Op.pair ret arg1 k1 arg2 k2)) :
  ctx arg1 = .some k1 ∧ ctx arg2 = .some k2 ∧ ctx ret = .none :=
  match WT with
  | ExprWellTyped.pair ARG1 ARG2 RET => ⟨ARG1, ARG2, RET⟩



-- computational version of 'ExpreWellFormed' for reflection.
def ExprWellTyped.compute : Expr ek k → TypingContext → Bool
| (.assign (i := i) (o := o) ret _kind arg), ctx =>
    if ctx ret ≠ .none
    then false
    else if ctx arg ≠ i
    then false
    else true
| (.pair ret arg1 k1 arg2 k2), ctx =>
    if ctx ret ≠ .none then false
    else if ctx arg1 ≠ k1 then false
    else if ctx arg2 ≠ k2 then false
    else true
| (Expr.ops op1 op2 (kop := kop)), ctx =>
    match ExprWellTyped.compute op1 ctx with
    | false => false
    | true => ExprWellTyped.compute op2 (ctx.bind op1.retVar kop)

-- completeness: if the inducitve propositoin holds, then the decision
-- procedure says yes.
theorem ExprWellTyped.prop_implies_compute:
  ∀ {ctx } {expr : Expr ek k},
  ExprWellTyped ctx expr -> @ExprWellTyped.compute ek k expr ctx := by {
  intros ctx expr;
  revert ctx;
  induction expr;
  case assign ret kind arg => {
    intros ctx WELLFORMED;
    cases WELLFORMED;
    case assign RET ARG => {
      simp[compute]; aesop;
    }
  }
  case pair ret arg1 arg2 => {
    intros ctx WELLFORMED;
    cases WELLFORMED;
    case pair RET ARG1 ARG2 => {
      simp[compute]; aesop;
    }
  }
  case ops kop kops op1 ops IH_OP IH_OPS => {
    intros ctx WELLFORMED;
    cases WELLFORMED;
    case ops WT_OP WT_OPS => {
      simp[compute];
      simp[IH_OP WT_OP];
      simp[IH_OPS WT_OPS];
    }
  }
}


instance : Subsingleton (@ExprWellTyped ek k ctx op) :=
 ⟨fun wf1 wf2 => by {
    induction wf1;
    case assign i o ret arg ctx kind ARG RET => {
      cases wf2; simp[proofIrrel];
    };
    case pair ret arg1 arg2 k1 k2 ARG1 ARG2 RET => {
      cases wf2; simp[proofIrrel];
    };
    case ops op' ops' ctxbegin ctxend ctxmid WT_OP WT_OPS IH_OP IH_OPS => {
      cases wf2;
      case ops  WT_OP' WT_OPS' => {
        -- Need a theorem that ExprWellTyped returns a deterministic "ctx'"
        have IH_OP' := IH_OP WT_OP';
        have IH_OPS' := IH_OPS WT_OPS';
        simp[proofIrrel];
        constructor <;> assumption;
      }
    }
  }
⟩

-- -- (compute = true) => (stuff holds)
-- theorem ExprWellTyped.compute_implies_prop:
--   ∀ {ctx : TypingContext} {expr : Expr ek k},
--   ExprWellTyped.compute expr ctx ->
--   ExprWellTyped ctx expr := by {
--   intros ctx expr;
--   revert ctx;
--   induction expr;
--   case assign ret kind arg => {
--     intros ctx COMPUTE;
--     simp[compute] at COMPUTE;
--     apply ExprWellTyped.mk_assign <;> aesop;
--   }
--   case pair ret arg1 arg2 => {
--     intros ctx COMPUTE;
--     simp[compute] at COMPUTE;
--     apply ExprWellTyped.mk_pair <;> aesop;
--   }
--   case ops o1 o2 IH1 IH2 => {
--     intros ctx  COMPUTE;
--     simp[compute] at COMPUTE;
--     cases CTXO1:(compute o1 ctx) <;> simp[CTXO1] at COMPUTE; case some ctx' => {
--       cases CTXO2:(compute o2 ctx') <;> simp[CTXO2] at COMPUTE; case some ctx''_2 => {
--         subst COMPUTE;
--         apply ExprWellTyped.ops (ctxmid := ctx') <;> aesop;
--       }
--     }
--   }
-- }



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
theorem EvalContext.lookupByKind_lookup_some_ {kindMotive: Kind → Type} {evalctx: EvalContext kindMotive}
  {k: Kind} {v: kindMotive k} {name: String}
  (LOOKUP: evalctx name = some { fst := k, snd := v }) :
  (evalctx.lookupByKind name k = .some v) := by {
    simp[EvalContext.lookupByKind, LOOKUP];
  }

-- Simplify `lookupByKind` when we have a syntactically
-- matching `lookup`result.
theorem EvalContext.lookupByKind_lookup_some_inv {kindMotive: Kind → Type} {evalctx: EvalContext kindMotive}
  {k: Kind} {v: kindMotive k} {name: String}
  (LOOKUP: evalctx.lookupByKind name k = .some v) :
  evalctx name = some { fst := k, snd := v } := by {
    simp[EvalContext.lookupByKind, LOOKUP] at LOOKUP ⊢;
    cases VAL:(evalctx name) <;> simp[VAL] at LOOKUP;
    case some kv => {
      have ⟨k', v'⟩ := kv;
      simp at LOOKUP;
      by_cases K_EQ:(k = k') <;> simp[K_EQ] at LOOKUP;
      case pos => {
        subst K_EQ;
        simp at LOOKUP ⊢;
        exact LOOKUP;
      }
    }
  }

theorem EvalContext.lookupByKind_lookup_some {kindMotive: Kind → Type} {evalctx: EvalContext kindMotive}
  {k: Kind} {v: kindMotive k} {name: String} :
  (evalctx name = some { fst := k, snd := v }) ↔ (evalctx.lookupByKind name k = .some v) where
  mp := EvalContext.lookupByKind_lookup_some_
  mpr := EvalContext.lookupByKind_lookup_some_inv




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
Showing that a value can be extracted out of Expr.eval?
whenever the expr is well formed.
-/

-- If 'dctx' has a value at 'name', then so does 'ectx' at 'name' if
-- 'dctx' came from 'ectx'.
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

-- Same as EvalContext.toTypingContext.preimage_some, without the fording on 'dctx'
def EvalContext.toTypingContext_preimage_some'
  { kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {kind : Kind}
  (LOOKUP: ectx.toTypingContext name = .some kind) :
  { val : kindMotive kind // ectx name = .some ⟨kind, val⟩ } := by {
    simp[toTypingContext] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩ <;> aesop;
}

def EvalContext.toTypingContext_preimage_lookupByKind_some'
  { kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {kind : Kind}
  (LOOKUP: ectx.toTypingContext name = .some kind) :
  { val : kindMotive kind // ectx.lookupByKind name kind = .some val } := by {
    simp[toTypingContext, lookupByKind] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩;
    case none => { simp[H] at LOOKUP; }
    case some.mk => {
      simp only [H, Option.some.injEq] at LOOKUP;
      subst LOOKUP;
      apply (Subtype.mk val_val);
      simp[lookupByKind, H];
    }

}




theorem EvalContext.toTypingContext_preimage_none
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
-- Same as `EvalContext.toTypingContext_preimage_none`, without the fording on 'dctx'
theorem EvalContext.toTypingContext_preimage_none'
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  (LOOKUP: ectx.toTypingContext name = .none) :
  ectx name = .none := by {
    simp[toTypingContext] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩ <;> aesop;
}

def EvalContext.toTypingContext_preimage_lookupByKind_none'
  { kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {kind : Kind}
  (LOOKUP: ectx.toTypingContext name = .none) :
  ectx.lookupByKind name kind = .none := by {
    simp[toTypingContext] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩ <;> simp[H] at LOOKUP;
    simp[lookupByKind, H, LOOKUP]
}




-- ((name, kind, val) :: evalctx).toTypingContext = (name, kind) :: evalctx.toTypingContext
-- Alternatively, 'toTypingContext' is a homomorphism of contexts.
theorem EvalContext.toTypingContext_bind
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {dctx: TypingContext}
  (DCTX: EvalContext.toTypingContext ectx = dctx)
  {kind : Kind}
  {val: kindMotive kind}
  {arg: String} :
  (EvalContext.bind arg kind val ectx).toTypingContext = TypingContext.bind arg kind dctx := by {
    funext key;
    simp[toTypingContext, TypingContext.bind, EvalContext.bind];
    by_cases NAME:(key = arg) <;> simp[NAME];
    case neg => {
      simp[NAME];
      simp[toTypingContext];
      cases DCTX_KEY:(dctx key);
      case none => {
        have ECTX_KEY := EvalContext.toTypingContext_preimage_none DCTX DCTX_KEY;
        simp[ECTX_KEY];
      }
      case some => {
        have ⟨ectx_val, ECTX_KEY⟩:= EvalContext.toTypingContext.preimage_some DCTX DCTX_KEY;
        simp[ECTX_KEY];
      }
    }
}

/-  Expression evalation as a relation. -/
-- (kernel) arg #10 of 'ExprFold.ops' contains a non valid occurrence of the datatypes being declared
inductive ExprFold {kindMotive : Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')) :
  (EvalContext kindMotive) → Expr ek k → (EvalContext kindMotive) → Type where
  | assign {ctx: EvalContext kindMotive}
    {i o : Kind}
    {ret: String}
    {opkind: OpKind i o}
    {arg: String}
    {argv: kindMotive i}
    (ARG: ctx.lookupByKind arg i = .some argv)
    (RET: ctx ret = .none)
    : ExprFold opFold pairFold ctx (Op.assign ret opkind arg) (ctx.bind ret o (opFold opkind argv))
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
    : ExprFold opFold pairFold ctx (Op.pair ret arg1 k1 arg2 k2) (ctx.bind ret (Kind.pair k1 k2) (pairFold v1 v2))
  | ops
    {ctxbegin: EvalContext kindMotive} (ctxmid: EvalContext kindMotive)
    {ctxend: EvalContext kindMotive}
    {op: Expr .O k}
    {ops: Expr .Os ks}
    (EVAL_OP: @ExprFold kindMotive @opFold @pairFold .O k ctxbegin op ctxmid)
    (EVAL_OPS: @ExprFold kindMotive @opFold @pairFold .Os ks ctxmid ops ctxend)
    : ExprFold opFold pairFold ctxbegin (Expr.ops op ops) ctxend


-- forded version of 'ExprFold.assign' that allows any `ctx'`, with a hypothesis
-- that `ctx'` needs to satisfy.
@[simp]
def ExprFold.mk_assign
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
  : ExprFold opFold pairFold ctx (Op.assign ret opkind arg) ctx' :=
  by { subst CTX'; apply ExprFold.assign ARG RET }

-- forded version of 'ExprFold.pair'
@[simp]
def ExprFold.mk_pair
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
  : ExprFold opFold pairFold ctx (Op.pair ret arg1 k1 arg2 k2) ctx' :=
  by { subst CTX'; apply ExprFold.pair ARG1 ARG2 RET }

@[simp]
def ExprFold.mk_ops
  {kindMotive: Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ctxbegin: EvalContext kindMotive} (ctxmid: EvalContext kindMotive)
  {ctxend: EvalContext kindMotive}
  {op: Expr .O k}
  {ops: Expr .Os ks}
  (EVAL_OP: @ExprFold kindMotive @opFold @pairFold .O k ctxbegin op ctxmid)
  (EVAL_OPS: @ExprFold kindMotive @opFold @pairFold .Os ks ctxmid ops ctxend)
  (ctx': EvalContext kindMotive)
  (CTX': ctx' = ctxend)
  : ExprFold opFold pairFold ctxbegin (Expr.ops op ops) ctx' :=
  by { subst CTX'; apply ExprFold.ops (ctxmid := ctxmid) EVAL_OP EVAL_OPS; }


-- if we have `ExprFold[ctx op ctx']` then we can extract the result of the operation `op` from `ctx'`.
def ExprFold.extractResult
  {kindMotive: Kind → Type}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ctx : EvalContext kindMotive}
  {ek: ExprKind} {k: Kind} {e: Expr ek k}
  {ctx': EvalContext kindMotive}
  (EVAL: ExprFold opFold pairFold ctx e ctx') :
  kindMotive k :=
  match EVAL with
  | .assign (opkind := opkind) (argv := argv) .. =>   opFold opkind argv
  |  .pair (v1 := v1) (v2 := v2) .. => pairFold v1 v2
  | @ExprFold.ops (ops := rest) (EVAL_OPS := EVAL_OPS) .. =>
      (ExprFold.extractResult opFold pairFold EVAL_OPS : kindMotive k)


def Expr.eval? -- version of fold that returns option.
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ctx : EvalContext kindMotive): (e : Expr ek k) → Option (kindMotive k)
| .assign (i := i) (o := o) ret opkind arg =>
    match ctx.lookupByKind arg i with
    | .none => .none
    | .some argv =>
        match ctx ret with
        | .some _ => .none
        | .none => opFold opkind argv

| .pair ret arg1 k1 arg2 k2 =>
  match ctx.lookupByKind arg1 k1, ctx.lookupByKind arg2 k2 with
    | .some arg1v, .some arg2v =>
      match ctx ret with
      | .some _ => .none
      | .none => pairFold arg1v arg2v
    | _, _ => .none
| .ops o1 o2 (kop := kop)=>
  match o1.eval? opFold pairFold ctx with
  | .none => .none
  | .some v =>  o2.eval? opFold pairFold (ctx.bind o1.retVar kop v)

-- theorem Expr.eval?_succeeds_implies_ret_exists
--   {kindMotive: Kind → Type} -- what each kind is compiled into.
--   (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
--   (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
--   (evalctx evalctx' : EvalContext kindMotive)
--   (e : Expr ek k)
--   (SUCCESS: .some evalctx' = e.eval? opFold pairFold evalctx):
--   { val: kindMotive e.retKind // evalctx'.lookupByKind e.retVar e.retKind = .some val } := by {
--     revert evalctx' evalctx;
--     induction e <;> intros evalctx evalctx' SUCCESS;
--     case assign i o ret kind arg => {
--       simp[eval?] at *;
--       simp[EvalContext.lookupByKind] at *;
--       -- | TODO: @chris: how to avoid nesting?
--       cases ARG_VAL:(evalctx arg) <;> simp[ARG_VAL] at SUCCESS; case some arg_val => {
--         by_cases ARG_VAL_FST:(i = arg_val.fst); case neg => {aesop; }; case pos => {
--             subst ARG_VAL_FST; simp at *;
--             cases RET_VAL:(evalctx ret) <;> simp[RET_VAL] at SUCCESS; case none => {
--               simp[SUCCESS, EvalContext.bind];
--                 aesop_subst SUCCESS;
--                 apply Subtype.mk;
--                 apply Eq.refl;
--             }
--         }
--       }
--     }
--     case pair ret arg1 kind1 arg2 kind2 => {
--       simp[eval?] at *;
--       simp[EvalContext.lookupByKind] at *;
--       cases ARG1_VAL:(evalctx arg1) <;> simp[ARG1_VAL] at SUCCESS;
--       case some arg1_val => {
--        by_cases ARG1_KIND:(kind1 = arg1_val.fst); case neg => { aesop }; case pos => {
--         subst ARG1_KIND; simp at SUCCESS;
--           cases ARG2_VAL:(evalctx arg2) <;> simp[ARG2_VAL] at SUCCESS;
--           case some arg2_val => {
--             by_cases ARG2_KIND:(kind2 = arg2_val.fst); case neg => { aesop }; case pos => {
--               subst ARG2_KIND; simp at SUCCESS;
--               cases RET_VAL:(evalctx ret) <;> simp[RET_VAL] at SUCCESS; case none => {
--                 simp[SUCCESS];
--                 rw[retVar];
--                 simp[EvalContext.bind];
--                 aesop;
--               }
--             }
--           }
--         }
--       }
--     }
--     case ops op1 op2 _IH1 IH2 => {
--       simp[eval?] at *;
--       cases OP1_VAL:(eval? (fun {i o} => opFold) (fun {i i'} => pairFold) evalctx op1) <;>
--       simp[OP1_VAL] at SUCCESS; case some op1_val => {
--           cases OP2_VAL:(eval? (fun {i o} => opFold) (fun {i i'} => pairFold) op1_val op2) <;>
--           simp[OP2_VAL] at SUCCESS; case some op2_val => {
--             rw[retVar];
--             subst SUCCESS;
--             specialize (IH2 _ _ (Eq.symm OP2_VAL));
--             rw[retKind];
--             exact IH2;
--           }
--         }
--     }
-- }



-- 'eval?' will return a 'some' value
-- Note that here, we must ford DEFCTX, since to perform induction on 'wellformed',
-- we need the indexes of 'wellformed' to be variables.
theorem Expr.eval?_succeeds_if_expr_wellformed
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {evalctx : EvalContext kindMotive}
  (DEFCTX: evalctx.toTypingContext = defctx)
  {e : Expr ek k}
  (WT: ExprWellTyped defctx e) :
  { out // (e.eval? opFold pairFold evalctx = .some out) } := by {
    revert evalctx;
    induction WT;
    case assign i o ret arg evalctx_defctx name ARG RET => {
      intros evalctx EVALCTX_DEFCTX;
      have ⟨arg_val, ARG_VAL⟩ := EvalContext.toTypingContext.preimage_some EVALCTX_DEFCTX ARG;
      have RET_VAL := EvalContext.toTypingContext_preimage_none EVALCTX_DEFCTX RET;
      simp[eval?] at *;
      simp[EvalContext.lookupByKind] at *;
      simp[ARG_VAL];
      simp[RET_VAL];
      apply Subtype.mk (opFold name arg_val);
      rfl
    }

    case pair defctx  ret arg1 arg2 k1 k2 ARG1 ARG2 RET  => {
      intros evalctx EVALCTX_DEFCTX;
      have ⟨arg1_val, ARG1_VAL⟩ := EvalContext.toTypingContext.preimage_some EVALCTX_DEFCTX ARG1;
      have ⟨arg2_val, ARG2_VAL⟩ := EvalContext.toTypingContext.preimage_some EVALCTX_DEFCTX ARG2;
      have RET_VAL := EvalContext.toTypingContext_preimage_none EVALCTX_DEFCTX RET;
      simp[eval?];
      simp[EvalContext.lookupByKind, ARG1_VAL, ARG2_VAL, RET_VAL];
      apply Subtype.mk (pairFold arg1_val arg2_val);
      rfl
      -- apply EvalContext.toTypingContext_bind EVALCTX_DEFCTX;
    }
    case ops op ops ctxbegin ctxend ctxmid _WT_OP _WT_OPS IH1 IH2 => {
      intros evalctx EVALCTX_DEFCTX;
      simp[eval?];

      obtain out1 := IH1 EVALCTX_DEFCTX;
      simp[out1.property];
      apply (@IH2 (EvalContext.bind (retVar ctxend) op out1 evalctx));
      apply EvalContext.toTypingContext_bind EVALCTX_DEFCTX;
    }
}

-- 'Expr.eval?' returns a value that 'isSome' if the expression is well formed.
theorem Expr.eval?_isSome_if_expr_wellformed
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {evalctx : EvalContext kindMotive}
  (DEFCTX: evalctx.toTypingContext = defctx)
  {e : Expr ek k}
  (WT: ExprWellTyped defctx e) :
  (e.eval? opFold pairFold evalctx).isSome := by {
    simp[Option.isSome];
    let val := Expr.eval?_succeeds_if_expr_wellformed DEFCTX WT (opFold := opFold) (pairFold := pairFold);
    simp[val.property];
}



-- theorem ExprFold.prop_implies_eval?
--   {kindMotive: Kind → Type}
--   {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
--   {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
--   {ctx: EvalContext kindMotive}
--   {e: Expr ek k}
--   {ctx': EvalContext kindMotive}
--   {v: kindMotive k}
--   (PROP: ExprFold opFold pairFold ctx e ctx'):
--   e.eval? opFold pairFold ctx = .some (ctx', v) := by {
--     induction PROP;
--     case assign ctx_assign i o ret opkind arg argv ARG RET => {
--       simp[Expr.eval?,ARG, RET];
--     }
--     case pair ctx1 ret arg1 arg2 k1 k2 v1 v2 ARG1 ARG2 RET => {
--       simp[Expr.eval?, ARG1, ARG2, RET];
--     }
--     case ops ctxbegin ctxmid ctxend  op ops EVAL_OP EVAL_OPS IH_OP IH_OPS => {
--       simp[Expr.eval?] at *;
--       simp[IH_OP, IH_OPS];
--     }
--   }

-- theorem ExprFold.deterministic
--   {kindMotive: Kind → Type}
--   {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
--   {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
--   {ctx: EvalContext kindMotive}
--   {e: Expr ek k}
--   {ctx1 ctx2: EvalContext kindMotive}
--   (PROP1: ExprFold opFold pairFold ctx e ctx1)
--   (PROP2: ExprFold opFold pairFold ctx e ctx2):
--   ctx1 = ctx2 := by {
--     have COMPUTE1 := ExprFold.prop_implies_eval? PROP1;
--     have COMPUTE2 := ExprFold.prop_implies_eval? PROP2;
--     rw[COMPUTE1] at COMPUTE2;
--     injection COMPUTE2 with EQ;
--  }

-- theorem ExprFold.eval?_implies_prop
--   {kindMotive: Kind → Type}
--   {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
--   {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
--   {ctx: EvalContext kindMotive}
--   {e: Expr ek}
--   {ctx': EvalContext kindMotive}
--   (COMPUTE: e.eval? opFold pairFold ctx = .some ctx'):
--     ExprFold opFold pairFold ctx e ctx' := by {
--       revert ctx ctx';
--       induction e <;> intros ctx ctx' COMPUTE;
--       case assign i o ret opkind arg => {
--         simp[Expr.eval?] at COMPUTE;
--         cases ARG: ctx.lookupByKind arg i <;> simp [ARG] at COMPUTE; case some arg => {
--           cases RET:ctx ret <;> simp[RET] at COMPUTE; case none => {
--             apply ExprFold.mk_assign (ARG := ARG) (RET := RET) (CTX' := Eq.symm COMPUTE);
--           }
--         }
--       }
--       case pair ret arg1 k1 arg2 k2 => {
--         simp[Expr.eval?] at COMPUTE;
--         cases ARG1: ctx.lookupByKind arg1 k1 <;> simp [ARG1] at COMPUTE; case some arg1 => {
--           cases ARG2: ctx.lookupByKind arg2 k2 <;> simp [ARG2] at COMPUTE; case some arg2 => {
--             cases RET:ctx ret <;> simp[RET] at COMPUTE; case none => {
--               apply ExprFold.mk_pair (ARG1 := ARG1) (ARG2 := ARG2) (RET := RET) (CTX' := Eq.symm COMPUTE);
--             }
--           }
--         }
--       }
--       case ops op ops IH_OP IH_OPS => {
--         simp[Expr.eval?] at IH_OP IH_OPS COMPUTE;
--         cases EVAL_OP: op.eval? opFold pairFold ctx <;> simp[EVAL_OP] at COMPUTE; case some ctxmid => {
--           cases EVAL_OPS: ops.eval? opFold pairFold ctxmid <;> simp[EVAL_OPS] at COMPUTE; case some ctxend => {
--             apply ExprFold.mk_ops (EVAL_OP := IH_OP EVAL_OP) (EVAL_OPS := IH_OPS EVAL_OPS) (CTX' := Eq.symm COMPUTE);
--           }
--         }
--       }
--   }

end ExprFoldExtraction

-- -- ERROR: IR check failed at 'Expr.fold', error: unknown declaration EvalContext.toTypingContext.preimage_
-- def Expr.fold
--   {kindMotive: Kind → Type} -- what each kind is compiled into.
--   (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
--   (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
--   {evalctx : EvalContext kindMotive}
--   {e : Expr ek k}
--   {defctx  : TypingContext}
--   (DEFCTX: evalctx.toTypingContext = defctx)
--   (WT: ExprWellTyped defctx e) :
--   Σ (evalctx' : EvalContext kindMotive), ExprFold opFold pairFold evalctx e evalctx'  :=
--   match WT with
--   |  .assign (i := i) (o := o)  (ret := ret)  (arg := arg) (kind := ekind) ARG RET =>
--     let ⟨arg_val, ARG_VAL⟩ := EvalContext.toTypingContext.preimage_some DEFCTX ARG;
--     let evalctx' := evalctx.bind ret o (opFold ekind arg_val);
--     { fst := evalctx',
--       snd := ExprFold.mk_assign
--                 (opFold := opFold)
--                 (pairFold := pairFold)
--                 (ARG := EvalContext.lookupByKind_lookup_some ARG_VAL)
--                 (RET := EvalContext.toTypingContext_preimage_none (DCTX := DEFCTX) RET)
--                 (CTX' := rfl) }
--   |  .pair ARG1 ARG2 RET (ret := ret) (arg1 := arg1) (arg2 := arg2) (k1 := k1) (k2 := k2) =>
--       let ⟨arg1_val, ARG1_VAL⟩ := EvalContext.toTypingContext.preimage_some DEFCTX ARG1;
--       let ⟨arg2_val, ARG2_VAL⟩ := EvalContext.toTypingContext.preimage_some DEFCTX ARG2;
--       let evalctx' := evalctx.bind ret (Kind.pair k1 k2) (pairFold arg1_val arg2_val);
--       { fst := evalctx',
--         snd := ExprFold.mk_pair
--                     (opFold := opFold)
--                     (pairFold := pairFold)
--                     (ARG1 := EvalContext.lookupByKind_lookup_some ARG1_VAL)
--                     (ARG2 := EvalContext.lookupByKind_lookup_some ARG2_VAL)
--                     (RET := EvalContext.toTypingContext_preimage_none (DCTX := DEFCTX) RET)
--                     (CTX' := rfl) }
--   | .ops (ctxmid := ctxmid) (ctxend := ctxend) (op1 := op1) (op2 := _op2)  OP OPS =>
--       let ⟨ectxmid, ECTXMID⟩ := Expr.fold opFold pairFold DEFCTX OP;
--       let defctx1 := ectxmid.toTypingContext;
--       let _DEFCTX1 : ectxmid.toTypingContext = defctx1 := rfl;
--       /-
--       since we have:
--        WellTyped[defctx; op; ctxmid]
--       as well as:
--         ExprFold[evalctx; op; ectxmid],
--       we derive:
--           WellTyped[evalctx.toTypingContext; op; ectxmid.toTypingContext]
--       but since WellTyped is deterministic, we can derive:
--           ectxmid.toTypingContext = ctxmid
--       from this, we can continue to evaluate `OPS`, since we now know that:
--         1. ectxmid.toTypingContext = ctxmid
--         2. ExprWellTyped ctxmid ops' ctxend
--         ie, we know that 'evalctxmid' corresponds to the well typed IH about ctxmid.

--       -/
--       let WT_ECTX : ExprWellTyped defctx op1 (EvalContext.toTypingContext ectxmid) := DEFCTX ▸ ECTXMID.well_typed;
--       let DEFCTX_MID : ectxmid.toTypingContext = ctxmid :=
--         ExprWellTyped.deterministic WT_ECTX OP;
--       let ⟨evalctx2, EVALCTX2⟩ := Expr.fold opFold pairFold DEFCTX_MID OPS;
--       { fst := evalctx2,
--         snd := ExprFold.mk_ops (EVAL_OP := ECTXMID) (EVAL_OPS := EVALCTX2) (CTX' := rfl) }


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

-- The result of mapping on an evaluation context is a mapped vaue
theorem EvalContext.map_some
  {kindMotive: Kind → Type}
  {kindMotive': Kind → Type}
  {ectx: EvalContext kindMotive}
  {f: ∀ {k : Kind}, kindMotive k → kindMotive' k}
  {v: Σ (k: Kind), kindMotive k}
  (LOOKUP: ectx arg = .some v) :
  (ectx.map f) arg = .some (v.mapRight f) := by {
  simp[map, Sigma.mapRight, LOOKUP]
}

-- The result of mapping on an evaluation context is `none` if it was
-- originally none.
theorem EvalContext.map_none
  {kindMotive: Kind → Type}
  {kindMotive': Kind → Type}
  {ectx: EvalContext kindMotive}
  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k)
  (LOOKUP: ectx arg = Option.none) :
  ((ectx.map f) arg = Option.none) := by {
    simp[map, Sigma.mapRight, LOOKUP];
  }

-- If the typing context that arose from an evaluation context has key with kind `k`,
-- then the mapped evaluation context at the key has the same kind `k`
theorem EvalContext.lookupByKind_map_some
  {kindMotive: Kind → Type}
  {kindMotive': Kind → Type}
  {ectx: EvalContext kindMotive}
  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k)
  {kind: Kind} {val: kindMotive kind}
  (LOOKUP: EvalContext.lookupByKind ectx arg kind = some val) :
  EvalContext.lookupByKind (EvalContext.map f ectx) arg kind = some (f val) := by {
    have VAL := EvalContext.lookupByKind_lookup_some.mpr LOOKUP;
    simp[EvalContext.map_some VAL];
    simp[lookupByKind, map, VAL];
}


-- If the typing context that arose from an evaluation context has key with kind `k`,
-- then the mapped evaluation context at the key has the same kind `k`
theorem EvalContext.toTypingContext_map_some
  {kindMotive: Kind → Type}
  {kindMotive': Kind → Type}
  {ectx: EvalContext kindMotive}
  {k: Kind}
  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k)
  (LOOKUP: EvalContext.toTypingContext ectx arg = some k) :
  EvalContext.toTypingContext (EvalContext.map (fun {k} => f) ectx) arg = some k := by {
    have VAL := EvalContext.toTypingContext.preimage_some (DCTX := rfl) LOOKUP;
    simp[map, EvalContext.toTypingContext, VAL.property];
}

-- If the typing context that arose from an evaluation context does not have a key,
-- then the mapped evaluation context does not have the key,
theorem EvalContext.toTypingContext_map_none
  {kindMotive: Kind → Type}
  {kindMotive': Kind → Type}
  {ectx: EvalContext kindMotive}
  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k) -- naturality.
  (LOOKUP: EvalContext.toTypingContext ectx arg = none) :
  EvalContext.toTypingContext (EvalContext.map (fun {k} => f) ectx) arg = none := by {
    have VAL := EvalContext.toTypingContext_preimage_none (DCTX := rfl) LOOKUP;
    simp[map, EvalContext.toTypingContext, VAL];
}

-- If the evaluation context does not have a key,
-- then the mapped evaluation context does not have the key,
theorem EvalContext.lookupByKind_map_none
  {kindMotive: Kind → Type}
  {kindMotive': Kind → Type}
  {ectx: EvalContext kindMotive}
  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k)
  {kind: Kind}
  (LOOKUP: EvalContext.lookupByKind ectx arg kind = none) :
  EvalContext.lookupByKind (EvalContext.map (fun {k} => f) ectx) arg kind = none := by {
    simp[lookupByKind, map] at LOOKUP ⊢;
    cases ARG: (ectx arg) <;> simp[ARG, LOOKUP] at LOOKUP ⊢;
    case some argv => {
      intros KIND; subst KIND;
      specialize (LOOKUP rfl);
      simp at LOOKUP ⊢;
    }
}


-- mapping preserves the typing context.
theorem EvalContext.toTypingContext_map
  {kindMotive: Kind → Type}
  {kindMotive': Kind → Type}
  (ectx: EvalContext kindMotive)
  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k):
  EvalContext.toTypingContext ectx =
  EvalContext.toTypingContext (ectx.map f) := by {
    funext arg;
    cases H:(ectx arg) <;>  simp[toTypingContext, EvalContext.map, H];
}

/-
We need a way to transport well-typedness along evaluation context morphisms.
If we know that an expression is well typed, then we should be able to transport
it along a 'EvalContext.map' [which is yet to be defined.]
-/
def ExprWellTyped.map
 {kindMotive: Kind → Type}
 {kindMotive': Kind → Type}
 (f: ∀ {k : Kind}, kindMotive k → kindMotive' k) -- naturality.
 {ectx: EvalContext kindMotive}
 {ek: ExprKind}
 {e: Expr ek k}
 (WT: ExprWellTyped ectx.toTypingContext e)
  : ExprWellTyped (ectx.map f).toTypingContext e := by {
  cases WT;
  case assign i o ret arg ARG RET => {
    apply ExprWellTyped.mk_assign;
    apply EvalContext.toTypingContext_map_some (LOOKUP := ARG);
    apply EvalContext.toTypingContext_map_none (LOOKUP := RET);
  }
  case pair ret arg1 arg2 k1 k2 ARG ARG' RET => {
    apply ExprWellTyped.mk_pair;
    apply EvalContext.toTypingContext_map_some (LOOKUP := ARG);
    apply EvalContext.toTypingContext_map_some (LOOKUP := ARG');
    apply EvalContext.toTypingContext_map_none (LOOKUP := RET);
  }
  case ops op1 op2 ctxmid WT1 WT2 => {
    constructor;
    exact (EvalContext.toTypingContext_map ectx f ▸ WT1);
    exact (EvalContext.toTypingContext_map ectx f ▸ WT2);
  }
}

-- Convert a well typed 'Expr' into a value, as asked by 'kindMotive'
def Expr.eval {ectx : EvalContext kindMotive}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {e: Expr ek k}
  (WT: ExprWellTyped ectx.toTypingContext e): kindMotive k :=
  (e.eval? opFold pairFold ectx).get
    (Expr.eval?_isSome_if_expr_wellformed
      (opFold := opFold) (pairFold := pairFold)
      (DEFCTX := rfl) (WT := WT))

theorem Option.get_none_elim:
  (Option.get none P = v)-> False := by {
    simp at P;
  }

theorem Expr.eval_implies_eval?_some
  {ectx : EvalContext kindMotive}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {e: Expr ek k}
  {WT: ExprWellTyped ectx.toTypingContext e}
  (EVAL: Expr.eval opFold pairFold WT = v):
  (e.eval? opFold pairFold ectx = .some v) := by {
    simp[Expr.eval?, Expr.eval] at EVAL ⊢;
    cases VAL: (e.eval? opFold pairFold ectx);
    simp[VAL] at EVAL ⊢;
    case none => {
      simp[Option.get_none_elim EVAL];
    }
    case some val => {
      simp[VAL] at EVAL ⊢;
      subst val;
      rfl;
    }
}

-- If we know that `eval?` has a vaulue, then we can compute the mapped value,
theorem Expr.eval?_map_some
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ctx : EvalContext kindMotive}
  {e : Expr ek k}
  {val: kindMotive k}
  (SUCCESS: e.eval? opFold pairFold ctx = .some val): True := sorry

-- Convert an expression to a tree by folding into the tree algebra
def Expr.toOpenTree? (ectx: EvalContext kindMotive) (e : Expr ek k): Option (OpenTree kindMotive k) :=
    (e.eval?
        (opFold := fun opk ti => OpenTree.assign (kindMotive := kindMotive) opk ti)
        (pairFold := fun  ti ti' => OpenTree.pair (kindMotive := kindMotive) ti ti'))
        (ectx.map (OpenTree.var (kindMotive := kindMotive)))

-- Convert an expression to a tree by folding into the tree algebra
def Expr.toOpenTree {ectx: EvalContext kindMotive} {e : Expr ek k}
  (WT: ExprWellTyped ectx.toTypingContext e): OpenTree kindMotive k :=
    (e.eval
        (opFold := fun opk ti => OpenTree.assign opk ti)
        (pairFold := fun  ti ti' => OpenTree.pair ti ti')
        (WT := WT.map OpenTree.var))

-- we define 'Expr.eval', 'Expr.toTree', and 'Tree.eval' and show that the diagram below commutes:
-- Expr.eval = Tree.eval ∘ Expr.toTree
def OpenTree.eval
  (kindMotive: Kind → Type)
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  : OpenTree kindMotive k → kindMotive k
  | .var v => v
  | .assign opk ti => opFold opk (ti.eval opFold pairFold)
  | .pair ta tb =>
      pairFold (ta.eval opFold pairFold) (tb.eval opFold pairFold)

-- If op is well typed in `ctx`, then it is well typed in `cctx.extend...`
theorem ExprWellTyped.op_extend
  {expr: Expr ek k}
  (WT1: ExprWellTyped ctx expr)
  {kind: Kind}
  {name: String}:
  ExprWellTyped (ctx.bind name kind) expr := by {
    sorry
  }


-- If 'Expr.toOpenTree?', 'Expr.eval?', and 'OpenTree.eval?' are all defined, then we can show that
-- the expected diagram commutes.
theorem OpenTree.eval?_sound_open
  {ectx : EvalContext kindMotive}
  {e: Expr ek k}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')):
  Option.map (OpenTree.eval kindMotive opFold pairFold) (e.toOpenTree? ectx) =
    e.eval? opFold pairFold ectx :=
  match e with
  | .assign ret ekind arg => sorry
  | .pair .. => sorry
  | .ops .. => sorry

-- the diagram commutes for open terms: Expr.eval = OpenTree.eval ∘ Expr.toOpenTree
-- for open terms, we need to add variables to our trees.
theorem OpenTree.eval_sound_open_op
  {ectx : EvalContext kindMotive}
  {e: Expr .O k}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (WT: ExprWellTyped ectx.toTypingContext e) :
  (e.toOpenTree WT).eval opFold pairFold = e.eval opFold pairFold WT := by {
    cases WT;
    case assign argk ret arg opkind ARG_WT RET_WT => {
      -- TODO: find a nice way to clean up the preimage/map/toTyping finagling.
      simp[Expr.eval, Expr.toOpenTree, OpenTree.eval, Expr.eval?];
      let ARG_VAL := EvalContext.toTypingContext_preimage_lookupByKind_some' ARG_WT;
      simp[ARG_VAL.property];
      let ARG_MAPPED_VAL :=
        EvalContext.lookupByKind_map_some (f := fun {k} x => @var kindMotive k x) ARG_VAL.property;
      simp[ARG_MAPPED_VAL];
      -- ret
      have RET_VAL := EvalContext.toTypingContext_preimage_none (DCTX := rfl) RET_WT;
      have RET_MAPPED_VAL := EvalContext.map_none (f := fun {k} x => @var kindMotive k x) RET_VAL;
      simp[RET_MAPPED_VAL, RET_VAL];
      simp[eval];
    }
    case pair ret arg1 arg2 k1 k2 ARG1 ARG2 RET => {
      simp[Expr.eval, Expr.toOpenTree, OpenTree.eval, Expr.eval?];
      -- arg1
      let ARG1_VAL := EvalContext.toTypingContext_preimage_lookupByKind_some' ARG1;
      simp[ARG1_VAL.property];
      let ARG1_MAPPED_VAL :=
        EvalContext.lookupByKind_map_some (f := fun {k} x => @var kindMotive k x) ARG1_VAL.property;
      simp[ARG1_MAPPED_VAL];
      -- arg2
      let ARG2_VAL := EvalContext.toTypingContext_preimage_lookupByKind_some' ARG2;
      simp[ARG2_VAL.property];
      let ARG2_MAPPED_VAL :=
        EvalContext.lookupByKind_map_some (f := fun {k} x => @var kindMotive k x) ARG2_VAL.property;
      simp[ARG2_MAPPED_VAL];
      -- ret
      have RET_VAL := EvalContext.toTypingContext_preimage_none (DCTX := rfl) RET;
      have RET_MAPPED_VAL := EvalContext.map_none (f := fun {k} x => @var kindMotive k x) RET_VAL;
      simp[RET_MAPPED_VAL, RET_VAL];
      simp[eval];
    }
  }

-- If the op is well-typed, then `Expr.eval?` will equal `OpenTree.eval <$> Expr.toOpenTree?`
theorem OpenTree.eval?_sound_open_op_well_typed
  {ectx : EvalContext kindMotive}
  {e: Expr .O k}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (WT: ExprWellTyped ectx.toTypingContext e) :
  (e.toOpenTree? ectx).map (OpenTree.eval kindMotive opFold pairFold) = e.eval? opFold pairFold ectx := by {
  have EQ : (e.toOpenTree WT).eval opFold pairFold = e.eval opFold pairFold WT := by {
    apply OpenTree.eval_sound_open_op;
  };
  simp[Expr.toOpenTree?, Expr.toOpenTree] at EQ ⊢;
  have E_EVAL: Expr.eval? opFold pairFold ectx e = .some (Expr.eval opFold pairFold WT) := by {
    apply Expr.eval_implies_eval?_some (EVAL := rfl);
  }
  simp[E_EVAL];
  rw[← EQ];
  exists  (Expr.eval (fun {i o} opk ti => assign opk ti) (fun {i i'} ti ti' => pair ti ti')
          (ExprWellTyped.map (fun {k} => var) WT));
  constructor <;> simp;
  apply Expr.eval_implies_eval?_some;
  rfl;
}

-- if we know that 'op1' is well typed at 'ectx', then extending
-- 'ectx' with some value 'val' for 'op1'
def ExprWellTyped.extendEvalContext
  {ectx : EvalContext kindMotive}
  {op1: Expr .O k}
  {op2: Expr .Os k2}
  (val: kindMotive k)
  (WT2: ExprWellTyped (TypingContext.bind (Expr.retVar op1) k (EvalContext.toTypingContext ectx)) op2) :
  ExprWellTyped (EvalContext.toTypingContext (ectx.bind op1.retVar k val)) op2 := by {
    have H : (EvalContext.toTypingContext (ectx.bind op1.retVar k val)) =
      TypingContext.bind (Expr.retVar op1) k (EvalContext.toTypingContext ectx) := by {
        apply EvalContext.toTypingContext_bind;
        simp[EvalContext.toTypingContext, EvalContext.bind];
      };
    rw[H];
    assumption;
}

theorem Expr.eval_ops
  {ectx : EvalContext kindMotive}
  {op1: Expr .O k}
  {op2: Expr .Os k2}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (WT1: ExprWellTyped ectx.toTypingContext op1)
  (WT2: ExprWellTyped (TypingContext.bind (Expr.retVar op1) k (EvalContext.toTypingContext ectx)) op2) :
  Expr.eval opFold pairFold (ExprWellTyped.ops op1 op2 WT1 WT2) =
  Expr.eval opFold pairFold
    (WT2.extendEvalContext (Expr.eval opFold pairFold WT1)) := by {
    simp[Expr.eval, Expr.eval?];
    have EVAL_OP1 : Expr.eval? opFold pairFold ectx op1 = .some (Expr.eval opFold pairFold WT1) := by {
      apply Expr.eval_implies_eval?_some (EVAL := rfl)
    };
    simp[EVAL_OP1];
  }


theorem Expr.toOpenTree_ops
  {ectx : EvalContext kindMotive}
  {op1: Expr .O k}
  {op2: Expr .Os k2}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (WT1: ExprWellTyped ectx.toTypingContext op1)
  (WT2: ExprWellTyped (TypingContext.bind (Expr.retVar op1) k (EvalContext.toTypingContext ectx)) op2) :
  Expr.toOpenTree (ExprWellTyped.ops op1 op2 WT1 WT2) =
    Expr.toOpenTree  (WT2.extendEvalContext (Expr.toOpenTree WT1)) := by {

  }
-- theorem OpenTree.eval_ops
--   {ectx : EvalContext kindMotive}
--   {op1: Expr .O k}
--   {op2: Expr .Os k2}
--   (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
--   (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
--   (WT1: ExprWellTyped ectx.toTypingContext op1)
--   (WT2: ExprWellTyped (TypingContext.bind (Expr.retVar op1) k (EvalContext.toTypingContext ectx)) op2) :
--   (Expr.toOpenTree (Expr.ops op1 op2) (ExprWellTyped.ops op1 op2 WT1 WT2)) =
--   Expr.toOpenTree op2 ()
--     (WT2.extendEvalContext (Expr.eval opFold pairFold WT1)) := by {
--     simp[Expr.eval, Expr.eval?];
--     have EVAL_OP1 : Expr.eval? opFold pairFold ectx op1 = .some (Expr.eval opFold pairFold WT1) := by {
--       apply Expr.eval_implies_eval?_some (EVAL := rfl)
--     };
--     simp[EVAL_OP1];
--   }



theorem OpenTree.eval_sound_open_ops
  {ectx : EvalContext kindMotive}
  {e: Expr .Os k}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (WT: ExprWellTyped ectx.toTypingContext e) :
  (e.toOpenTree WT).eval opFold pairFold = e.eval opFold pairFold WT := by {
  cases WT;
  case ops k op1 op2 WT1 WT2 => {
    simp only[Expr.eval_ops];
    have WT1' : ExprWellTyped (EvalContext.toTypingContext (ectx.map (OpenTree.var (kindMotive := kindMotive)))) op1 := by {
      apply ExprWellTyped.map;
      assumption;
    };
    have  EVAL_OP := OpenTree.eval_sound_open_op opFold pairFold WT1;

    simp[←EVAL_OP];
    have  H1 := OpenTree.eval?_sound_open_op_well_typed opFold pairFold WT1;
    have  H2 := OpenTree.eval?_sound_open_op_well_typed (OpenTree.assign) (OpenTree.pair) WT1'
      (e := op1) (ectx := EvalContext.map (fun {k} => var) ectx);

  }
}

end OpenEvaluation
-- Annoying, this does not help, since it does not let us talk about program fragments.
-- In theory, we could say that we have some kind of input

end ToTree