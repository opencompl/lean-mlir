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
  {ctxbegin ctxmid : TypingContext}
  (op1: Op k)
  (op2: Ops ks)
  (WT1: ExprWellTyped ctxbegin op1)
  (CTXMID: (ctxbegin.bind op1.retVar k) = ctxmid)
  (WT2: ExprWellTyped ctxmid op2) :
  ExprWellTyped ctxbegin (Expr.ops op1 op2)


notation "wt[" ctx " ⊢ " e "]" => ExprWellTyped ctx e

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
    case ops WT_OP MID WT_OPS => {
      subst MID;
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
    case ops op' ops' ctxbegin ctxend ctxmid WT_OP MID WT_OPS IH_OP IH_OPS => {
      subst MID;
      cases wf2;
      case ops  WT_OP' MID' WT_OPS' => {
        subst MID';
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

notation ctx "[" bindname ":" bindk " ↦ "  bindv  "]" => EvalContext.bind bindname bindk bindv ctx

-- lookup a binding by both name and kind.
def EvalContext.lookupByKind {kindMotive: Kind → Type} (ctx: EvalContext kindMotive)
  (name : String) (needlekind: Kind) : Option (kindMotive needlekind) :=
  match ctx name with
  | .none => .none
  | .some ⟨k, kv⟩ =>
      if NEEDLE : needlekind = k
      then NEEDLE ▸ kv
      else .none

notation ctx "[" name ":" bindk "]?" => EvalContext.lookupByKind ctx name bindk


-- Simplify `lookupByKind` when we have a syntactically
-- matching `lookup`result.
theorem EvalContext.lookupByKind_lookup_some_ {kindMotive: Kind → Type} {ectx: EvalContext kindMotive}
  {k: Kind} {v: kindMotive k} {name: String}
  (LOOKUP: ectx name = some { fst := k, snd := v }) :
  (ectx.lookupByKind name k = .some v) := by {
    simp[EvalContext.lookupByKind, LOOKUP];
  }

-- Simplify `lookupByKind` when we have a syntactically
-- matching `lookup`result.
theorem EvalContext.lookupByKind_lookup_some_inv {kindMotive: Kind → Type} {ectx: EvalContext kindMotive}
  {k: Kind} {v: kindMotive k} {name: String}
  (LOOKUP: ectx.lookupByKind name k = .some v) :
  ectx name = some { fst := k, snd := v } := by {
    simp[EvalContext.lookupByKind, LOOKUP] at LOOKUP ⊢;
    cases VAL:(ectx name) <;> simp[VAL] at LOOKUP;
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

theorem EvalContext.lookupByKind_lookup_some {kindMotive: Kind → Type} {ectx: EvalContext kindMotive}
  {k: Kind} {v: kindMotive k} {name: String} :
  (ectx name = some { fst := k, snd := v }) ↔ (ectx.lookupByKind name k = .some v) where
  mp := EvalContext.lookupByKind_lookup_some_
  mpr := EvalContext.lookupByKind_lookup_some_inv




-- Simplify `lookupByKind` when we have a syntactically
-- matching `lookup`result.
theorem EvalContext.lookupByKind_lookup_none {kindMotive: Kind → Type} {ectx: EvalContext kindMotive}
  {k: Kind} {name: String}
  (LOOKUP: ectx name = none):
  (ectx.lookupByKind name k = .none) := by {
    simp[EvalContext.lookupByKind, LOOKUP];
  }


-- Treat an eval context as a def context by ignoring the eval value.
@[coe]
def EvalContext.toTypingContext (ctx: EvalContext kindMotive): TypingContext :=
  fun name =>
    match ctx name with
    | .none => .none
    | .some ⟨k, _kv⟩ => k

-- coerce an eval context to a typing context.
instance : Coe (EvalContext kindMotive) TypingContext := ⟨EvalContext.toTypingContext⟩

-- show that 'evalcontext' and 'todefcontext' agree.
theorem EvalContext.toTypingContext.agreement:
∀ ⦃ctx: EvalContext kindMotive⦄  ⦃name: String⦄,
  (ctx name).isSome ↔ (ctx.toTypingContext name).isSome := by {
    intros ctx name;
    simp[toTypingContext];
    cases ctx name <;> simp;
}




/-
Showing that a value can be extracted out of Expr.eval?
whenever the expr is well formed.
-/

-- If 'tctx' has a value at 'name', then so does 'ectx' at 'name' if
-- 'tctx' came from 'ectx'.
def EvalContext.toTypingContext.preimage_some
  { kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {tctx: TypingContext}
  (TCTX: EvalContext.toTypingContext ectx = tctx)
  {name : String}
  {kind : Kind}
  (LOOKUP: tctx name = .some kind) :
  { val : kindMotive kind // ectx name = .some ⟨kind, val⟩ } := by {
    rewrite[← TCTX] at LOOKUP;
    simp[toTypingContext] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩ <;> aesop;
}

-- Same as EvalContext.toTypingContext.preimage_some, without the fording on 'tctx'
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
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {kind : Kind}
  (TCTX: EvalContext.toTypingContext ectx = tctx)
  (LOOKUP: tctx name = .some kind) :
  { val : kindMotive kind // ectx.lookupByKind name kind = .some val } := by {
    subst TCTX;
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
  {tctx: TypingContext}
  (TCTX: EvalContext.toTypingContext ectx = tctx)
  {name : String}
  (LOOKUP: tctx name = .none) :
  ectx name = .none := by {
    rewrite[← TCTX] at LOOKUP;
    simp[toTypingContext] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩ <;> aesop;
}
-- Same as `EvalContext.toTypingContext_preimage_none`, without the fording on 'tctx'
theorem EvalContext.toTypingContext_preimage_none'
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  (TCTX: ectx.toTypingContext = tctx)
  (LOOKUP: tctx name = .none) :
  ectx name = .none := by {
    subst TCTX;
    simp[toTypingContext] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩ <;> aesop;
}

def EvalContext.toTypingContext_preimage_lookupByKind_none'
  { kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {kind : Kind}
  (TCTX: ectx.toTypingContext = tctx)
  (LOOKUP: tctx name = .none) :
  ectx.lookupByKind name kind = .none := by {
    subst TCTX
    simp[toTypingContext] at LOOKUP;
    rcases H:(ectx name) with _ | ⟨⟨val_kind, val_val⟩⟩ <;> simp[H] at LOOKUP;
    simp[lookupByKind, H, LOOKUP]
}




-- ((name, kind, val) :: ectx).toTypingContext = (name, kind) :: ectx.toTypingContext
-- Alternatively, 'toTypingContext' is a homomorphism of contexts.
theorem EvalContext.toTypingContext_bind
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {tctx: TypingContext}
  (TCTX: EvalContext.toTypingContext ectx = tctx)
  {kind : Kind}
  {val: kindMotive kind}
  {arg: String} :
  (EvalContext.bind arg kind val ectx).toTypingContext = TypingContext.bind arg kind tctx := by {
    funext key;
    simp[toTypingContext, TypingContext.bind, EvalContext.bind];
    by_cases NAME:(key = arg) <;> simp[NAME];
    case neg => {
      simp[NAME];
      simp[toTypingContext];
      cases TCTX_KEY:(tctx key);
      case none => {
        have ECTX_KEY := EvalContext.toTypingContext_preimage_none TCTX TCTX_KEY;
        simp[ECTX_KEY];
      }
      case some => {
        have ⟨ectx_val, ECTX_KEY⟩:= EvalContext.toTypingContext.preimage_some TCTX TCTX_KEY;
        simp[ECTX_KEY];
      }
    }
}

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

notation "expr⟦⟧?[" opFold ", " pairFold " ; " ctx " ⊧ " "⟦" e "⟧" "]" => Expr.eval? opFold pairFold  ctx e


-- unfolding theorem for 'eval?' at ops
theorem Expr.eval?_ops
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ctx : EvalContext kindMotive)
  (o1: Expr .O k1)
  (o2: Expr .Os k2):
  Expr.eval? opFold pairFold ctx (Expr.ops o1 o2) =
  match Expr.eval? opFold pairFold ctx o1 with
  | .none => .none
  | .some v => Expr.eval? opFold pairFold (ctx.bind o1.retVar k1 v) o2 := by {
    simp[eval?];
    cases H:eval? (fun {i o} => opFold) (fun {i i'} => pairFold) ctx o1  <;> simp[H];
  }



-- 'eval?' will return a 'some' value
-- Note that here, we must ford TCTX, since to perform induction on 'wellformed',
-- we need the indexes of 'wellformed' to be variables.
theorem Expr.eval?_succeeds_if_expr_wellformed
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {ectx : EvalContext kindMotive}
  (TCTX: ↑ectx = tctx)
  {e : Expr ek k}
  (WT: ExprWellTyped tctx e) :
  { out // (e.eval? opFold pairFold ectx = .some out) } := by {
    revert ectx;
    induction WT;
    case assign i o ret arg ectx_tctx name ARG RET => {
      intros ectx TCTX;
      have ⟨arg_val, ARG_VAL⟩ := EvalContext.toTypingContext.preimage_some TCTX ARG;
      have RET_VAL := EvalContext.toTypingContext_preimage_none TCTX RET;
      simp[eval?] at *;
      simp[EvalContext.lookupByKind] at *;
      simp[ARG_VAL];
      simp[RET_VAL];
      apply Subtype.mk (opFold name arg_val);
      rfl
    }

    case pair tctx  ret arg1 arg2 k1 k2 ARG1 ARG2 RET  => {
      intros ectx TCTX;
      have ⟨arg1_val, ARG1_VAL⟩ := EvalContext.toTypingContext.preimage_some TCTX ARG1;
      have ⟨arg2_val, ARG2_VAL⟩ := EvalContext.toTypingContext.preimage_some TCTX ARG2;
      have RET_VAL := EvalContext.toTypingContext_preimage_none TCTX RET;
      simp[eval?];
      simp[EvalContext.lookupByKind, ARG1_VAL, ARG2_VAL, RET_VAL];
      apply Subtype.mk (pairFold arg1_val arg2_val);
      rfl
      -- apply EvalContext.toTypingContext_bind TCTX;
    }
    case ops op ops ctxbegin ctxend ctxmid _WT_OP MID _WT_OPS IH1 IH2 => {
      subst MID;
      intros ectx TCTX;
      simp[eval?];
      obtain out1 := IH1 TCTX;
      simp[out1.property];
      apply IH2;
      apply EvalContext.toTypingContext_bind TCTX;
    }
}

-- 'Expr.eval?' returns a value that 'isSome' if the expression is well formed.
theorem Expr.eval?_isSome_if_expr_wellformed
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  {ectx : EvalContext kindMotive}
  (TCTX: ectx.toTypingContext = tctx)
  {e : Expr ek k}
  (WT: ExprWellTyped tctx e) :
  (e.eval? opFold pairFold ectx).isSome := by {
    simp[Option.isSome];
    let val := Expr.eval?_succeeds_if_expr_wellformed TCTX WT (opFold := opFold) (pairFold := pairFold);
    simp[val.property];
}



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

notation:max ectx " <$> " f => EvalContext.map f ectx

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
    have VAL := EvalContext.toTypingContext.preimage_some (TCTX := rfl) LOOKUP;
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
    have VAL := EvalContext.toTypingContext_preimage_none (TCTX := rfl) LOOKUP;
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
  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k)
  {tctx: TypingContext}
  (TCTX: EvalContext.toTypingContext ectx = tctx) :
  EvalContext.toTypingContext (ectx.map f) = tctx := by {
    subst TCTX;
    funext arg;
    cases H:(ectx arg) <;> simp[toTypingContext, EvalContext.map, H];
}

-- /-
-- We need a way to transport well-typedness along evaluation context morphisms.
-- If we know that an expression is well typed, then we should be able to transport
-- it along a 'EvalContext.map' [which is yet to be defined.]
-- -/
-- def ExprWellTyped.map
--  {kindMotive: Kind → Type}
--  {kindMotive': Kind → Type}
--  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k) -- naturality.
--  {ectx: EvalContext kindMotive}
--  {tctx: TypingContext}
--  (TCTX: ectx.toTypingContext = tctx)
--  {ek: ExprKind}
--  {e: Expr ek k}
--  (WT: ExprWellTyped tctx e)
--   : ExprWellTyped (ectx.map f).toTypingContext e := by {
--   cases WT;
--   case assign i o ret arg ARG RET => {
--     apply ExprWellTyped.mk_assign;
--     apply EvalContext.toTypingContext_map_some (LOOKUP := ARG);
--     apply EvalContext.toTypingContext_map_none (LOOKUP := RET);
--   }
--   case pair ret arg1 arg2 k1 k2 ARG ARG' RET => {
--     apply ExprWellTyped.mk_pair;
--     apply EvalContext.toTypingContext_map_some (LOOKUP := ARG);
--     apply EvalContext.toTypingContext_map_some (LOOKUP := ARG');
--     apply EvalContext.toTypingContext_map_none (LOOKUP := RET);
--   }
--   case ops op1 op2 ctxmid WT1 WT2 => {
--     constructor;
--     exact (EvalContext.toTypingContext_map ectx f ▸ WT1);
--     exact (EvalContext.toTypingContext_map ectx f ▸ WT2);
--   }
-- }

-- theorem ExprWellTyped.map_ops
--  {kindMotive: Kind → Type}
--  {kindMotive': Kind → Type}
--  (f: ∀ {k : Kind}, kindMotive k → kindMotive' k) -- naturality.
--  {ectx: EvalContext kindMotive}
--  {op: Op k}
--  {ops: Ops ks}
--  (WT: ExprWellTyped ectx.toTypingContext (Expr.ops op ops)) :
--  ExprWellTyped (ectx.map f).toTypingContext (Expr.ops op ops) =
--   ExprWellTyped (ectx.toTypingContext) (Expr.ops op ops) := by {
--     cases WT;
--     case ops WT1 WT2 => {
--       have TYPING_CONTEXT_MAP := EvalContext.toTypingContext_map ectx f;
--       simp[TYPING_CONTEXT_MAP];
--     }
-- }

-- Convert a well typed 'Expr' into a value, as asked by 'kindMotive'
def Expr.eval {ectx : EvalContext kindMotive}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {e: Expr ek k}
  {tctx: TypingContext}
  (TCTX: ectx.toTypingContext = tctx)
  (WT: ExprWellTyped tctx e): kindMotive k :=
  (e.eval? opFold pairFold ectx).get
    (Expr.eval?_isSome_if_expr_wellformed
      (opFold := opFold) (pairFold := pairFold)
      (TCTX := TCTX) (WT := WT))

notation "expr⟦⟧[" opFold ", " pairFold "," TCTX ", " WT " ⊧ " "⟦" e "⟧" "]" =>
  Expr.eval opFold pairFold TCTX WT (e := e)

theorem Option.get_none_elim:
  (Option.get none P = v)-> False := by {
    simp at P;
  }

-- show under what conditions eval? and 'eval' agree.
theorem Expr.eval_eval?_eq
  {ectx : EvalContext kindMotive}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {e: Expr ek k}
  {TCTX: ectx.toTypingContext = tctx}
  {WT: ExprWellTyped tctx e} :
  (Expr.eval opFold pairFold TCTX WT = v) ↔
  (e.eval? opFold pairFold ectx = .some v) := by {
    constructor;
    case mp => {
      intro EVAL;
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

    case mpr => {
      intro EVAL?;
      simp[Expr.eval?, Expr.eval] at EVAL? ⊢;
      simp[EVAL?];
  }
}

-- If we know that `eval?` has a vaulue, then we can compute the mapped value,
-- theorem Expr.eval?_map_some
--   {kindMotive: Kind → Type} -- what each kind is compiled into.
--   (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
--   (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
--   {ctx : EvalContext kindMotive}
--   {e : Expr ek k}
--   {val: kindMotive k}
--   (SUCCESS: e.eval? opFold pairFold ctx = .some val): True := sxorry

-- Convert an expression to a tree by folding into the tree algebra
def Expr.toOpenTree? (treectx: EvalContext (OpenTree kindMotive)) (e : Expr ek k): Option (OpenTree kindMotive k) :=
    e.eval?
        (opFold := fun opk ti => OpenTree.assign (kindMotive := kindMotive) opk ti)
        (pairFold := fun  ti ti' => OpenTree.pair (kindMotive := kindMotive) ti ti')
        treectx


notation "expr→tree?[" treectx " ; " e "]" => Expr.toOpenTree? treectx e

-- Convert an expression to a tree by folding into the tree algebra
abbrev Expr.toOpenTree {treectx: EvalContext (OpenTree kindMotive)} {e : Expr ek k}
  (TCTX: treectx.toTypingContext = tctx)
  (WT: ExprWellTyped tctx e): OpenTree kindMotive k :=
    (e.eval
        (opFold := fun opk ti => OpenTree.assign opk ti)
        (pairFold := fun  ti ti' => OpenTree.pair ti ti')
        (tctx := tctx)
        (ectx := treectx)
        (TCTX := TCTX)
        (WT := WT))

notation "expr→tree[" TCTX "; " WT " ⊧ " e "]" => Expr.toOpenTree TCTX WT (e := e)

theorem Expr.toOpenTree?_toOpenTree_eq
  {treectx: EvalContext (OpenTree kindMotive)}
  {e : Expr ek k}
  {TCTX: ↑treectx = tctx}
  {WT: ExprWellTyped tctx e} :
  (Expr.toOpenTree TCTX WT = tree) ↔
  Expr.toOpenTree? treectx e = .some tree := by {
    simp[Expr.toOpenTree];
    apply Expr.eval_eval?_eq;
  }
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

notation "evaltree[" kindMotive ", " opFold "," pairFold " ⊧ " "⟦" tree "⟧" "]" => OpenTree.eval kindMotive opFold pairFold tree

-- If the op is well-typed, then `Expr.eval?` will equal `OpenTree.eval <$> Expr.toOpenTree?`
-- theorem OpenTree.eval?_sound_open_op_well_typed
--   {ectx : EvalContext kindMotive}
--   {treectx: EvalContext (OpenTree kindMotive)}
--   (TREECTX: treectx = ectx.map (OpenTree.var ))
--   {e: Expr .O k}
--   (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
--   (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
--   (TCTX: ectx.toTypingContext = tctx)
--   (WT: ExprWellTyped tctx e) :
--   (e.toOpenTree? treectx).map (OpenTree.eval kindMotive opFold pairFold) = e.eval? opFold pairFold ectx := by {
--   subst TREECTX;
--   have EQ : (e.toOpenTree TCTX WT).eval opFold pairFold = e.eval opFold pairFold TCTX WT := by {
--     apply OpenTree.eval_sound_open_op;
--   };
--   simp[Expr.toOpenTree?, Expr.toOpenTree] at EQ ⊢;
--   have E_EVAL: Expr.eval? opFold pairFold ectx e = .some (Expr.eval opFold pairFold TCTX WT) := by {
--     apply Expr.eval_eval?_eq (EVAL := rfl);
--   }
--   simp[E_EVAL];
--   rw[← EQ];
--   have TCTX' : (ectx.map OpenTree.var).toTypingContext = tctx := by {
--     apply EvalContext.toTypingContext_map (TCTX := TCTX);
--   };
--   exists  (Expr.eval assign pair TCTX' WT);
--   constructor <;> simp;
--   apply Expr.eval_eval?_eq;
--   rfl;
-- }


-- In hindsight, it was probably easier to separately define evaluation and converting to a tree.
-- a tree context 'treectx' is valid iff it agrees with the value of 'ectx'
-- wherever ectx is evaluated.
-- TODO: this is a trashfire. It is not worth the "proof reuse" we get out of
-- this unification. As usual, @lyxsia has impeccable taste when it comes to dependent typing.
def ValidTreeContext
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ectx: EvalContext kindMotive) (treectx: EvalContext (OpenTree kindMotive)) : Prop :=
  ∀ (key: String) (kind: Kind) (val: kindMotive kind),
    ectx key = .some ⟨kind, val⟩ ↔
    ∃ val', treectx key = .some ⟨kind, val'⟩ ∧ OpenTree.eval kindMotive opFold pairFold val' = val

#check by_contradiction

-- the valid context, in terms of universal quantification for accessing the tree context.
def ValidTreeContext.reverse
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ectx: EvalContext kindMotive) (treectx: EvalContext (OpenTree kindMotive))
  (VALID_TREE_CTX: ValidTreeContext opFold pairFold ectx treectx) :
  ∀ (key: String) (kind: Kind) (val': OpenTree kindMotive kind),
    treectx key = .some ⟨kind, val'⟩ →
      ∃ val, ectx key = .some ⟨kind, val⟩ ∧ OpenTree.eval kindMotive opFold pairFold val' = val := by {
  simp[ValidTreeContext] at VALID_TREE_CTX;
  intros key kind treeval TREEVAL;
  specialize VALID_TREE_CTX key kind;
  apply by_contradiction;
  simp;
  intro H;
  specialize(VALID_TREE_CTX evaltree[kindMotive, fun {i o} => opFold,fun {i i'} => pairFold ⊧ ⟦treeval⟧]);
  have VALID_TREE_CTX := VALID_TREE_CTX.mpr;
  specialize (VALID_TREE_CTX ⟨treeval, by {
      simp[TREEVAL]
  }⟩);
  simp[VALID_TREE_CTX] at H;
}


notation "ectx~treectx[" opFold ", " pairFold " ⊧ " ectx " ~ " treectx "]" =>
  ValidTreeContext opFold pairFold ectx treectx

def ValidTreeContext.isTypingContext
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ectx: EvalContext kindMotive)
  {tctx: TypingContext}
  (TCTX: ectx.toTypingContext = tctx)
  {treectx: EvalContext (OpenTree kindMotive)}
  (TREECTX: ValidTreeContext opFold pairFold ectx treectx) :
  treectx.toTypingContext = tctx := by {
    simp[ValidTreeContext] at TREECTX;
    simp[EvalContext.toTypingContext] at TCTX ⊢;
    funext key;
    cases ECTX_KEY:(ectx key);
    case h.none => {
      -- if ectx is none, the treectx also must be none.
      -- if some, derive contradiction from 'TREECTX'.
      simp[ECTX_KEY];
      cases TREECTX_KEY:(treectx key) <;> simp[TREECTX_KEY];
      simp[← TCTX, ECTX_KEY];
      case some kind_and_treeval => {
        -- contradiction
        have ⟨kind, treeval⟩ := kind_and_treeval;
        -- this is kind of annoying, I need to evaluate the tree value
        -- to get that the value we have is a legitimate value.
        let val := treeval.eval kindMotive opFold pairFold;
        specialize (TREECTX key kind val);
        have CONTRA := TREECTX.mpr ⟨treeval, by {
          constructor;
          simp[TREECTX_KEY];
          rfl;
        }⟩;
        simp[CONTRA] at ECTX_KEY; -- contradiction.
      }
    }
    case h.some kind_val => {
      have ⟨kind, val⟩ := kind_val;
      specialize (TREECTX key kind val);
      have VAL_TREE := TREECTX.mp ECTX_KEY;
      have ⟨val_tree, TREE_KEY, TREE_EVAL⟩ := VAL_TREE;
      simp[TREE_KEY, TREE_EVAL];
      simp[← TCTX, ECTX_KEY];
    }
  }

-- using (EvalContext.map var) provides a valid tree context.
theorem ValidTreeContext.map_is_valid_tree_context
  {ectx : EvalContext kindMotive}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')):
  ValidTreeContext opFold pairFold ectx (ectx.map (OpenTree.var )) := by {
    unfold ValidTreeContext;
    intros key kind val;
    constructor;
    case mp => {
      intros  H;
      simp[ValidTreeContext, EvalContext.map];
      simp[H];
      simp[OpenTree.eval];
    }
    case mpr => {
      intros  H;
      have ⟨val', ECTX, TREE_EVAL⟩ := H;
      simp[EvalContext.map] at ECTX;
      cases KEY:(ectx key) <;> simp [KEY] at ECTX ⊢;
      case some val => {
        let ⟨VAL_FST, VAL_SND⟩ := ECTX;
        induction VAL_FST;
        case refl => {
          cases VAL_SND;
          case refl => {
            simp[OpenTree.eval] at TREE_EVAL;
            subst TREE_EVAL;
            rfl;
          }
        }
      }
    }
}

-- if `tree.eval = value`, then binding `key` to `tree` in `treectx` is maintains
-- the validity of the context
theorem ValidTreeContext.bind
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ectx : EvalContext kindMotive}
  {treectx: EvalContext (OpenTree kindMotive)}
  (TREECTX: ValidTreeContext opFold pairFold ectx treectx)
  (value: kindMotive kind)
  (tree: OpenTree kindMotive kind)
  (TREE: tree.eval opFold pairFold = value)
  (name: String) :
  ValidTreeContext opFold pairFold (ectx.bind name kind value) (treectx.bind name kind tree) := by {
  intros key kind val;
  constructor;
  case mp => {
    intros H;
    simp at H ⊢;
    simp[ValidTreeContext, EvalContext.bind] at TREECTX H ⊢;
    by_cases KEY:(key = name);
    case pos => {
      subst KEY;
      simp at H  TREECTX ⊢;
      have ⟨KOP, EQ⟩ := H;
      subst KOP;
      subst EQ;
      simp at H TREECTX ⊢;
      exact TREE;
    }
    case neg => {
      simp[KEY] at H TREECTX ⊢;
      specialize (TREECTX key kind val);
      apply TREECTX.mp; assumption;
    }
  }
  case mpr => {
    simp;
    intros tree TREECTX_KEY EVAL_TREE;
    simp [EvalContext.bind] at TREECTX_KEY EVAL_TREE ⊢;
    by_cases KEY:(key = name);
    case pos => {
      subst KEY;
      simp at TREECTX_KEY EVAL_TREE ⊢;
      have ⟨KOP, VAR⟩ := TREECTX_KEY;
      subst KOP;
      simp at VAR ⊢;
      subst VAR;
      simp at EVAL_TREE ⊢;
      simp[OpenTree.eval] at EVAL_TREE ⊢;
      rw[← EVAL_TREE, ← TREE];
    }
    case neg => {
      simp[KEY] at TREECTX_KEY EVAL_TREE ⊢;
      specialize (TREECTX key kind val);
      apply TREECTX.mpr;
      exists tree;
    }
  }
}


-- given that `treectx[name:kind]? = .some treeval` and `ectx[name:kind]? = .some (v)`,
-- then `v = treeval.eval`
theorem ValidContext.lookup_by_kind
  {ectx : EvalContext kindMotive}
  {treectx: EvalContext (OpenTree kindMotive)}
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  (TREECTX: ValidTreeContext opFold pairFold ectx treectx)
  (name: String) (kind: Kind) (treeval: OpenTree kindMotive kind):
  (treectx.lookupByKind name kind) = .some treeval ↔
  (ectx.lookupByKind name kind) = .some (OpenTree.eval kindMotive opFold pairFold treeval ) := by {
  constructor;
  case mp => {
    simp[ValidTreeContext] at TREECTX;
    specialize (TREECTX name kind (OpenTree.eval  kindMotive opFold pairFold treeval ));
    intros TREE_AT_KEY;
    rw [← EvalContext.lookupByKind_lookup_some];
    apply TREECTX.mpr;
    exists treeval;
    have TREEVAL := EvalContext.lookupByKind_lookup_some_inv TREE_AT_KEY;
    simp[TREEVAL];
  }
  case mpr => {
    intros ECTX_AT_KEY;
    have H := (TREECTX name kind (OpenTree.eval  kindMotive opFold pairFold treeval ));
    simp[EvalContext.lookupByKind] at ECTX_AT_KEY ⊢;
    cases ectx_at_key:(ectx name) <;> simp[ectx_at_key] at ECTX_AT_KEY ⊢;
    case some val => {
      cases val;
      case mk val_kind val_val => {
        by_cases KIND:(kind = val_kind) <;> simp[KIND] at ECTX_AT_KEY ⊢;
        case pos => {
          subst KIND;
          simp at ECTX_AT_KEY ⊢;
          subst ECTX_AT_KEY;
          have ⟨treectx_val, TREECTX_AT_NAME, TREECTX_EVALCTX_AGREE⟩ := (H.mp ectx_at_key);
          simp[TREECTX_AT_NAME] at TREECTX_EVALCTX_AGREE ⊢;
          have H' := (TREECTX.reverse name kind treectx_val);
          simp[EvalContext.lookupByKind] at H' ⊢;
          specialize (H' TREECTX_AT_NAME);
          simp at H' ⊢;
          rw[ectx_at_key] at H';
          sorry
        }
      }
    }
  }
}


-- looking up 'ectx' and 'treectx' agree if we evaluate the 'treectx' value.
theorem ValidTreeContext.lookup_agree_eval
  {ectx : EvalContext kindMotive}
  {treectx: EvalContext (OpenTree kindMotive)}
  {opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o}
  {pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')}
  (TREECTX: ValidTreeContext opFold pairFold ectx treectx)
  (VCTX: (ectx.lookupByKind name kind) = .some val)
  (VTREE: (treectx.lookupByKind name kind) = .some treeval):
    val = OpenTree.eval  kindMotive opFold pairFold treeval  := by {
  simp[ValidTreeContext] at TREECTX;
  specialize (TREECTX name kind val);
  have ⟨MP, MPR⟩ := TREECTX;
  simp[ValidContext.lookup_by_kind];
  sorry
}
-- If 'Expr.toOpenTree?', 'Expr.eval?', and 'OpenTree.eval?' are all defined, then we can show that
-- the expected diagram commutes.
-- theorem OpenTree.eval?_sound_open
--   {ectx : EvalContext kindMotive}
--   {e: Expr ek k}
--   (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
--   (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')):
--   Option.map (OpenTree.eval kindMotive opFold pairFold) (e.toOpenTree? ectx) =
--     e.eval? opFold pairFold ectx :=
--   match e with
--   | .assign ret ekind arg => sxorry
--   | .pair .. => sxorry
--   | .ops .. => sxorry

-- the diagram commutes for open terms: Expr.eval = OpenTree.eval ∘ Expr.toOpenTree
-- for open terms, we need to add variables to our trees.
theorem OpenTree.eval_sound_open_op
  {ectx : EvalContext kindMotive}
  {e: Expr .O k}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {tctx: TypingContext}
  {treectx: EvalContext (OpenTree kindMotive)}
  (ECTX_TCTX: ↑ectx = tctx)
  (TREECTX_TCTX: treectx = tctx)
  (WT: ExprWellTyped tctx e)
  {TREECTX_ECTX: ValidTreeContext opFold pairFold ectx treectx}:
  (e.toOpenTree TREECTX_TCTX WT).eval opFold pairFold = e.eval opFold pairFold ECTX_TCTX WT := by {
    cases WT;
    case assign argk ret arg opkind ARG_WT RET_WT => {
      -- TODO: find a nice way to clean up the preimage/map/toTyping finagling.
      simp[Expr.eval, Expr.toOpenTree, OpenTree.eval, Expr.eval?];
      let ⟨arg_at_tctx, ARG_AT_TCTX⟩ := EvalContext.toTypingContext_preimage_lookupByKind_some' TREECTX_TCTX ARG_WT;
      simp[ARG_AT_TCTX];
      -- let ARG_MAPPED_VAL :=
      --   EvalContext.lookupByKind_map_some (f := fun {k} x => @var kindMotive k x) ARG_AT_TCTX.property;
      -- simp[ARG_MAPPED_VAL];
      -- ret
      have RET_AT_TCTX := EvalContext.toTypingContext_preimage_none TREECTX_TCTX RET_WT;
      simp[RET_AT_TCTX];
      simp[eval];

      let ⟨arg_at_ectx, ARG_AT_ECTX⟩ := EvalContext.toTypingContext_preimage_lookupByKind_some' ECTX_TCTX ARG_WT;
      simp[ARG_AT_ECTX];


      -- have RET_MAPPED_VAL := EvalContext.map_none (f := fun {k} x => @var kindMotive k x) RET_AT_TCTX;
      let RET_AT_ECTX := EvalContext.toTypingContext_preimage_none ECTX_TCTX RET_WT;
      simp[RET_AT_ECTX];

      congr;
      simp[← ARG_AT_ECTX];
      simp[Subtype.val];

    }
    case pair ret arg1 arg2 k1 k2 ARG1 ARG2 RET => {
      simp[Expr.eval, Expr.toOpenTree, OpenTree.eval, Expr.eval?];
      -- arg1
      let ARG1_VAL := EvalContext.toTypingContext_preimage_lookupByKind_some' ECTX_TCTX ARG1;
      simp[ARG1_VAL.property];
      let ARG1_MAPPED_VAL :=
        EvalContext.lookupByKind_map_some (f := fun {k} x => @var kindMotive k x) ARG1_VAL.property;
      simp[ARG1_MAPPED_VAL];
      -- arg2
      let ARG2_VAL := EvalContext.toTypingContext_preimage_lookupByKind_some' ECTX_TCTX ARG2;
      simp[ARG2_VAL.property];
      let ARG2_MAPPED_VAL :=
        EvalContext.lookupByKind_map_some (f := fun {k} x => @var kindMotive k x) ARG2_VAL.property;
      simp[ARG2_MAPPED_VAL];
      -- ret
      have RET_VAL := EvalContext.toTypingContext_preimage_none ECTX_TCTX RET;
      have RET_MAPPED_VAL := EvalContext.map_none (f := fun {k} x => @var kindMotive k x) RET_VAL;
      simp[RET_MAPPED_VAL, RET_VAL];
      simp[eval];
    }
  }


-- If the op is well-typed, then `Expr.eval?` will equal `OpenTree.eval <$> Expr.toOpenTree?`
theorem OpenTree.eval?_sound_open_ops_well_typed
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ectx : EvalContext kindMotive}
  {e: Expr .Os k}
  {treectx: EvalContext (OpenTree kindMotive)}
  (TREECTX: ValidTreeContext opFold pairFold ectx treectx)
  (TCTX: ectx.toTypingContext = tctx)
  (WT: ExprWellTyped tctx e) :
  (e.toOpenTree? treectx).map (OpenTree.eval kindMotive opFold pairFold) = e.eval? opFold pairFold ectx :=
  match e with
  | Expr.ops (kop := kop) op ops' => by {
    cases WT;
    case ops tctx' WT_OP TCTX_TO_TCTX' WT' => {
      simp[Expr.toOpenTree?]
      simp[Expr.eval, Expr.toOpenTree, OpenTree.eval, Expr.eval?];

      let TCTX_MAP : treectx.toTypingContext = tctx := by {
        apply ValidTreeContext.isTypingContext (TREECTX := TREECTX) (TCTX := TCTX);
      };

      have OP_EVAL?_LHS_SOME : Expr.eval? assign pair treectx op = .some (Expr.eval assign pair TCTX_MAP WT_OP) := by {
        apply Expr.eval_eval?_eq (EVAL := rfl);
      }
      simp_rw[OP_EVAL?_LHS_SOME];

      have OP_EVAL?_RHS_SOME : Expr.eval? opFold pairFold ectx op = .some (Expr.eval opFold pairFold TCTX WT_OP) := by {
        apply Expr.eval_eval?_eq (EVAL := rfl);
      }
      simp_rw[OP_EVAL?_RHS_SOME];

      have OP_EVAL_LHS_RHS_AGREE :
        (op.toOpenTree TCTX WT_OP).eval opFold pairFold = op.eval opFold pairFold TCTX WT_OP := by {
        apply OpenTree.eval_sound_open_op;
      }
      simp_rw[← OP_EVAL_LHS_RHS_AGREE];
      let ectx' := (ectx.bind (Expr.retVar op) kop
                      (eval kindMotive opFold pairFold (Expr.toOpenTree TCTX WT_OP)));
      have TCTX' : ectx'.toTypingContext = tctx' := by {
        simp[← TCTX_TO_TCTX'];
        apply EvalContext.toTypingContext_bind (TCTX := TCTX);
      }
      let treectx' := treectx.bind op.retVar kop ((op.toOpenTree TCTX WT_OP));
      have TREECTX'_VALID_FOR_ECTX' :  ValidTreeContext opFold pairFold ectx' treectx' := by {
        apply ValidTreeContext.bind <;> try assumption;
        rfl;
      }

      have HIND := OpenTree.eval?_sound_open_ops_well_typed opFold pairFold (e := ops')
        (treectx := treectx')
        TREECTX'_VALID_FOR_ECTX' TCTX' WT';
      simp[← HIND];

      -- morally, this is true because the LHS is the rest of evaluating
      sorry


      -- simp[Expr.eval, Expr.toOpenTree, OpenTree.eval, Expr.eval?];

      -- have EVAL_OP := Expr.eval?_succeeds_if_expr_wellformed (kindMotive := OpenTree kindMotive)
      --   (opFold := assign)
      --   (pairFold := pair)
      --   (ectx := treectx) (e := op) (tctx := tctx)
      --   (TCTX := by {
      --     simp;
      --     apply ValidTreeContext.isTypingContext (TREECTX := TREECTX) (TCTX := TCTX);
      --   }) (WT := WT_OP)
      -- have ⟨eval_op, EVAL_OP⟩ := EVAL_OP;
      -- simp[EVAL_OP];
      -- suffices EVAL_TO_OPEN_TREE_AGREE :
      --   Expr.eval (fun {i o} => assign) (fun {i i'} => pair) TCTX_MAP WT_OP = Expr.toOpenTree TCTX WT_OP by {
      --     simp_rw[EVAL_TO_OPEN_TREE_AGREE];
      -- }
      -- simp[Expr.toOpenTree];

      -- sorry;

      }
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

-- if we know that 'op1' is well typed at 'ectx', and that 'op2' is well typed at
-- 'ectx.bind op1.retVar k val', then 'op2' is well typed at
theorem ExprWellTyped.bind
  {ectx : EvalContext kindMotive}
  {op: Expr .O k}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (WT1: ExprWellTyped ectx.toTypingContext op)
  (v: kindMotive k)
  (WT2: ExprWellTyped (TypingContext.bind (Expr.retVar op) k (EvalContext.toTypingContext ectx)) op2) :
    ExprWellTyped (EvalContext.toTypingContext (ectx.bind  op.retVar k v)) op2 := by {
    have H : (EvalContext.toTypingContext (ectx.bind op.retVar k v)) =
      TypingContext.bind (Expr.retVar op) k (EvalContext.toTypingContext ectx) := by {
        simp[EvalContext.toTypingContext_bind (TCTX := rfl)];
      };
    rw[H];
    assumption;
}


theorem ExprWellTyped.transport_along_eq
{ctx ctx': TypingContext}
{e: Expr ek k}
(WT: ExprWellTyped ctx e)
(Eq: ctx = ctx') :
ExprWellTyped ctx' e := by {
  subst Eq;
  assumption;
}


end OpenEvaluation
-- Annoying, this does not help, since it does not let us talk about program fragments.
-- In theory, we could say that we have some kind of input

end ToTree