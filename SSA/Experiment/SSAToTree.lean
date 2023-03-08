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

notation ctx "[" bindname " ↦ " bindk  "]" => TypingContext.bind bindname bindk ctx

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

-- Treat an eval context as a def context by ignoring the eval value.
@[coe]
def EvalContext.toTypingContext (ctx: EvalContext kindMotive): TypingContext :=
  fun name =>
    match ctx name with
    | .none => .none
    | .some ⟨k, _kv⟩ => k

-- coerce an eval context to a typing context.
instance : Coe (EvalContext kindMotive) TypingContext := ⟨EvalContext.toTypingContext⟩


-- If 'tctx' has a value at 'name', then so does 'ectx' at 'name' if
-- 'tctx' came from 'ectx'.
def EvalContext.toTypingContext_preimage_some
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
        have ⟨ectx_val, ECTX_KEY⟩:= EvalContext.toTypingContext_preimage_some TCTX TCTX_KEY;
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
      have ⟨arg_val, ARG_VAL⟩ := EvalContext.toTypingContext_preimage_some TCTX ARG;
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
      have ⟨arg1_val, ARG1_VAL⟩ := EvalContext.toTypingContext_preimage_some TCTX ARG1;
      have ⟨arg2_val, ARG2_VAL⟩ := EvalContext.toTypingContext_preimage_some TCTX ARG2;
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


