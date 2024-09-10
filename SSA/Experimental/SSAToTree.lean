/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- We create a verified conversion from SSA minus Regions (ie, a sequence
-- of let bindings) into an expression tree. We prove that this
-- conversion preserves program semantics.
import Mathlib.Data.Set.Basic
import Mathlib.Data.Set.Function
import Mathlib.Data.Set.Image
import Mathlib.Tactic.Linarith
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
| add: OpKind (.pair .int .int) .int
| const : OpKind .unit .int
| sub: OpKind (.pair .int .int) .int
| negate: OpKind .int .int


inductive Expr : ExprKind → Kind → Type where
| assign (ret : Var) (kind: OpKind i o) (arg: Var) : Expr .O o -- ret = kind (arg)
| pair (ret : Var) (arg1: Var) (k1: Kind) (arg2 : Var) (k2: Kind) : Expr .O (Kind.pair k1 k2) -- ret = (arg1, arg2)
| ops: Expr .O kop → Expr .Os ks → Expr .Os ks -- op ;; ops.
| single: Expr .O kop → Expr .Os kop

-- the return variable of the expression. ie, what is the
-- name of the final value that this expression computes.
abbrev Expr.retVar : Expr ek k → Var
| .assign (ret := ret) .. => ret
| .pair (ret := ret)  .. => ret
| .ops _ o2 => o2.retVar
| .single o => o.retVar

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
@[aesop constructors safe, aesop cases safe]
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
| single
  {ctx : TypingContext}
  (op: Op k)
  (WT: ExprWellTyped ctx op) :
  ExprWellTyped ctx (Expr.single op)

notation "wt[" ctx " ⊢ " e "]" => ExprWellTyped ctx e

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
| (.ops op1 op2 (kop := kop)), ctx =>
    match ExprWellTyped.compute op1 ctx with
    | false => false
    | true => ExprWellTyped.compute op2 (ctx.bind op1.retVar kop)
| .single op, ctx => ExprWellTyped.compute op ctx

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
  case single op IH => {
    intros ctx WELLFORMED;
    simp[compute];
    cases WELLFORMED;
    case single WT => {
      simp[IH WT];
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
    case single op WT IH => {
      cases wf2;
      case single WT' => {
        have IH := IH WT';
        simp[proofIrrel];
        exact IH;
      }
    }
  }
⟩

-- -- (compute = true) => (stuff holds)
theorem ExprWellTyped.compute_implies_prop:
  ∀ {ctx : TypingContext} {expr : Expr ek k},
  ExprWellTyped.compute expr ctx ->
  ExprWellTyped ctx expr := by {
  intros ctx expr;
  revert ctx;
  induction expr;
  case assign i o ret kind arg  => {
    intros ctx COMPUTE;
    simp[compute] at COMPUTE;
    cases RET:(ctx ret) <;> simp[RET] at COMPUTE; case none => {
      cases ARG:(ctx arg) <;> simp[ARG] at COMPUTE; case some argk => {
        constructor <;> try assumption;
        case ARG => {
            by_cases VAL:(argk = i) <;> simp[VAL] at COMPUTE;
            aesop
        }
      }
    }
  }
  case pair ret arg1 k1 arg2 k2 => {
    intros ctx COMPUTE;
    simp[compute] at COMPUTE;
    cases RET:(ctx ret) <;> simp[RET] at COMPUTE; case none => {
      cases ARG1:(ctx arg1) <;> simp[ARG1] at COMPUTE; case some arg1k => {
        cases ARG2:(ctx arg2) <;> simp[ARG2] at COMPUTE; case some arg2k => {
          by_cases VAL1:(arg1k = k1) <;> simp[VAL1] at COMPUTE;
          by_cases VAL2:(arg2k = k2) <;> simp[VAL2] at COMPUTE;
          constructor <;> try aesop;
        }
      }
    }
  }
  case ops kop ks o1 o2 IH1 IH2 => {
    intros ctx  COMPUTE;
    simp[compute] at COMPUTE;
    cases CTXO1:(compute o1 ctx) <;> simp[CTXO1] at COMPUTE; case true => {
      cases CTXO2:(compute o2 (ctx[Expr.retVar o1 ↦ kop])) <;> simp[CTXO2] at COMPUTE; case  true => {
        constructor <;> aesop
      }
    }
  }
  case single op IH => {
    intros ctx COMPUTE;
    simp[compute] at COMPUTE;
    cases CTXOP:(compute op ctx) <;> simp[CTXOP] at COMPUTE; case true => {
      constructor; aesop
    }
  }
}


