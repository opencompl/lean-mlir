-- We create a verified conversion from SSA minus Regions (ie, a sequence
-- of let bindings) into an expression tree. We prove that this
-- conversion preserves program semantics.
import Aesop

inductive Kind where
| int
| unit
| pair : Kind → Kind → Kind
deriving DecidableEq

inductive ExprKind
| O
| Os
abbrev Var := String

inductive OpKind : Kind →Kind → Type
| add: OpKind int int
| const : OpKind unit int
| sub: OpKind int int


inductive Expr : ExprKind → Type where
| assign (ret : Var) (kind: OpKind i o) (arg: Var) : Expr .O
| pair (ret : Var) (arg1: Var) (k1: Kind) (arg2 : Var) (k2: Kind) : Expr .O
| ops: Expr .O → Expr .Os → Expr .Os

-- the return kind of the expression. ie, what is the type that this expression computes.
abbrev Expr.retKind : Expr k → Kind
| .assign (o := o) .. => o
| .pair (k1 := k1) (k2 := k2) .. => Kind.pair k1 k2
| .ops _ o2 => o2.retKind

abbrev Op := Expr .O
abbrev Ops := Expr .Os


abbrev Op.retKind: Op → Kind := Expr.retKind

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

-- A DefContext that tracks which variables have been defined.
def DefContext := String → Option Kind

def DefContext.bottom : DefContext := fun _ => .none

def DefContext.bind (bindname : String) (bindkind: Kind) (ctx: DefContext): DefContext :=
  fun name => if name = bindname then bindkind else ctx name

inductive ExprWellFormed : DefContext → Expr kind → DefContext → Prop where
| assign
    {ret arg : Var}
    {ctx : DefContext}
    {kind: OpKind i o}
    (ARG : ctx arg = .some i)
    (RET: ctx ret = .none) :
    ExprWellFormed ctx (Op.assign ret kind arg) (ctx.bind ret o)
| pair
  {ctx : DefContext}
  {ret arg1 arg2 : Var}
  {k1 k2 : Kind}
  (ARG1 : ctx arg1 = .some k1)
  (ARG2 : ctx arg2 = .some k2)
  (RET: ctx ret = .none) :
  ExprWellFormed ctx (Op.pair ret arg1 k1 arg2 k2) (ctx.bind ret (Kind.pair k1 k2))
| ops
  {ctxbegin ctxend : DefContext}
  ⦃ctxmid : DefContext⦄
  (WF1: ExprWellFormed ctxbegin op1 ctxmid)
  (WF2: ExprWellFormed ctxmid op2 ctxend) :
  ExprWellFormed ctxbegin (Expr.ops op1 op2) ctxend

def ExprWellFormed.compute : Expr kind → DefContext → Option DefContext
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
    Option.bind (ExprWellFormed.compute op1 ctx) (ExprWellFormed.compute op2)

-- (compute = true) => (stuff holds)
theorem ExprWellFormed.compute_implies_prop:
  ∀ (ctx ctx' : DefContext) (expr : Expr kind),
  .some ctx' = ExprWellFormed.compute expr ctx ->
  ExprWellFormed ctx expr ctx' := by {
  intros ctx ctx' expr;
  revert ctx ctx';
  induction expr;
  case assign ret kind arg => {
    intros ctx ctx' COMPUTE;
    simp[compute] at COMPUTE;
    aesop; constructor <;> aesop;
  }
  case pair ret arg1 arg2 => {
    intros ctx ctx' COMPUTE;
    simp[compute] at COMPUTE;
    aesop; constructor <;> aesop;
  }
  case ops o1 o2 IH1 IH2 => {
    intros ctx ctx'' COMPUTE;
    simp[compute] at COMPUTE;
    cases CTXO1:(compute o1 ctx) <;> simp[CTXO1] at COMPUTE; case some ctx' => {
      cases CTXO2:(compute o2 ctx') <;> simp[CTXO2] at COMPUTE; case some ctx''_2 => {
       -- | TODO @chris: how to write this nicer, to prevent the induction COMPUTE;
        induction COMPUTE; case refl => {
          apply ExprWellFormed.ops (ctxmid := ctx') <;> aesop;
        }
      }
    }
  }
}

theorem ExprWellFormed.prop_implies_compute:
  ∀ (ctx ctx' : DefContext) (expr : Expr kind),
  ExprWellFormed ctx expr ctx' ->
  .some ctx' = ExprWellFormed.compute expr ctx := by {
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
      specialize (IH1 _ _ WF1);
      specialize (IH2 _ _ WF2);
      cases OP1:(compute op1 ctx) <;> simp[OP1] at IH1;
      cases OP2:(compute op2 ctx') <;> simp[OP2] at IH2;
      aesop;
    }
  }
}

-- Reflection tactic to reflect the proof level 'ExprWellFormed'
-- into computation level 'ExprWellFormed.compute'
theorem ExprWellFormed.reflect :
  ∀ (ctx ctx' : DefContext) (expr : Expr kind),
  .some ctx' = ExprWellFormed.compute expr ctx <->
  ExprWellFormed ctx expr ctx' := by {
  intros ctx ctx' expr;
  constructor
  case mp => { apply ExprWellFormed.compute_implies_prop; }
  case mpr => { apply ExprWellFormed.prop_implies_compute; }
}