-- Unfold `Expr.eval` for `Expr.ops`.
theorem Expr.eval_ops
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ectx ectx' : EvalContext kindMotive)
  (o1: Expr .O k1)
  (o2: Expr .Os k2)
  (tctx : TypingContext)
  (WT_OPS: ExprWellTyped tctx (Expr.ops o1 o2))
  (WT_OP1 : ExprWellTyped tctx o1)
  (WT_OP2: ExprWellTyped tctx' o2)
  (ECTX_TCTX: ectx.toTypingContext = tctx)
  (ECTX': ectx' = ectx.bind o1.retVar k1 (Expr.eval opFold pairFold (e := o1) (ectx := ectx) (tctx := tctx) ECTX_TCTX WT_OP1))
  (TCTX': tctx' = tctx.bind o1.retVar k1)
  (ECTX'_TCTX': ectx'.toTypingContext = tctx'):
  Expr.eval (k := k2)  opFold pairFold (e := Expr.ops o1 o2) (ectx := ectx) (tctx := tctx) ECTX_TCTX WT_OPS =
    @Expr.eval kindMotive ectx' opFold pairFold (e := o2)  (tctx := tctx') ECTX'_TCTX' WT_OP2 := by {
      subst ECTX';
      subst TCTX';
      simp[Expr.eval];
      simp[Expr.eval?_ops];
      congr;
      have E1VAL :
        expr⟦⟧?[fun {i o} => opFold, fun {i i'} => pairFold ; ectx ⊧ ⟦o1⟧] =
        Expr.eval opFold pairFold (e := o1) (ectx := ectx) (tctx := tctx) ECTX_TCTX WT_OP1 := by {
          simp[Expr.eval];
        };
        simp[E1VAL];
}


theorem Option.get_none_elim: (Option.get none P = v) → False := by {
    simp at P;
  }


-- show under what conditions eval? and 'eval' agree.
theorem Expr.eval_implies_eval?
  {ectx : EvalContext kindMotive}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {e: Expr ek k}
  {TCTX: ectx.toTypingContext = tctx}
  {WT: ExprWellTyped tctx e} :
  (EVAL: Expr.eval opFold pairFold TCTX WT = v) →
  (e.eval? opFold pairFold ectx = .some v) := by {
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

-- unfold a `toOpenTree` of `Expr.ops`
def Expr.toOpenTree_ops
  (kindMotive: Kind → Type)
  (treectx treectx' : EvalContext (OpenTree kindMotive))
  (o1: Expr .O k1)
  (o2: Expr .Os k2)
  (WT_OPS: ExprWellTyped tctx (Expr.ops o1 o2))
  (WT_OP1 : ExprWellTyped tctx o1)
  (WT_OP2: ExprWellTyped tctx' o2)
  (TREECTX_TCTX: treectx.toTypingContext = tctx)
  (TREECTX': treectx' = treectx.bind o1.retVar k1 (o1.toOpenTree TREECTX_TCTX WT_OP1))
  (TCTX': tctx' = tctx.bind o1.retVar k1)
  (TREECTX'_TCTX':treectx'.toTypingContext = tctx') :
  (Expr.ops o1 o2).toOpenTree TREECTX_TCTX WT_OPS =
    o2.toOpenTree TREECTX'_TCTX' WT_OP2 := by {
      simp[toOpenTree];
      apply Expr.eval_ops <;> assumption;
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


-- In hindsight, it was probably easier to separately define evaluation and converting to a tree.
-- a tree context 'treectx' is valid iff it agrees with the value of 'ectx'
-- wherever ectx is evaluated.
-- TODO: this is a trashfire. It is not worth the "proof reuse" we get out of
-- this unification. As usual, @lyxsia has impeccable taste when it comes to dependent typing.
structure ValidTreeContext
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ectx: EvalContext kindMotive) (treectx: EvalContext (OpenTree kindMotive))  where
    ectx_to_treectx :
        ∀ (key: String) (kind: Kind) (val: kindMotive kind),
          ectx key = .some ⟨kind, val⟩ →
        { treeval : OpenTree kindMotive kind //
          treectx key = .some ⟨kind, treeval⟩ ∧ OpenTree.eval kindMotive opFold pairFold treeval = val }
    treectx_to_ectx :
        ∀ (key: String) (kind: Kind) (treeval: OpenTree kindMotive kind),
          treectx key = .some ⟨kind, treeval⟩ →
          { val : kindMotive kind  //
              ectx key = .some ⟨kind, val⟩ ∧ OpenTree.eval kindMotive opFold pairFold treeval = val }

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
        have ECTX_VAL := (TREECTX.treectx_to_ectx key kind treeval TREECTX_KEY);
        have ⟨ectx_val, ECTX_KEY', _⟩ := ECTX_VAL;
        simp[ECTX_KEY'] at ECTX_KEY;
      }
    }
    case h.some kind_val => {
      have ⟨kind, val⟩ := kind_val;
      have ⟨val_tree, TREE_KEY, TREE_EVAL⟩ := (TREECTX.ectx_to_treectx key kind val ECTX_KEY);
      simp[TREE_KEY, TREE_EVAL];
      simp[← TCTX, ECTX_KEY];
    }
  }

-- using (EvalContext.map var) provides a valid tree context.
theorem ValidTreeContext.map_is_valid_tree_context
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ectx : EvalContext kindMotive):
  ValidTreeContext opFold pairFold ectx (ectx.map (OpenTree.var )) := by {
    constructor;
    case ectx_to_treectx => {
    intros key kind val;
      intros  H;
      simp[ValidTreeContext, EvalContext.map];
      simp[H];
      simp[OpenTree.eval];
      apply Subtype.mk (val := OpenTree.var val);
      simp[OpenTree.eval];
    }
    case treectx_to_ectx => {
      intros key kind treeval;
      intros ECTX;
      simp[ValidTreeContext, EvalContext.map] at ECTX ⊢;
      cases KEY:(ectx key) <;> simp [KEY] at ECTX ⊢;
      case some val => {
        let ⟨VAL_FST, VAL_SND⟩ := ECTX;
        induction VAL_FST;
        case refl => {
          cases VAL_SND;
          case refl => {
            simp at ECTX;
            apply Subtype.mk (val := val.snd);
            simp[OpenTree.eval];
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
  constructor;
  case ectx_to_treectx => {
    intros key kind val;
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
      apply Subtype.mk (val := tree) (property := by simp[TREE])
    }
    case neg => {
      simp[KEY] at H TREECTX ⊢;
      have H := TREECTX.ectx_to_treectx key kind val H;
      apply H;
    }
  }
  case treectx_to_ectx => {
    intros key kind tree;
    simp;
    intros TREECTX_KEY;

    simp [EvalContext.bind] at TREECTX_KEY TREECTX_KEY ⊢;
    by_cases KEY:(key = name);
    case pos => {
      subst KEY;
      simp at TREECTX_KEY ⊢;
      have ⟨KOP, VAR⟩ := TREECTX_KEY;
      subst KOP;
      simp at VAR ⊢;
      subst VAR;
      subst TREE;
      apply Subtype.mk (val :=  evaltree[kindMotive, fun {i o} => opFold,fun {i i'} => pairFold ⊧ ⟦tree⟧])
                    (property := by simp);
    }
    case neg => {
      simp[KEY] at TREECTX_KEY ⊢;
      subst TREE;
      have H := TREECTX.treectx_to_ectx key kind tree TREECTX_KEY;
      simp at H;
      exact H;
    }
  }
}


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
      -- ARG:
      -- we have an ectx since the assignment is well typed
      have ⟨ectx_at_arg, ECTX_AT_ARG⟩ := EvalContext.toTypingContext_preimage_some ECTX_TCTX ARG_WT;
      -- since ectx ~ treectx, we have treeval that associates correctly with ectx_at_arg
      have ⟨tctx_at_arg, TCTX_AT_ARG, TCTX_AT_ARG_VAL⟩ :=
          TREECTX_ECTX.ectx_to_treectx arg argk ectx_at_arg ECTX_AT_ARG;
      simp[Expr.eval, Expr.toOpenTree, OpenTree.eval, Expr.eval?, EvalContext.lookupByKind];
      simp[ECTX_AT_ARG, TCTX_AT_ARG, TCTX_AT_ARG_VAL];
      -- RET:
      -- ectx, treectx at ret have none since we are well typed.
      have ECTX_AT_RET := EvalContext.toTypingContext_preimage_none ECTX_TCTX RET_WT;
      have TREECTX_AT_RET := EvalContext.toTypingContext_preimage_none TREECTX_TCTX RET_WT;
      simp[ECTX_AT_RET, TREECTX_AT_RET];
      simp[OpenTree.eval];
      -- COMMUTES:
      -- use correspondence between ectx and treectx to get the value of the argument.
      rw[←TCTX_AT_ARG_VAL];
    }
    case pair ret arg1 arg2 k1 k2 ARG1 ARG2 RET => {
      -- ARG1:
      -- we have an ectx since the assignment is well typed
      have ⟨ectx_at_arg1, ECTX_AT_ARG1⟩ := EvalContext.toTypingContext_preimage_some ECTX_TCTX ARG1;
      -- since ectx ~ treectx, we have treeval that associates correctly with ectx_at_arg
      have ⟨tctx_at_arg1, TCTX_AT_ARG1, TCTX_AT_ARG1_VAL⟩ :=
          TREECTX_ECTX.ectx_to_treectx arg1 k1 ectx_at_arg1 ECTX_AT_ARG1;
      simp[Expr.eval, Expr.toOpenTree, OpenTree.eval, Expr.eval?, EvalContext.lookupByKind];
      simp[ECTX_AT_ARG1, TCTX_AT_ARG1, TCTX_AT_ARG1_VAL];

      -- ARG2:
      -- we have an ectx since the assignment is well typed
      have ⟨ectx_at_arg2, ECTX_AT_ARG2⟩ := EvalContext.toTypingContext_preimage_some ECTX_TCTX ARG2;
      -- since ectx ~ treectx, we have treeval that associates correctly with ectx_at_arg
      have ⟨tctx_at_arg2, TCTX_AT_ARG2, TCTX_AT_ARG2_VAL⟩ :=
          TREECTX_ECTX.ectx_to_treectx arg2 k2 ectx_at_arg2 ECTX_AT_ARG2;
      simp[Expr.eval, Expr.toOpenTree, OpenTree.eval, Expr.eval?, EvalContext.lookupByKind];
      simp[ECTX_AT_ARG2, TCTX_AT_ARG2, TCTX_AT_ARG2_VAL];

      -- RET:
      -- ectx, treectx at ret have none since we are well typed.
      have ECTX_AT_RET := EvalContext.toTypingContext_preimage_none ECTX_TCTX RET;
      have TREECTX_AT_RET := EvalContext.toTypingContext_preimage_none TREECTX_TCTX RET;
      simp[ECTX_AT_RET, TREECTX_AT_RET];
      simp[OpenTree.eval];
      -- COMMUTES:
      -- use correspondence between ectx and treectx to get the value of the argument.
      rw[←TCTX_AT_ARG1_VAL, ← TCTX_AT_ARG2_VAL];
    }
  }


theorem OpenTree.eval_sound_open_ops
  {ectx : EvalContext kindMotive}
  {e: Expr .Os k}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {tctx: TypingContext}
  {treectx: EvalContext (OpenTree kindMotive)}
  (ECTX_TCTX: ↑ectx = tctx)
  (TREECTX_TCTX: treectx = tctx)
  (WT: ExprWellTyped tctx e)
  {TREECTX_ECTX: ValidTreeContext opFold pairFold ectx treectx}:
  (e.toOpenTree TREECTX_TCTX WT).eval opFold pairFold = e.eval opFold pairFold ECTX_TCTX WT :=
    match WT with
    | .ops (op1 := op1) (op2 := ops2) (ctxmid := ctxmid) (WT1 := WT1) (CTXMID := CTXMID) (WT2 := WT2) => by {
      rw[Expr.eval_ops (WT_OP1 := WT1) (WT_OP2 := WT2) (ECTX' := rfl) (TCTX' := by simp[CTXMID])
          (ECTX'_TCTX' := by {
            rw[← CTXMID];
            rw[EvalContext.toTypingContext_bind (TCTX := ECTX_TCTX)];
          }) ];
      rw[Expr.toOpenTree_ops (WT_OP1 := WT1) (WT_OP2 := WT2) (TREECTX_TCTX := TREECTX_TCTX) (TREECTX' := rfl) (TCTX' := by simp[CTXMID])
          (TREECTX'_TCTX' := by {
            rw[← CTXMID];
            rw[EvalContext.toTypingContext_bind (TCTX := TREECTX_TCTX)];
          })
        ];

      have EVAL_OP : (op1.toOpenTree TREECTX_TCTX _).eval opFold pairFold = op1.eval opFold pairFold ECTX_TCTX WT1 := by {
        apply OpenTree.eval_sound_open_op;
        assumption;
      }

      simp_rw[← EVAL_OP];
      simp;
      apply OpenTree.eval_sound_open_ops;
      apply ValidTreeContext.bind <;> try assumption;
      simp[EVAL_OP];
    }

-- evaluation of any operation is sound if the evalcontext and treecontext match.
theorem OpenTree.eval_sound
  {ectx : EvalContext kindMotive}
  {e: Expr ek k}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {tctx: TypingContext}
  {treectx: EvalContext (OpenTree kindMotive)}
  (ECTX_TCTX: ↑ectx = tctx)
  (TREECTX_TCTX: treectx = tctx)
  (WT: ExprWellTyped tctx e)
  {TREECTX_ECTX: ValidTreeContext opFold pairFold ectx treectx}:
  (e.toOpenTree TREECTX_TCTX WT).eval opFold pairFold = e.eval opFold pairFold ECTX_TCTX WT :=
  match ek with
  | .O => by { apply OpenTree.eval_sound_open_op; assumption; }
  | .Os => by { apply OpenTree.eval_sound_open_ops; assumption; }


-- main theorem: converting to an open tree and evaluating is sound
def diagram_commutes
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {ectx : EvalContext kindMotive}
  {e: Expr .Os k}
  (TCTX: ectx.toTypingContext = tctx)
  (WT: ExprWellTyped tctx e) :
  (e.toOpenTree (treectx := ectx.map OpenTree.var)
    (TCTX := EvalContext.toTypingContext_map _ _ TCTX) (WT := WT)).eval kindMotive opFold pairFold =
  e.eval opFold pairFold TCTX WT := by {
      have TREECTX := ValidTreeContext.map_is_valid_tree_context opFold pairFold ectx;
      apply OpenTree.eval_sound; assumption;
}

end OpenEvaluation

end ToTree