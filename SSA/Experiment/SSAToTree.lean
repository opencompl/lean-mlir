-- We create a verified conversion from SSA minus Regions (ie, a sequence
-- of let bindings) into an expression tree. We prove that this
-- conversion preserves program semantics.
import Aesop

inductive Kind where
| int
| pair : Kind → Kind → Kind

inductive ExprKind
| O
| Os
abbrev Var := String 

inductive OpKind
| add
| const
| sub

inductive Expr : ExprKind → Type where
| assign (ret : Var) (kind: OpKind) (arg: Var) : Expr .O
| tuple (ret : Var) (arg1 arg2 : Var) : Expr .O
| ops: Expr .O → Expr .Os → Expr .Os
abbrev Op := Expr .O
abbrev Ops := Expr .Os

@[match_pattern]
abbrev Op.assign (ret : Var) (kind : OpKind) (arg : Var) : Op := 
  Expr.assign ret kind arg

@[match_pattern]
abbrev Op.tuple (ret arg1 arg2: Var) : Op := 
  Expr.tuple ret arg1 arg2

inductive ExprTree where
| tuple: ExprTree → ExprTree → ExprTree
| compute: ExprTree → ExprKind → ExprTree

-- A DefContext that tracks which variables have been defined.
def DefContext := String → Bool

abbrev DefContext.bound? (ctx : DefContext) (name : String) : Bool := 
  ctx name 

abbrev DefContext.bind (ctx : DefContext) (bindname : String) : DefContext := 
  fun name => if name = bindname then True else ctx name

inductive ExprWellFormed : DefContext → Expr kind → DefContext → Prop where
| assign
    {ret arg : Var}
    {ctx : DefContext}
    (ARG : ctx.bound? arg = True)
    (RET: ctx.bound? ret = False) :
    ExprWellFormed ctx (Op.assign ret kind arg) (ctx.bind ret)
| tuple
  {ctx : DefContext}
  {ret arg1 arg2 : Var}
  (ARG1 : ctx.bound? arg1 = True)
  (ARG2 : ctx.bound? arg2 = True)
  (RET: ctx.bound? ret = False) :
  ExprWellFormed ctx (Op.tuple ret arg1 arg2) (ctx.bind ret)
| ops 
  {ctxbegin ctxend : DefContext}
  ⦃ctxmid : DefContext⦄
  (WF1: ExprWellFormed ctxbegin op1 ctxmid)
  (WF2: ExprWellFormed ctxmid op2 ctxend) : 
  ExprWellFormed ctxbegin (Expr.ops op1 op2) ctxend

def ExprWellFormed.compute : Expr kind → DefContext → Option DefContext 
| (.assign ret kind arg), ctx => 
    if ctx.bound? ret 
    then .none
    else if not (ctx.bound? arg)
    then .none
    else .some (ctx.bind ret)
| (.tuple ret arg1 arg2), ctx => 
    if ctx.bound? ret then .none
    else if not (ctx.bound? arg1) then .none
    else if not (ctx.bound? arg2) then .none
    else .some (ctx.bind ret)
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
  case tuple ret arg1 arg2 => {
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
  case tuple ret arg1 arg2 => {
    intros ctx ctx' WELLFORMED;
    cases WELLFORMED;
    case tuple RET ARG1 ARG2 => {
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


