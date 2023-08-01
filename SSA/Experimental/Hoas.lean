import SSA.Core.WellTypedFramework
import SSA.Projects.InstCombine.Base

namespace SSA



structure HOASTypes (β : Type) (Op : Type) where
  (expr stmt var : Context β → UserType β → Type)
  (region : Context β → UserType β → UserType β → Type)


open OperationTypes UserType in
class HOAS (Op : Type) {β : Type} [Goedel β] [OperationTypes Op β]  (h : HOASTypes β Op) where
  varToSnoc {Γ} {t u : UserType β} {v : Var} : h.var Γ t → h.var (Γ.snoc v u) t 
  /-- let-binding -/
  assign {Γ : Context β} {T : UserType β} 
      (lhs : Var) (rhs : h.expr Γ T) 
      (rest : h.var (Γ.snoc lhs T) T → h.stmt (Γ.snoc lhs T) T')
      : h.stmt Γ T'
  /-- above; ret v -/
  ret (v : h.var Γ T) : h.stmt Γ T
  /-- build a unit value -/
  unit : h.expr Γ .unit
  /-- (fst, snd) -/
  pair (fst : h.var Γ T₁) (snd : h.var Γ T₂) : h.expr Γ (.pair T₁ T₂)
  /-- (fst, snd, third) -/
  triple (fst : h.var Γ T₁) (snd : h.var Γ T₂) (third : h.var Γ T₃) : h.expr Γ (.triple T₁ T₂ T₃)
  /-- op (arg) { rgn } rgn is an argument to the operation -/
  op (o : Op) (arg : h.var Γ (argUserType o)) (rgn : h.region Context.empty (rgnDom o) (rgnCod o)) :
      h.expr Γ (outUserType o)
  /- fun arg => body -/
  rgn (arg : Var) {dom cod : UserType β} 
      (body : h.var (Γ.snoc arg dom) dom → h.stmt (Γ.snoc arg dom) cod) : h.region Γ dom cod
  /- no function / non-existence of region. -/
  rgn0 : h.region Γ .unit .unit
  /- a region variable. --/
  rgnvar (v : h.var Γ (.region T₁ T₂)) : h.region Γ T₁ T₂
  /-- a variable. -/
  var (v : h.var Γ T) : h.expr Γ T
  

  
section
variable (Op : Type) {β : Type} [Goedel β] [OperationTypes Op β]

variable (Γ : Context β)
def HOASExpr    (t : UserType β)      : Type 1 := ∀ h, [HOAS Op h] → h.expr Γ t
def HOASStmt    (t : UserType β)      : Type 1 := ∀ h, [HOAS Op h] → h.stmt Γ t
def HOASVar     (t : UserType β)      : Type 1 := ∀ h, [HOAS Op h] → h.var Γ t
def HOASRegion  (t₁ t₂ : UserType β)  : Type 1 := ∀ h, [HOAS Op h] → h.region Γ t₁ t₂

end


namespace TSSA
variable (Op : Type) {β : Type} [Goedel β] [OperationTypes Op β]

variable (Γ : Context β)
def EXPR    (t : UserType β)     : Type := TSSA Op Γ (.EXPR t)
def STMT    (t : UserType β)     : Type := TSSA Op Γ (.STMT t)
def REGION  (t₁ t₂ : UserType β) : Type := TSSA Op Γ (.REGION t₁ t₂)

end TSSA

variable {Op : Type} {β : Type} [Goedel β] [OperationTypes Op β]

instance : HOAS (Op := Op) ⟨TSSA.EXPR Op, TSSA.STMT Op, Context.Var, TSSA.REGION Op⟩ where
  varToSnoc := Context.Var.prev
  assign lhs rhs rest := TSSA.assign lhs rhs (rest .last)
  ret := TSSA.ret
  unit := TSSA.unit
  pair := TSSA.pair
  triple := TSSA.triple
  op := TSSA.op
  rgn arg _ _ body := TSSA.rgn arg (body .last)
  rgn0 := TSSA.rgn0
  rgnvar := TSSA.rgnvar
  var := TSSA.var
  


def TSSAIndex.toHOASType (Γ : Context β) : TSSAIndex β → Type _
  | .STMT t => HOASStmt Op Γ t
  | .EXPR t => HOASExpr Op Γ t
  | .REGION t₁ t₂ => HOASRegion Op Γ t₁ t₂

section



def TSSA.fromHOASExpr (expr : HOASExpr Op Γ t) : TSSA Op Γ (.EXPR t) :=
  expr ⟨TSSA.EXPR Op, TSSA.STMT Op, Context.Var, TSSA.REGION Op⟩

def TSSA.fromHOASStmt (stmt : HOASStmt Op Γ t) : TSSA Op Γ (.STMT t) :=
  stmt ⟨TSSA.EXPR Op, TSSA.STMT Op, Context.Var, TSSA.REGION Op⟩

def TSSA.fromHOASRegion (stmt : HOASRegion Op Γ t₁ t₂) : TSSA Op Γ (.REGION t₁ t₂) :=
  stmt ⟨TSSA.EXPR Op, TSSA.STMT Op, Context.Var, TSSA.REGION Op⟩

def Context.Var.fromHOAS (v : HOASVar Op Γ t) : Γ.Var t :=
  v ⟨TSSA.EXPR Op, TSSA.STMT Op, Context.Var, TSSA.REGION Op⟩


end


def HOASTypes.fromIndex (h : HOASTypes β Op) (Γ : Context β) : TSSAIndex β → Type 
  | .STMT t => h.stmt Γ t
  | .EXPR t => h.expr Γ t
  | .REGION t₁ t₂ => h.region Γ t₁ t₂

open HOAS in
def TSSA.toHOASAux (h) [hoas : HOAS Op h] {Γ : Context β} {i : TSSAIndex β}
    (map : ⦃t : UserType β⦄ → Γ.Var t → h.var Γ t) : 
    TSSA Op Γ i → h.fromIndex Γ i
  | .assign lhs rhs rest => HOAS.assign lhs (rhs.toHOASAux h map) 
      (fun v => rest.toHOASAux h <| mapping_snoc map v)
  | .ret v => HOAS.ret <| map v
  | .unit => HOAS.unit
  | .pair a b => HOAS.pair (map a) (map b)
  | .triple a b c => HOAS.triple (map a) (map b) (map c)
  | .op o arg region => HOAS.op o (map arg) (region.toHOASAux h fun _ v => v.emptyElim)
  | .var v => HOAS.var (map v)
  | .rgnvar v => HOAS.rgnvar (map v)
  | .rgn0 => HOAS.rgn0
  | .rgn arg body => HOAS.rgn arg (fun v => body.toHOASAux h <| mapping_snoc map v)
where
  mapping_snoc {var} {u} (map : ⦃t : UserType β⦄ → Γ.Var t → h.var Γ t) 
      (newVal : h.var (Γ.snoc var u) u) :
      ⦃t : UserType β⦄ → (Γ.snoc var u).Var t → h.var (Γ.snoc var u) t :=
    fun _ w => by cases w with
      | last => exact newVal
      | prev w => exact hoas.varToSnoc <| map w

end SSA












namespace InstCombine

open SSA

/-
  %v0 := unit: ;
  %v1 := op:const (b) %v0;
  %v2 := pair:%v1 %v1;
  %v3 := op:add w %v2
  dsl_ret %v3
-/

open SSA.HOAS in
def HOASExample : HOASStmt Op ∅ (BaseType.bitvec b) := fun _ _ =>
  assign 0 unit fun v0 =>
  assign 1 (op (Op.const (0 : Bitvec b)) v0 rgn0) fun v1 =>
  assign 2 (pair v1 v1) fun v2 =>
  assign 3 (op (.add b) v2 rgn0) fun v3 =>
  ret v3


def TSSAExample : TSSA Op ∅ (.STMT <| BaseType.bitvec b) :=
  TSSA.fromHOASStmt HOASExample

end InstCombine













namespace EDSLHoas
open Lean HashMap Macro


declare_syntax_cat dslh_region
declare_syntax_cat dslh_bb
declare_syntax_cat dslh_op
declare_syntax_cat dslh_expr
declare_syntax_cat dslh_stmt
declare_syntax_cat dslh_assign
-- declare_syntax_cat dsl_terminator
declare_syntax_cat dslh_val
declare_syntax_cat dslh_rgnvar

-- ops are defined by someone else
scoped syntax "[dsl_op|" dslh_op "]" : term


scoped syntax "op:" dslh_op ident ("," dslh_region)? : dslh_expr

scoped syntax "unit:"  : dslh_expr
scoped syntax "pair:"  ident ident : dslh_expr
scoped syntax "triple:"  ident ident ident : dslh_expr
scoped syntax ident : dsl_expr
scoped syntax "let" ident " := " dslh_expr : dslh_assign
scoped syntax sepBy(dslh_assign, ";") : dslh_stmt


scoped syntax "rgn{" ident "=>" dsl_bb "}" : dslh_region
scoped syntax "^bb"  (dslh_stmt)?  "dsl_ret " ident : dslh_bb

scoped syntax "rgn$(" term ")" : dslh_region

open Lean Elab Macro in

structure SSAElabContext where
  h : Term
  Op : Term

abbrev SSAElabM (α : Type) := StateT SSAElabContext MacroM α



mutual
partial def elabRgn : TSyntax `dslh_region → SSAElabM (TSyntax `term)
| `(dslh_region| rgn$($v)) => return v
| `(dslh_region| rgn{ $v:ident => $bb:dsl_bb }) => do
  let bb ← elabBB bb
  `(SSA.TSSA.rgn $velab $bb)
| _ => Macro.throwUnsupported

partial def elabAssign (mkNext : SSAElabM (TSyntax `term)): TSyntax `dsl_assign → SSAElabM (TSyntax `term)
| `(dsl_assign| $v:dsl_var := $e:dsl_expr) => do
  let e ← elabStxExpr e
  SSAElabContext.addVar (← dslVarToIx v) -- add variable.
  let velab := Lean.quote (← dslVarToIx v) -- natural number.
  let next ← mkNext
  `(SSA.TSSA.assign $velab $e $next)