/-
TODO: make a section and use `variable` for reuse
-/

-- context necessary for evaluating expressions.
def EvalContext (kindMotive: Kind → Type) : Type
  := String → Option ((kind: Kind) × (kindMotive kind))

def EvalContext! (kindMotive: Kind → Type) : Type
  := String → (kind: Kind) → (kindMotive kind)


-- empty evaluation context.
def EvalContext.bottom (kindMotive: Kind → Type) : EvalContext kindMotive := fun _  => .none

-- add a binding into the evaluation context.
def EvalContext.bind {kindMotive: Kind → Type}
  (bindname : String) (bindk: Kind) (bindv: kindMotive bindk)
  (ctx: EvalContext kindMotive) : EvalContext kindMotive :=
  fun name => if (name = bindname) then .some ⟨bindk, bindv⟩ else ctx name

def EvalContext!.bind {kindMotive: Kind → Type}
  (bindname : String) (bindk: Kind) (bindv: kindMotive bindk)
  (ctx: EvalContext! kindMotive) : EvalContext! kindMotive :=
  fun name kind => if (name = bindname) then if H : (kind = bindk)  then H ▸ bindv else ctx name kind else ctx name kind

notation ctx "[" bindname ":" bindk " ↦ "  bindv  "]" => EvalContext.bind bindname bindk bindv ctx

-- lookup a binding by both name and kind.
@[simp]
def EvalContext.lookupByKind {kindMotive: Kind → Type} (ctx: EvalContext kindMotive)
  (name : String) (needlekind: Kind) : Option (kindMotive needlekind) :=
  match ctx name with
  | .none => .none
  | .some ⟨k, kv⟩ =>
      if NEEDLE : needlekind = k
      then NEEDLE ▸ kv
      else .none

@[simp]
def EvalContext.lookupByKind! {kindMotive: Kind → Type} (ctx: EvalContext! kindMotive)
  (name : String) (needlekind: Kind) (default: (k: Kind) → kindMotive k) : Option (kindMotive needlekind) :=
    ctx name needlekind


notation ctx "[" name ":" bindk "]?" => EvalContext.lookupByKind ctx name bindk


-- Simplify `lookupByKind` when we have a syntactically
-- matching `lookup`result.
@[aesop destruct safe]
theorem EvalContext.lookupByKind_lookup_some_inv {kindMotive: Kind → Type} {ectx: EvalContext kindMotive}
  {k: Kind} {v: kindMotive k} {name: String}
  (LOOKUP: ectx.lookupByKind name k = .some v) :
  ectx name = some { fst := k, snd := v } := by {
    simp[EvalContext.lookupByKind, LOOKUP] at LOOKUP ⊢;
    aesop;
  }

-- Treat an eval context as a def context by ignoring the eval value.
@[coe, aesop safe]
def EvalContext.toTypingContext (ctx: EvalContext kindMotive): TypingContext :=
  fun name =>
    match ctx name with
    | .none => .none
    | .some ⟨k, _kv⟩ => k

-- coerce an eval context to a typing context.
instance : Coe (EvalContext kindMotive) TypingContext := ⟨EvalContext.toTypingContext⟩


