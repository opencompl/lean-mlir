import SSA.Core.WellTypedFramework
import SSA.Projects.InstCombine.Base

namespace SSA



structure HOASTypes (β : Type) (Op : Type) where
  (expr stmt var : UserType β → Type)
  (region : UserType β → UserType β → Type)


open OperationTypes UserType in
class HOAS (Op : Type) {β : Type} [Goedel β] [OperationTypes Op β]  (h : HOASTypes β Op) where
  -- varToSnoc {Γ} {t u : UserType β} {v : Var} : h.var Γ t → h.var (Γ.snoc v u) t 
  /-- let-binding -/
  assign {T : UserType β} (lhs : Var) (rhs : h.expr T) (rest : h.var T → h.stmt T') : h.stmt T'
  /-- above; ret v -/
  ret (v : h.var T) : h.stmt T
  /-- build a unit value -/
  unit : h.expr .unit
  /-- (fst, snd) -/
  pair (fst : h.var T₁) (snd : h.var T₂) : h.expr (.pair T₁ T₂)
  /-- (fst, snd, third) -/
  triple (fst : h.var T₁) (snd : h.var T₂) (third : h.var T₃) : h.expr (.triple T₁ T₂ T₃)
  /-- op (arg) { rgn } rgn is an argument to the operation -/
  op (o : Op) (arg : h.var (argUserType o)) (rgn : h.region (rgnDom o) (rgnCod o)) :
      h.expr (outUserType o)
  /- fun arg => body -/
  rgn (arg : Var) {dom cod : UserType β} 
      (body : h.var dom → h.stmt cod) : h.region dom cod
  /- no function / non-existence of region. -/
  rgn0 : h.region .unit .unit
  /- a region variable. --/
  rgnvar (v : h.var (.region T₁ T₂)) : h.region T₁ T₂
  /-- a variable. -/
  var (v : h.var T) : h.expr T



variable {Op : Type} {β : Type} [Goedel β] [OperationTypes Op β]



section
variable (Op : Type) {β : Type} [Goedel β] [OperationTypes Op β]

def HOASExpr    (t : UserType β)      : Type 1 := ∀ h, [HOAS Op h] → h.expr t
def HOASStmt    (t : UserType β)      : Type 1 := ∀ h, [HOAS Op h] → h.stmt t
def HOASVar     (t : UserType β)      : Type 1 := ∀ h, [HOAS Op h] → h.var t
def HOASRegion  (t₁ t₂ : UserType β)  : Type 1 := ∀ h, [HOAS Op h] → h.region t₁ t₂

end

def Context.Hom (Γ₁ Γ₂ : Context β) : Type :=
  ⦃t : UserType β⦄ → Γ₁.Var t → Γ₂.Var t

def Context.Hom.snoc (hom : Hom Γ₁ Γ₂) : Hom (Γ₁.snoc var ty) (Γ₂.snoc var ty) :=
  fun _ v => match v with
    | .last => .last
    | .prev v => .prev (hom v)

def Context.Hom.snocRight (hom : Hom Γ₁ Γ₂) : Hom Γ₁ (Γ₂.snoc var ty) :=
  fun _ v => .prev <| hom v

def HOASTypes.ToTSSA : HOASTypes β Op where
  expr t        := ∀ Γ, Option <| TSSA Op Γ (.EXPR t)
  stmt t        := ∀ Γ, Option <| TSSA Op Γ (.STMT t)
  region t₁ t₂  := ∀ Γ, Option <| TSSA Op Γ (.REGION t₁ t₂)
  var t         := ∀(Γ : Context β), Option <| Γ.Var t

-- example : Γ.Var T → TSSA Γ (.STMT t) HOASTypes.stmt (HOASTypes.ToTSSA Γ) T'


instance TSSA.instHoas [DecidableEq β] : HOAS Op HOASTypes.ToTSSA where
  -- varToSnoc := Context.Var.prev
  assign := @fun _ T' lhs rhs rest Γ => do
    let rhs ← rhs Γ
    let Γt := Γ.snoc lhs T'
    let rest ← rest (fun Γ' => 
      if h : Γt ⊆ Γ' then
        some <| .coePrefix h <| .last ..
      else
        none
    ) Γt
    return TSSA.assign lhs rhs rest
  ret := fun v Γ => do
    let v ← v Γ
    return TSSA.ret v
  unit _ := some <| TSSA.unit
  pair a b _      := do return TSSA.pair (←a _) (←b _)
  triple a b c _  := do return TSSA.triple (←a _) (←b _) (←c _)
  op o arg rgn Γ := do
    let arg ← arg Γ
    let rgn ← rgn ∅
    return TSSA.op o arg rgn
  rgn arg ty₁ _ body Γ := do
    let Γt := Γ.snoc arg ty₁
    let body ← body (fun Γ' =>
        if h : Γt ⊆ Γ' then
          some <| .coePrefix h <| .last ..
        else
          none
      ) Γt
    return TSSA.rgn arg body
  rgn0 _ := some TSSA.rgn0
  rgnvar v _  := do return TSSA.rgnvar (←v _)
  var v _     := do return TSSA.var (←v _)




def TSSAIndex.toHOASType : TSSAIndex β → Type _
  | .STMT t => HOASStmt Op t
  | .EXPR t => HOASExpr Op t
  | .REGION t₁ t₂ => HOASRegion Op t₁ t₂



section
variable [DecidableEq β]

/-!
  The `HOAS` representation does not carry any
-/

def TSSA.fromHOASExpr (expr : HOASExpr Op t) : ∀ Γ, Option <| TSSA Op Γ (.EXPR t) :=
  expr .ToTSSA

def TSSA.fromHOASStmt (stmt : HOASStmt Op t) : ∀ Γ, Option <| TSSA Op Γ (.STMT t) :=
  stmt .ToTSSA

def TSSA.fromHOASRegion (stmt : HOASRegion Op t₁ t₂) : ∀ Γ, Option <| TSSA Op Γ (.REGION t₁ t₂) :=
  stmt .ToTSSA

def Context.Var.fromHOAS (v : HOASVar Op t) : ∀ (Γ : Context β), Option <| Γ.Var t :=
  v .ToTSSA

end



-- def HOASTypes.fromIndex (h : HOASTypes β Op) (Γ : Context β) : TSSAIndex β → Type 
--   | .STMT t => h.stmt Γ t
--   | .EXPR t => h.expr Γ t
--   | .REGION t₁ t₂ => h.region Γ t₁ t₂

-- open HOAS in
-- def TSSA.toHOASAux (h) [hoas : HOAS Op h] {Γ : Context β} {i : TSSAIndex β}
--     (map : ⦃t : UserType β⦄ → Γ.Var t → h.var Γ t) : 
--     TSSA Op Γ i → h.fromIndex Γ i
--   | .assign lhs rhs rest => HOAS.assign lhs (rhs.toHOASAux h map) 
--       (fun v => rest.toHOASAux h <| mapping_snoc map v)
--   | .ret v => HOAS.ret <| map v
--   | .unit => HOAS.unit
--   | .pair a b => HOAS.pair (map a) (map b)
--   | .triple a b c => HOAS.triple (map a) (map b) (map c)
--   | .op o arg region => HOAS.op o (map arg) (region.toHOASAux h fun _ v => v.emptyElim)
--   | .var v => HOAS.var (map v)
--   | .rgnvar v => HOAS.rgnvar (map v)
--   | .rgn0 => HOAS.rgn0
--   | .rgn arg body => HOAS.rgn arg (fun v => body.toHOASAux h <| mapping_snoc map v)
-- where
--   mapping_snoc {var} {u} (map : ⦃t : UserType β⦄ → Γ.Var t → h.var Γ t) 
--       (newVal : h.var (Γ.snoc var u) u) :
--       ⦃t : UserType β⦄ → (Γ.snoc var u).Var t → h.var (Γ.snoc var u) t :=
--     fun _ w => by cases w with
--       | last => exact newVal
--       | prev w => exact hoas.varToSnoc <| map w

end SSA














namespace EDSLHoas
open Lean HashMap Macro 

open EDSL


declare_syntax_cat dslh_region
declare_syntax_cat dslh_bb
declare_syntax_cat dslh_expr
declare_syntax_cat dslh_stmt
declare_syntax_cat dslh_assign
-- declare_syntax_cat dsl_terminator
declare_syntax_cat dslh_var
declare_syntax_cat dslh_val
declare_syntax_cat dslh_rgnvar

-- ops are defined by someone else
-- scoped syntax "[dsl_op|" dsl_op "]" : term

-- DSL variables
scoped syntax "%" ident : dslh_var

scoped syntax "op:" dsl_op ":" dslh_var ("," dslh_region)? : dslh_expr

scoped syntax "unit:"  : dslh_expr
scoped syntax "pair:"  dslh_var dslh_var : dslh_expr
scoped syntax "triple:"  dslh_var dslh_var dslh_var : dslh_expr
scoped syntax dslh_var : dslh_expr
scoped syntax dslh_var " := " dslh_expr : dslh_assign
scoped syntax sepBy(dslh_assign, ";") : dslh_stmt


scoped syntax "rgn{" dslh_var "=>" dslh_bb "}" : dslh_region
scoped syntax "^bb"  (dslh_stmt)?  "dsl_ret " dslh_var : dslh_bb

scoped syntax "rgn$(" term ")" : dslh_region

open Lean Elab Macro in


mutual
partial def elabRgn : TSyntax `dslh_region → MacroM Term
| `(dslh_region| rgn$($v)) => return v
| `(dslh_region| rgn{ %$v:ident => $bb:dslh_bb }) => do
  let bb ← elabBB bb
  `(SSA.HOAS.rgn $v $bb)
| _ => Macro.throwUnsupported

partial def elabAssign (next : Term): TSyntax `dslh_assign → MacroM Term
| `(dslh_assign| %$v:ident := $e:dslh_expr) => do
  let e ← elabStxExpr e
  `(SSA.HOAS.assign 0 $e (fun $v => $next))
| _ => Macro.throwUnsupported


-- TSSA.assign (TSSA.assign (TSSA.assign (TSSA.assign TSSA.nop) <s1data>) <s2data>) <s3data>)
-- s1 : (fun prev1 => SSA.assign (<prev1>) <s1data>)
-- s2 : (fun prev2 => SSA.assign (<prev2>) <s2data>)
-- s3 : (fun prev3 => SSA.assign (<prev3>) <s3data>)
-- fun x => s3 ( s2 (s1 x) )
-- (s3 ∘ (s2 ∘ (s1 ∘ id)))
partial def elabStmt (ret : Ident) : TSyntax `dslh_stmt → MacroM Term
  | `(dslh_stmt| $ss:dslh_assign;*) => go ss.getElems.toList
  | _ => Macro.throwUnsupported
where go
  | [] => `(SSA.HOAS.ret $ret)
  | s::ss => do 
      elabAssign (←go ss) s

partial def elabBB : TSyntax `dslh_bb → MacroM Term
| `(dslh_bb| ^bb $[ $s?:dslh_stmt ]? dsl_ret %$ret:ident) => do
    match s? with
    | .none => `(SSA.HOAS.ret $ret)
    | .some s => elabStmt ret s
| _ => Macro.throwUnsupported

partial def elabStxExpr : TSyntax `dslh_expr → MacroM Term
| `(dslh_expr| unit:)                                   => `(SSA.HOAS.unit)
| `(dslh_expr| pair: %$a:ident %$b:ident)               => `(SSA.HOAS.pair $a $b)
| `(dslh_expr| triple: %$a:ident %$b:ident %$c:ident)   => `(SSA.HOAS.triple $a $b $c)
| `(dslh_expr| %$v:ident) => `($v)
| `(dslh_expr| op: $o:dsl_op : %$arg:ident $[, $r? ]? ) => do
  let rgn ← match r? with
    | none => `(SSA.HOAS.rgn0)
    | some r => elabRgn r -- TODO: can a region affect stuff outside?
  `(SSA.HOAS.op [dsl_op| $o] $arg $rgn)
| _ => Macro.throwUnsupported
end

/-- `[dshlh_bb ($Op)| $bb]`, Op specifies the dialect -/
scoped syntax "[dslh_bb" ("(" term ")")? "| " dslh_bb "]" : term 

macro_rules 
| `([dslh_bb| $bb:dslh_bb]) => `([dslh_bb (_)| $bb:dslh_bb])
| `([dslh_bb ($Op)| $bb:dslh_bb]) => do
  let bb ← elabBB bb
  `(fun h (_ : SSA.HOAS $Op h) => ($bb : h.stmt _))


scoped syntax "[dslh_region|" dslh_region "]" : term
macro_rules
| `([dslh_region| $r:dslh_region]) => elabRgn r

-- TODO: consider allowing users to build pieces of syntax.
-- scoped syntax "[dslh_expr|" dslh_expr "]" : term
-- scoped syntax "[dslh_stmt|" dslh_stmt "]" : term
-- scoped syntax "[dsl_terminator|" dsl_terminator "]" : term
-- scoped syntax "[dsl_val|" dsl_val "]" : term
-- scoped syntax "[dsl_assign| " dsl_assign "]" : term




end EDSLHoas


namespace InstCombine

open SSA EDSLHoas

/-
  %v0 := unit: ;
  %v1 := op:const (b) %v0;
  %v2 := pair:%v1 %v1;
  %v3 := op:add w %v2
  dsl_ret %v3
-/

open SSA.HOAS in
def HOASExample : HOASStmt Op (BaseType.bitvec b) := fun _h (_ : HOAS Op _h) =>
  assign 0 unit fun v0 =>
  assign 1 (op (Op.const (0 : Bitvec b)) v0 rgn0) fun v1 =>
  assign 2 (pair v1 v1) fun v2 =>
  assign 3 (op (.add b) v2 rgn0) fun v3 =>
  ret v3


-- def TSSAExample : TSSA Op ∅ (.STMT <| BaseType.bitvec b) :=
--   TSSA.fromHOASStmt HOASExample


example (Z : Bitvec 10) := [dslh_bb (Op)|
  ^bb
  %v0 := unit: ;
  %v1 := unit: ;
  %ret := pair: %v0 %v1 ;
  %v2 := unit: ;
  %x := op:const Z : %v0
  dsl_ret %ret
]

def EDSLHExample (w : Nat) (C1 Z RHS : Bitvec w) := [dslh_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Z): %v0;
  %v2 := op:const (C1): %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w: %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:xor w: %v5;
  %v7 := op:const 1: %v0;
  %v8 := pair:%v6 %v7;
  %v9 := op:add w: %v8;
  %v10 := op:const RHS: %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:add w: %v11
  dsl_ret %v12
  ] 

end InstCombine