-- An expression is said to well formed if it is well formed
-- starting from the given context.
def Expr.wellFormed (e: Expr k) (ctx: DefContext := DefContext.bottom): Prop
  := ∃ ctx', ExprWellFormed ctx e ctx'


-- context necessary for evaluating expressions.
def EvalContext (kindMotive: Kind → Type) : Type
  := String → Option ((kind: Kind) × (kindMotive kind))

-- empty evaluation context.
def EvalContext.bottom (kindMotive: Kind → Type) : EvalContext kindMotive := fun _  => .none

-- add a binding into the evaluation context.
def EvalContext.bind {kindMotive: Kind → Type}
  (bindname : String) (bindk: Kind) (bindv: kindMotive bindk)
  (ctx: EvalContext kindMotive) : EvalContext kindMotive :=
  fun name => if (bindname = name) then .some ⟨bindk, bindv⟩ else ctx name

def EvalContext.lookupByKind {kindMotive: Kind → Type} (ctx: EvalContext kindMotive)
  (name : String) (needlekind: Kind) : Option (kindMotive needlekind) :=
  match ctx name with
  | .none => .none
  | .some ⟨k, kv⟩ =>
      if NEEDLE : needlekind = k
      then NEEDLE ▸ kv
      else .none

/-
TODO: why is this 'noncomputable' ?
failed to compile definition, consider marking it as 'noncomputable'
because it depends on 'Expr.fold?.match_3',
and it does not have executable code
-/
noncomputable def Expr.fold? -- version of fold that returns option.
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ctx : EvalContext kindMotive): (e : Expr ek) → Option (kindMotive e.retKind)
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
| .ops o1 o2 =>
  match o1.fold? opFold pairFold ctx with
  | .none => .none
  | .some v =>
      let ctx' := ctx.bind (Op.ret o1) o1.retKind v
      o2.fold? opFold pairFold ctx'
#print Expr.fold?.match_3



namespace extractFromOption
/-
Show how having a partial computation, plus a proof that the partial computation
is in fact total allows us to extract out the value of the partial computation.
-/
def partialcomp : Option Nat := .some 42
theorem partialcomp_succeeds: partialcomp.isSome = true := by {
  simp[partialcomp];
}

def extraction : Nat :=
  match H : partialcomp with
  | .some v => v
  | .none => by {
      have CONTRA := partialcomp_succeeds;
      rw[H] at CONTRA;
      simp at CONTRA;
  }
#reduce extraction -- 42
end extractFromOption

-- Treat an eval context as a def context by ignoring the eval value.
def EvalContext.toDefContext (ctx: EvalContext kindMotive): DefContext :=
  fun name =>
    match ctx name with
    | .none => .none
    | .some ⟨k, _kv⟩ => k

theorem EvalContext.toDefContext.agreement:
∀ ⦃ctx: EvalContext kindMotive⦄  ⦃name: String⦄,
  (ctx name).isSome ↔ (ctx.toDefContext name).isSome := by {
    intros ctx name;
    simp[toDefContext];
    cases ctx name <;> simp;
}
-- 'fold?' will return a 'some' value
theorem Expr.fold?_succeeds_iff_expr_wellformed
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (evalctx : EvalContext kindMotive)
  (defctx: DefContext)
  (DEFCTX: evalctx.toDefContext = defctx)
  (e : Expr ek)
  (WF: e.wellFormed defctx) : (e.fold? opFold pairFold evalctx).isSome := by {
  simp[wellFormed] at WF;
  have ⟨ctx', WF'⟩ := WF;
  clear WF;
  induction WF';
  case assign i o ret arg ctx kind ARG RET  => {
    simp[fold?];
    simp[EvalContext.lookupByKind];
    simp[EvalContext.toDefContext] at DEFCTX;
    cases ARG_NONE:(evalctx arg) <;> aesop;
  }
  case pair evalctx_dctx ret arg1 arg2 k1' k2' ARG1 ARG2 RET => {
    simp[fold?];
    simp[EvalContext.lookupByKind];
    simp[EvalContext.toDefContext] at DEFCTX;
    cases ARG1_SOME:(evalctx arg1) <;> simp;
    case none => { aesop; }
    case some arg1_val => {
        have K1_ARG1 : k1' = arg1_val.fst := by aesop;
        cases K1_ARG1; case refl => {
          simp;
          cases ARG2_SOME:(evalctx arg2) <;> simp;
          case none => { aesop; }
          case some arg2_val => {
            have K2_ARG2 : k2' = arg2_val.fst := by aesop;
            cases K2_ARG2; case refl => {
              simp;
              cases RET_NONE:(evalctx ret) <;> simp;
              case some v => { aesop };
            }
          }
        }
        
    }
  }
}

-- Expression tree which produces a value of kind 'Kind'.
-- This is the initial algebra of the fold.
inductive Tree : Kind → Type where
| assign:  OpKind i o → Tree i → Tree o
| pair: Tree a → Tree b → Tree (Kind.pair a b)


noncomputable def Expr.toTree (ctx: EvalContext Tree) : (e : Expr ek) → Option (Tree (e.retKind)) :=
  Expr.fold? (Tree.assign) (Tree.pair) ctx