-- If 'tctx' has a value at 'name', then so does 'ectx' at 'name' if
-- 'tctx' came from 'ectx'.
@[aesop safe]
def EvalContext.toTypingContext_preimage_some
  { kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {tctx: TypingContext}
  (TCTX: EvalContext.toTypingContext ectx = tctx)
  {name : String}
  {kind : Kind}
  (LOOKUP: tctx name = .some kind) :
  { val : kindMotive kind // ectx name = .some ⟨kind, val⟩ } := by {
    simp[toTypingContext] at TCTX; aesop;
}


@[aesop safe]
def EvalContext.toTypingContext_lookupByKind_preimage_some
  { kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {tctx: TypingContext}
  (TCTX: EvalContext.toTypingContext ectx = tctx)
  {name : String}
  {kind : Kind}
  (LOOKUP: tctx name = .some kind) :
  { val : kindMotive kind // ectx.lookupByKind name kind = .some val } := by {
    simp[toTypingContext] at TCTX; aesop;
}

@[aesop norm]
theorem EvalContext.toTypingContext_preimage_none
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {tctx: TypingContext}
  (TCTX: EvalContext.toTypingContext ectx = tctx)
  {name : String}
  (LOOKUP: tctx name = .none) :
  ectx name = .none := by {
    simp[toTypingContext] at TCTX; aesop;
}

@[aesop norm]
theorem EvalContext.toTypingContext_preimage_none_inv
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  {ectx: EvalContext kindMotive}
  {tctx: TypingContext}
  (TCTX: EvalContext.toTypingContext ectx = tctx)
  {name : String}
  (LOOKUP: ectx name = .none) :
  tctx name = .none := by {
    simp[toTypingContext] at TCTX; aesop;

}




-- ((name, kind, val) :: ectx).toTypingContext = (name, kind) :: ectx.toTypingContext
-- Alternatively, 'toTypingContext' is a homomorphism of contexts.
@[aesop simp norm]
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
    -- | TODO: golf
    by_cases NAME:(key = arg) <;> simp[NAME]; aesop
}

@[aesop norm unfold 1000]
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
| .single o => o.eval? opFold pairFold ctx
notation "expr⟦⟧?[" opFold ", " pairFold " ; " ctx " ⊧ " "⟦" e "⟧" "]" => Expr.eval? opFold pairFold  ctx e

def Expr.eval!
  {kindMotive: Kind → Type} -- what each kind is compiled into.
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (default: (k: Kind) → kindMotive k)
  (ctx : EvalContext! kindMotive): (e : Expr ek k) → kindMotive k
| .assign (i := i) (o := o) ret opkind arg =>
    let argv := ctx arg i
    opFold opkind argv
| .pair ret arg1 k1 arg2 k2 =>
    let arg1v := ctx arg1 k1;
    let arg2v :=  ctx arg2 k2;
    pairFold arg1v arg2v
| .ops o1 o2 (kop := kop) => o2.eval! opFold pairFold default (ctx.bind o1.retVar kop (o1.eval! opFold pairFold default ctx))
| .single o => o.eval! opFold pairFold default ctx


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
    simp[eval?]; aesop;
  }