| _ => Macro.throwUnsupported


-- TSSA.assign (TSSA.assign (TSSA.assign (TSSA.assign TSSA.nop) <s1data>) <s2data>) <s3data>)
-- s1 : (fun prev1 => SSA.assign (<prev1>) <s1data>)
-- s2 : (fun prev2 => SSA.assign (<prev2>) <s2data>)
-- s3 : (fun prev3 => SSA.assign (<prev3>) <s3data>)
-- fun x => s3 ( s2 (s1 x) )
-- (s3 ∘ (s2 ∘ (s1 ∘ id)))
partial def elabStmt (ret : TSyntax `dsl_var) : TSyntax `dsl_stmt → SSAElabM (TSyntax `term)
  | `(dsl_stmt| $ss:dsl_assign;*) => go ss.getElems.toList
  | _ => Macro.throwUnsupported
where go
  | [] => do
    let retv ← elabStxVar ret
    `(SSA.TSSA.ret $retv)
  | s::ss =>
    elabAssign (go ss) s

partial def elabBB : TSyntax `dsl_bb → SSAElabM (TSyntax `term)
| `(dsl_bb| ^bb $[ $s?:dsl_stmt ]? dsl_ret $retv:dsl_var) => do
    match s? with
    | .none => do
      let retv ← elabStxVar retv
      `(SSA.TSSA.ret $retv)
    | .some s => elabStmt retv s
| _ => Macro.throwUnsupported

partial def elabStxExpr : TSyntax `dsl_expr → SSAElabM (TSyntax `term)
| `(dsl_expr| unit:) => `(SSA.TSSA.unit)
| `(dsl_expr| pair: $a $b) => do
    let aelab ← elabStxVar a
    let belab ← elabStxVar b
    `(SSA.TSSA.pair $aelab $belab)
| `(dsl_expr| triple: $a $b $c) => do
  let aelab ← elabStxVar a
  let belab ← elabStxVar b
  let celab ← elabStxVar c
  `(SSA.TSSA.triple $aelab $belab $celab)
| `(dsl_expr| $v:dsl_var) => elabStxVar v
| `(dsl_expr| op: $o:dsl_op $arg:dsl_var $[, $r? ]? ) => do
  let arg ← elabStxVar arg
  let rgn ← match r? with
    | none => `(SSA.TSSA.rgn0)
    | some r => elabRgn r -- TODO: can a region affect stuff outside?
  `(SSA.TSSA.op [dsl_op| $o] $arg $rgn)
| _ => Macro.throwUnsupported
end

scoped syntax "[dsl_bb|" dsl_bb "]" : term
macro_rules
| `([dsl_bb| $bb:dsl_bb]) => do
  let ctx : SSAElabContext := {  vars := #[] }
  let (outTerm, _outCtx) ← (elabBB bb).run ctx
  return outTerm

scoped syntax "[dsl_region|" dsl_region "]" : term
macro_rules
| `([dsl_region| $r:dsl_region]) => do
  let ctx : SSAElabContext := {  vars := #[] }
  let (outTerm, _outCtx) ← (elabRgn r).run ctx
  return outTerm

-- TODO: consider allowing users to build pieces of syntax.
-- scoped syntax "[dsl_expr|" dsl_expr "]" : term
-- scoped syntax "[dsl_stmt|" dsl_stmt "]" : term
-- scoped syntax "[dsl_terminator|" dsl_terminator "]" : term
-- scoped syntax "[dsl_val|" dsl_val "]" : term
-- scoped syntax "[dsl_assign| " dsl_assign "]" : term

end EDSL
