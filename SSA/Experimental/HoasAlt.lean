import SSA.Core.WellTypedFramework
import SSA.Projects.InstCombine.Base

namespace SSA


abbrev VarName := SSA.Var


section

variable (Op : Type) {β : Type} [Goedel β] [OperationTypes Op β]

open OperationTypes in
inductive HoasTSSA : (UserType β → Type) → TSSAIndex β → Type 1 where
  /-- lhs := rhs; rest of the program -/
  | assign {Var} {T : UserType β}
      (lhs : VarName) (rhs : HoasTSSA Var (.EXPR T))
      (rest : Var T → HoasTSSA Var (.STMT T'))
      : HoasTSSA Var (.STMT T')
  /-- build a unit value -/
  | unit {Var} : HoasTSSA Var (.EXPR .unit)
  /-- above; ret v -/
  | ret {Var} (v : Var T) : HoasTSSA Var (.STMT T)
  /-- (fst, snd) -/
  | pair {Var} (fst : Var T₁) (snd : Var T₂) : HoasTSSA Var (.EXPR (.pair T₁ T₂))
  /-- (fst, snd, third) -/
  | triple {Var} (fst : Var T₁) (snd : Var T₂) (third : Var T₃) : 
      HoasTSSA Var (.EXPR (.triple T₁ T₂ T₃))
  /-- op (arg) { rgn } rgn is an argument to the operation -/
  | op {Var} (o : Op) (arg : Var (argUserType o)) 
      (rgn : ∀ Var', HoasTSSA Var' (.REGION (rgnDom o) (rgnCod o))) :
      HoasTSSA Var (.EXPR (outUserType o))
  /- fun arg => body -/
  | rgn {Var} (arg : VarName) {dom cod : UserType β} (body : Var dom → HoasTSSA Var (.STMT cod)) :
      HoasTSSA Var (.REGION dom cod)
  /- no function / non-existence of region. -/
  | rgn0 {Var} : HoasTSSA Var (.REGION .unit .unit)
  /- a region variable. --/
  | rgnvar {Var} (v : Var (.region T₁ T₂)) : HoasTSSA Var (.REGION T₁ T₂)
  /-- a variable. -/
  | var {Var} (v : Var T) : HoasTSSA Var (.EXPR T)



/-!
  By universally quantifying a `HoasTSSA` term over the `Var` type family, we ensure the represented
  term is closed.
  This follows from the fact that the type `∀ α, α` is uninhabited
  ```lean
  example (v : ∀ α, α) : False := Empty.elim (v Empty)
  ```
-/

/-- A closed TSSA expression in Hoas representation -/
def HoasExpr    (t : UserType β)      : Type 1 := ∀ V, HoasTSSA Op V (.EXPR t)

/-- A closed TSSA statement in Hoas representation -/
def HoasStmt    (t : UserType β)      : Type 1 := ∀ V, HoasTSSA Op V (.STMT t)

/-- A closed TSSA region in Hoas representation -/
def HoasRegion  (t₁ t₂ : UserType β)  : Type 1 := ∀ V, HoasTSSA Op V (.REGION t₁ t₂)

end

variable {Op : Type} {β : Type} [Goedel β] [OperationTypes Op β] [DecidableEq β]


-- @[simp]
-- def HoasTSSA.sizeOf {Var} [∀ t, Inhabited (Var t)] : HoasTSSA Op Var i → Nat
--   | .assign _ rhs rest => rhs.sizeOf + (rest default).sizeOf + 1
--   | .op _ _ body => (body Var).sizeOf + 1
--   | .rgn _ body => (body default).sizeOf + 1
--   | .ret _ | unit | pair .. | triple .. | .rgn0 | .rgnvar .. | .var .. => 0


protected abbrev HoasTSSA.VarTy := (fun t => ∀ (Γ : Context β), Option <| Γ.Var t)

partial def HoasTSSA.toTSSA? {i : TSSAIndex β} (term : ∀ V, HoasTSSA Op V i) : Option (TSSA Op ∅ i) :=
  go (term _) ∅
where 
  go {i} : HoasTSSA Op HoasTSSA.VarTy i → 
      (Γ : Context β) → Option (TSSA Op Γ i)
    | .assign (T:=T) lhs rhs rest, Γ => do
      let rhs' ← go rhs Γ
      let Γt := Γ.snoc lhs T
      let rest' := rest (fun Γ' => 
        if h : Γt ⊆ Γ' then
          some <| .coePrefix h <| .last
        else
          none
      )

      /-        
        Because the original term is parametric over all possible variable types `V`, we know that
        so-called exotic terms are ruled out. In particular, we know that the function `rest` 
        is unable to inspect the argument. Furthermore, from the implementation of `sizeOf` we can
        see that the variable is also never inspected there.
        From this, it follows that the size of `rest v` must be the same for every choice of `v`.
        In particular, then, `rest'` must have the same size as `rest default`.
        However, it is impossible to reason about the parametricity of Lean definitions from within
        Lean itself, so we cannot make this argument properly.
        Instead, we take the following as axiom.
      -/
      -- Axioms removed because def is marked partial
      -- have : sizeOf rest' = sizeOf (rest fun _ => default) := by admit
      -- have : sizeOf rest' < sizeOf rhs + sizeOf (rest fun a => default) + 1 := by 
      --   rw[this]; linarith

      let rest ← go rest' _
      return TSSA.assign lhs rhs' rest
    | .ret v, Γ => do
      let v ← v Γ
      return TSSA.ret v
    | .unit, _ => some <| TSSA.unit
    | .pair a b, _      => do return TSSA.pair (←a _) (←b _)
    | .triple a b c, _  => do return TSSA.triple (←a _) (←b _) (←c _)
    | .op o arg body, Γ => do
      let arg ← arg Γ
      let body ← go (body _) _
      return TSSA.op o arg body
    | .rgn arg body, Γ => do
      let Γt := Γ.snoc arg _
      let body' := body (fun Γ' =>
          if h : Γt ⊆ Γ' then
            some <| .coePrefix h <| .last
          else
            none
        )

      /-
        The justification for the following axiom is the same as for the axiom in the `.assign`
        case above
      -/
      -- Axioms removed because def is marked partial
      -- have : sizeOf body' = sizeOf (body fun _ => default) := by admit
      -- have : sizeOf body' < sizeOf (body fun a => default) + 1 := by 
      --   rw[this]; apply Nat.lt.base

      let body ← go body' Γt
      return TSSA.rgn arg body
    | .rgn0, _      => some TSSA.rgn0
    | .rgnvar v, _  => do return TSSA.rgnvar (←v _)
    | .var v, _     => do return TSSA.var (←v _)
  -- termination_by go t _ => t.sizeOf
  


  
def TSSA.fromHoasExpr (expr : HoasExpr Op t) : Option <| TSSA Op ∅ (.EXPR t) :=
  HoasTSSA.toTSSA? expr

def TSSA.fromHoasStmt (stmt : HoasStmt Op t) : Option <| TSSA Op ∅ (.STMT t) :=
  HoasTSSA.toTSSA? stmt

def TSSA.fromHoasRegion (rgn : HoasRegion Op t₁ t₂) : Option <| TSSA Op ∅ (.REGION t₁ t₂) :=
  HoasTSSA.toTSSA? rgn


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
  `(SSA.HoasTSSA.rgn $v $bb)
| _ => Macro.throwUnsupported

partial def elabAssign (next : Term): TSyntax `dslh_assign → MacroM Term
| `(dslh_assign| %$v:ident := $e:dslh_expr) => do
  let e ← elabStxExpr e
  `(SSA.HoasTSSA.assign 0 $e (fun $v => $next))
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
  | [] => `(SSA.HoasTSSA.ret $ret)
  | s::ss => do 
      elabAssign (←go ss) s

partial def elabBB : TSyntax `dslh_bb → MacroM Term
| `(dslh_bb| ^bb $[ $s?:dslh_stmt ]? dsl_ret %$ret:ident) => do
    match s? with
    | .none => `(SSA.HoasTSSA.ret $ret)
    | .some s => elabStmt ret s
| _ => Macro.throwUnsupported

partial def elabStxExpr : TSyntax `dslh_expr → MacroM Term
| `(dslh_expr| unit:)                                   => `(SSA.HoasTSSA.unit)
| `(dslh_expr| pair: %$a:ident %$b:ident)               => `(SSA.HoasTSSA.pair $a $b)
| `(dslh_expr| triple: %$a:ident %$b:ident %$c:ident)   => `(SSA.HoasTSSA.triple $a $b $c)
| `(dslh_expr| %$v:ident) => `($v)
| `(dslh_expr| op: $o:dsl_op : %$arg:ident $[, $r? ]? ) => do
  let rgn ← match r? with
    | none => `(fun _ => SSA.HoasTSSA.rgn0)
    | some r => elabRgn r -- TODO: can a region affect stuff outside?
  `(SSA.HoasTSSA.op [dsl_op| $o] $arg $rgn)
| _ => Macro.throwUnsupported
end

/-- `[dshlh_bb ($Op)| $bb]`, Op specifies the dialect -/
scoped syntax "[dslh_bb" ("(" term ")")? "| " dslh_bb "]" : term 

macro_rules 
| `([dslh_bb| $bb:dslh_bb]) => `([dslh_bb (_)| $bb:dslh_bb])
| `([dslh_bb ($Op)| $bb:dslh_bb]) => do
  let bb ← elabBB bb
  -- `(Option.get! <| SSA.HoasTSSA.toTSSA? <| fun V => ($bb : SSA.HoasTSSA $Op V (.STMT _)))
  `(fun V => ($bb : SSA.HoasTSSA $Op V (.STMT _)))


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