-- 'eval?' will return a 'some' value
-- Note that here, we must ford TCTX, since to perform induction on 'wellformed',
-- we need the indexes of 'wellformed' to be variables.
-- set_option trace.aesop.steps true in
@[aesop safe 1000]
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

      -- aesop
      -- TODO: how to have aesop automatically do this?
      have ⟨arg_val, ARG_VAL⟩ := EvalContext.toTypingContext_preimage_some TCTX ARG;
      have RET_VAL := EvalContext.toTypingContext_preimage_none TCTX RET;
      aesop  (options := { maxRuleApplicationDepth := 0, maxRuleApplications := 0, traceScript := true});
    }

    case pair tctx  ret arg1 arg2 k1 k2 ARG1 ARG2 RET  => {
      intros ectx TCTX;
      -- TODO: how to aesopify?
      have ⟨arg1_val, ARG1_VAL⟩ := EvalContext.toTypingContext_preimage_some TCTX ARG1;
      have ⟨arg2_val, ARG2_VAL⟩ := EvalContext.toTypingContext_preimage_some TCTX ARG2;
      have RET_VAL := EvalContext.toTypingContext_preimage_none TCTX RET;

      aesop  (options := { maxRuleApplicationDepth := 0, maxRuleApplications := 0, traceScript := true});
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
      -- TODO: how to aesopify?
    }
    case single o WT IH => {
      intros ectx TCTX;
      simp[eval?];
      apply IH TCTX;
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



-- Expression tree which produces a value of kind 'Kind'.
-- This is the initial algebra of the fold.
inductive OpenTree (kindMotive: Kind → Type) : Kind → Type where
| assign:  OpKind i o → OpenTree kindMotive i → OpenTree kindMotive o
| pair: OpenTree kindMotive a → OpenTree kindMotive b → OpenTree kindMotive (Kind.pair a b)
| var: {k: Kind} → kindMotive k → OpenTree kindMotive k

@[aesop norm unfold 1000]
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
@[aesop safe]
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
@[aesop norm unfold 1000]
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


theorem Option.get_none_elim: (Option.get none P = v) → False := by aesop

-- show under what conditions eval? and 'eval' agree.
@[aesop unsafe, aesop forward safe]
theorem Expr.eval_implies_eval?
  {ectx : EvalContext kindMotive}
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  {e: Expr ek k}
  {TCTX: ectx.toTypingContext = tctx}
  {WT: ExprWellTyped tctx e} :
  (EVAL: Expr.eval opFold pairFold TCTX WT = v) →
  (e.eval? opFold pairFold ectx = .some v) := by aesop

-- Convert an expression to a tree by folding into the tree algebra
@[aesop norm unfold 1000]
def Expr.toOpenTree? (treectx: EvalContext (OpenTree kindMotive)) (e : Expr ek k): Option (OpenTree kindMotive k) :=
    e.eval?
        (opFold := fun opk ti => OpenTree.assign (kindMotive := kindMotive) opk ti)
        (pairFold := fun  ti ti' => OpenTree.pair (kindMotive := kindMotive) ti ti')
        treectx


notation "expr→tree?[" treectx " ; " e "]" => Expr.toOpenTree? treectx e

-- Convert an expression to a tree by folding into the tree algebra
@[aesop norm unfold 1000]
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


abbrev Expr.toOpenTree! (treectx: EvalContext! (OpenTree kindMotive))
    (e : Expr ek k)
    (default: (k: Kind) → kindMotive k): OpenTree kindMotive k :=
    e.eval!
        (opFold := fun opk ti => OpenTree.assign opk ti)
        (pairFold := fun  ti ti' => OpenTree.pair ti ti')
        (default := fun k => OpenTree.var (default k))
        treectx

-- theorem Expr.toOpenTree_eq_toOpenTree! (treectx: EvalContext! (OpenTree kindMotive))
--     (e : Expr ek k)
--     (default: (k: Kind) → kindMotive k)
--     {TCTX: treectx.toTypingContext = tctx}
--     {WP: ExprWellTyped tctx e}:
--     e.toOpenTree TCTX WP = e.toOpenTree! treectx default := by sorry

-- unfold a `toOpenTree` of `Expr.ops`
@[aesop norm]
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
@[aesop norm unfold 1000]
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
@[aesop safe, aesop forward safe, aesop cases safe]
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

-- #print Aesop.Options
set_option trace.aesop.steps true in
set_option trace.aesop.steps.tree true in
set_option trace.aesop.steps.normalization
 true in
@[aesop safe, aesop forward safe]
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
        -- aesop -- how to make aesop use treecx_to_ectx?

        -- this is kind of annoying, I need to evaluate the tree value
        -- to get that the value we have is a legitimate value.
        have ECTX_VAL := (TREECTX.treectx_to_ectx key kind treeval TREECTX_KEY);
        aesop -- we need aesop to make use TREEECTX.treectx_to_ectx.
      }
    }
    case h.some kind_val => {
      have ⟨kind, val⟩ := kind_val;
      have ⟨val_tree, TREE_KEY, TREE_EVAL⟩ := (TREECTX.ectx_to_treectx key kind val ECTX_KEY);
      aesop -- how to make aesop use TREE_KEY?
    }
  }

