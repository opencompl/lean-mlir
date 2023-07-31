import SSA.Core.WellTypedFramework
import SSA.Projects.InstCombine.Base

namespace SSA



structure HOASTypes (β : Type) where
  (expr stmt var : Context β → UserType β → Type)
  (region : Context β → UserType β → UserType β → Type)


open OperationTypes UserType in
class HOAS (Op : Type) {β : Type} [Goedel β] [OperationTypes Op β] (h : HOASTypes β) where
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

variable (Op : Type) {β : Type} [Goedel β] [OperationTypes Op β]

def HOASExpr (Γ : Context β) (t : UserType β) : Type _ := 
  ∀ h, [HOAS Op h] → h.expr Γ t

def HOASStmt (Γ : Context β) (t : UserType β) : Type 1 := 
  ∀ h, [HOAS Op h] → h.stmt Γ t

def HOASVar (Γ : Context β) (t : UserType β) : Type 1 := 
  ∀ h, [HOAS Op h] → h.var Γ t

def HOASRegion (Γ : Context β) (t₁ t₂ : UserType β) : Type 1 := 
  ∀ h, [HOAS Op h] → h.region Γ t₁ t₂











def TSSA.EXPR (Γ : Context β) (t : UserType β) : Type :=
  TSSA Op Γ (.EXPR t)

def TSSA.STMT (Γ : Context β) (t : UserType β) : Type :=
  TSSA Op Γ (.STMT t)

def TSSA.REGION (Γ : Context β) (t₁ t₂ : UserType β) : Type :=
  TSSA Op Γ (.REGION t₁ t₂)



instance : HOAS Op ⟨TSSA.EXPR Op, TSSA.STMT Op, Context.Var, TSSA.REGION Op⟩ where
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


def HOASTypes.fromIndex (h : HOASTypes β) (Γ : Context β) : TSSAIndex β → Type 
  | .STMT t => h.stmt Γ t
  | .EXPR t => h.expr Γ t
  | .REGION t₁ t₂ => h.region Γ t₁ t₂

open HOAS in
def TSSA.toHOASAux (h) [hoas : HOAS Op h] {Γ : Context β} {i : TSSAIndex β}
    (map : ⦃t : UserType β⦄ → Γ.Var t → h.var Γ t) : 
    TSSA Op Γ i → h.fromIndex Γ i
  | .assign lhs rhs rest => HOAS.assign Op lhs (rhs.toHOASAux h map) 
      (fun v => rest.toHOASAux h <| mapping_snoc map v)
  | .ret v => HOAS.ret Op <| map v
  | .unit => HOAS.unit Op
  | .pair a b => HOAS.pair Op (map a) (map b)
  | .triple a b c => HOAS.triple Op (map a) (map b) (map c)
  | .op o arg region => HOAS.op o (map arg) (region.toHOASAux h fun _ v => v.emptyElim)
  | .var v => HOAS.var Op (map v)
  | .rgnvar v => HOAS.rgnvar Op (map v)
  | .rgn0 => HOAS.rgn0 Op
  | .rgn arg body => HOAS.rgn Op arg (fun v => body.toHOASAux h <| mapping_snoc map v)
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
  assign Op 0 (unit Op) fun v0 =>
  assign Op 1 (op (Op.const (0 : Bitvec b)) v0 (rgn0 Op)) fun v1 =>
  assign Op 2 (pair Op v1 v1) fun v2 =>
  assign Op 3 (op (Op.add b) v2 (rgn0 Op)) fun v3 =>
  ret Op v3


def TSSAExample : TSSA Op ∅ (.STMT <| BaseType.bitvec b) :=
  TSSA.fromHOASStmt Op HOASExample

end InstCombine