-- using (EvalContext.map var) provides a valid tree context.
@[aesop safe forward, aesop safe]
theorem ValidTreeContext.map_is_valid_tree_context
  (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
  (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
  (ectx : EvalContext kindMotive):
  ValidTreeContext opFold pairFold ectx (ectx.map (OpenTree.var )) := by {
    constructor <;> aesop;
}

-- if `tree.eval = value`, then binding `key` to `tree` in `treectx` is maintains
-- the validity of the context
-- | This is un-aesopable.
@[aesop safe forward, aesop safe]
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
      -- aesop -- TODO: aesop doesn't even work at the last step!
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
    | .single (op := op) (WT := WT) => by {
      apply OpenTree.eval_sound_open_op <;> assumption
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

-- def diagram_commutes'
--   (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
--   (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
--   (default: (k: Kind) → kindMotive k)
--   {ectx : EvalContext kindMotive}
--   {e: Expr .Os k}
--   (TCTX: ectx.toTypingContext = tctx)
--   (WT: ExprWellTyped tctx e) :
--   (e.toOpenTree! (treectx := ectx.map OpenTree.var) default).eval kindMotive opFold pairFold =
--   e.eval opFold pairFold TCTX WT := by {
--       have TREECTX := ValidTreeContext.map_is_valid_tree_context opFold pairFold ectx;
--       sorry
--       -- apply OpenTree.eval_sound; assumption;
-- }

-- theorem Expr.eval_eq_eval!
--   (opFold: {i o: Kind} → OpKind i o → kindMotive i → kindMotive o)
--   (pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i'))
--   (default: (k: Kind) → kindMotive k)
--   {ectx : EvalContext kindMotive}
--   {e: Expr ek k}
--   (TCTX: ectx.toTypingContext = tctx)
--   (WT: ExprWellTyped tctx e) :
--   e.eval opFold pairFold TCTX WT = e.eval! opFold pairFold default ectx := by sorry

section EDSL

declare_syntax_cat dsl_op
declare_syntax_cat dsl_type
declare_syntax_cat dsl_ops
declare_syntax_cat dsl_region
declare_syntax_cat dsl_var
declare_syntax_cat dsl_var_name
declare_syntax_cat dsl_const
declare_syntax_cat dsl_kind

syntax sepBy1(ident, "×") :dsl_kind
syntax ident : dsl_var_name
syntax "%" dsl_var_name ":" dsl_kind : dsl_var
syntax dsl_var "="
      str
      ("("dsl_var ")")?
      ("[" dsl_region,* "]")?
      ("{" dsl_const "}")? ";": dsl_op
syntax "%" dsl_var_name "=" "tuple" "(" dsl_var "," dsl_var ")" ";": dsl_op
syntax num : dsl_const
syntax "{" ("^(" dsl_var ")" ":")?  dsl_op dsl_op*  "}" : dsl_region
syntax "[dsl_op|" dsl_op "]" : term
syntax "[dsl_ops|" dsl_op dsl_op* "]" : term
syntax "[dsl_region|" dsl_region "]" : term
syntax "[dsl_var|" dsl_var "]" : term
syntax "[dsl_kind|" dsl_kind "]" : term
syntax "[dsl_const|" dsl_const "]" : term
syntax "[dsl_var_name|" dsl_var_name "]" : term


-- @[simp]
-- def AST.Ops.fromList: Expr k1 → Expr k2 → Expr k2
-- | op, [] => .opsone op
-- | op, op'::ops => .opscons op (AST.Ops.fromList op' ops)

-- @[simp]
-- def AST.Regions.fromList: List Region → Regions
-- | [] => .regionsnil
-- | r :: rs => .regionscons r (AST.Regions.fromList rs)

open Lean Macro in
def parseKind (k: TSyntax `ident) : MacroM (TSyntax `term) :=
  match k.getId.toString with
  | "int" => `(AST.Kind.int)
  | "nat" => `(AST.Kind.nat)
  | unk => (Macro.throwErrorAt k s!"unknown kind '{unk}'")


open Lean Macro in
macro_rules
| `([dsl_kind| $[ $ks ]×* ]) => do
    if ks.isEmpty
    then `(AST.Kind.unit)
    else
      let mut out ← parseKind ks[ks.size - 1]!
      for k in ks.pop.reverse do
        let cur ← parseKind k
        out ← `(AST.Kind.pair $cur $out)
      return out
| `([dsl_kind| $$($q:term)]) => `(($q : Kind))

open Lean Macro in
macro_rules
| `([dsl_var_name| $name:ident ]) =>
      return (Lean.quote name.getId.toString : TSyntax `term)
| `([dsl_var_name| $$($q:term)]) => `(($q : String))

macro_rules
| `([dsl_var| %$name:dsl_var_name : $kind:dsl_kind]) => do
    `({ name := [dsl_var_name| $name],
        kind := [dsl_kind| $kind] : Var})
| `([dsl_var| $$($q:term)]) => `(($q : Var))

macro_rules
| `([dsl_ops| $op $ops*]) => do
   let op_term ← `([dsl_op| $op])
   let ops_term ← ops.mapM (fun op => `([dsl_op| $op ]))
   `(AST.Ops.fromList $op_term [ $ops_term,* ])

macro_rules
| `([dsl_ops| $$($q)]) => `(($q : Ops))

-- macro_rules
-- | `([dsl_region| { $[ ^( $arg:dsl_var ): ]? $op $ops* } ]) => do
--    let ops ← `([dsl_ops| $op $ops*])
--    match arg with
--    | .none => `(Expr.region Var.unit $ops)
--    | .some arg => do
--       let arg_term ← `([dsl_var| $arg ])
--       `(Expr.region $arg_term $ops)
-- | `([dsl_region| $$($q)]) => `(($q : Region))

-- macro_rules
-- | `([dsl_const| $x:num ]) => `(Const.int $x)
-- | `([dsl_const| $$($q)]) => `(($q : Const))

-- open Lean Syntax in
-- macro_rules
-- | `([dsl_op| $res:dsl_var = $name:str
--       $[ ( $arg:dsl_var ) ]?
--       $[ [ $rgns,* ] ]?
--       $[ { $const } ]?
--       ;
--       ]) => do
--       let res_term ← `([dsl_var| $res])
--       let arg_term ← match arg with
--           | .some arg => `([dsl_var| $arg])
--           | .none => `(AST.Var.unit)
--       let name_term := name
--       let rgns_term ← match rgns with
--         | .none => `(.regionsnil)
--         | .some rgns =>
--            let rgns ← rgns.getElems.mapM (fun stx => `([dsl_region| $stx]))
--            `(AST.Regions.fromList [ $rgns,* ])
--       let const_term ←
--         match const with
--         | .none => `(Const.unit)
--         | .some c => `([dsl_const| $c])
--       `(Expr.op $res_term (OpName.fromString ($name_term : String)) $arg_term $rgns_term $const_term)
-- | `([dsl_op| $$($q)]) => `(($q : Op))

-- macro_rules
-- | `([dsl_op| %$res:dsl_var_name = tuple ( $arg1:dsl_var , $arg2:dsl_var) ; ]) => do
--     let res_term ← `([dsl_var_name| $res])
--     let arg1_term ← `([dsl_var| $arg1 ])
--     let arg2_term ← `([dsl_var| $arg2 ])
--     `(Expr.tuple $res_term $arg1_term $arg2_term)


end EDSL

section Examples


@[simp, reducible]
def Kind.eval : Kind → Type
| .int => Int
| .pair k1 k2 => k1.eval × k2.eval
| .unit => Unit

def OpKind.opFold {i o : Kind}: OpKind i o → i.eval → o.eval
| .add, (x, y) => x + y
| .sub, (x, y) => x - y
| .negate, x => -x
| .const, () => 0 -- this is cheating, but whatever.

def OpKind.pairFold {i i' : Kind}: i.eval → i'.eval → (Kind.pair i i').eval
| x, y => (x, y)


structure ExprRewrite where
  kindMotive : Kind → Type
  opFold {i o: Kind}: OpKind i o → kindMotive i → kindMotive o
  pairFold: {i i': Kind} → kindMotive i → kindMotive i' → kindMotive (Kind.pair i i')
  default : (k: Kind) → kindMotive k
  k : Kind
  find : Expr .Os k
  replace : Expr .Os k
  tctx : TypingContext
  WT_FIND : ExprWellTyped tctx find -- the find pattern is well typed at tctx.
  WT_REPLACE : ExprWellTyped tctx replace
  -- A rewrite is correct iff for every evaluation context where the
  -- exprsesion is well typed, the result of evaluating the find pattern equals
  -- the replace pattern.
  REWRITE : ∀ (ectx : EvalContext! kindMotive),
    find.eval! opFold pairFold default ectx = replace.eval! opFold pairFold default ectx

def Kind.eval_default (k: Kind): k.eval :=
  match k with
  | .int => 0
  | .pair k1 k2 => (k1.eval_default, k2.eval_default)
  | .unit => ()

-- failed to compile definition, consider marking it as 'noncomputable' because it depends on
-- 'ToTree.ExprWellTyped.compute_implies_prop', and it does not have executable code
noncomputable def sub_x_x_equals_zero : ExprRewrite where
  kindMotive := Kind.eval
  opFold := OpKind.opFold
  pairFold := OpKind.pairFold
  default := Kind.eval_default
  k := .int
  find := Expr.ops
          (Expr.pair "x_x" "x" .int "x" .int)
          (Expr.single (Expr.assign "y" .sub "x_x"))
  replace := Expr.single (Expr.assign "y" .const "_")
  tctx := TypingContext.bottom [ "x" ↦ .int] ["_" ↦ .unit]
  WT_FIND := by {
    apply ExprWellTyped.compute_implies_prop; -- convert theorem into computation.
    simp; -- crunch!
  }
  WT_REPLACE := by {
    apply ExprWellTyped.compute_implies_prop; -- convert theorem into computation,
    simp; -- crunch?
  }
  REWRITE := by {
    intros ectx;
    simp only[dite_eq_ite, Expr.eval!, ite_true, OpKind.opFold, EvalContext!.bind, OpKind.pairFold];
    apply sub_self;
  }

end Examples

end ToTree

def main : IO UInt32 := do
  IO.println "Hello, tree!"
  pure 0
