import SSA.Experimental.IntrinsicAsymptotics.Basic
import SSA.Experimental.IntrinsicAsymptotics.Context

import Lean
import Qq


/-!
  Defines the semantics (i.e., `denote` functions) of various structures
-/

-- inductive Value where
--   | nat : Nat → Value
--   | bool : Bool → Value
--   deriving Repr, Inhabited, DecidableEq

-- /-- The `State` is a map from variables to values that uses relative de Bruijn
--     indices. The most recently introduced variable is at the head of the list.
-- -/
-- abbrev State := List Value

noncomputable section

/-!
  ## Context semantics
-/

/-- A semantics for a context. Provide a way to evaluate every variable in a context. -/
def Ctxt.Sem (Γ : Ctxt) : Type :=
  ⦃t : Ty⦄ → Γ.Var t → t.toType    


namespace Ctxt.Sem
variable {Γ : Ctxt}

instance : Inhabited (Ctxt.Sem ∅) := ⟨fun _ v => v.emptyElim⟩ 

/-- Make a semantics for `Γ.snoc t` from a semantics for `Γ` and an element of `t.toType`. -/
def snoc {t : Ty} (s : Γ.Sem) (x : t.toType) : 
    (Γ.snoc t).Sem := by
  intro t' v
  revert s x
  refine Ctxt.Var.casesOn v ?_ ?_
  . intro _ _ _ v s _; exact s v
  . intro _ _ _ x; exact x

@[simp]
theorem snoc_last {t : Ty} (s : Γ.Sem) (x : t.toType) : 
    (s.snoc x) (Ctxt.Var.last _ _) = x := by 
  simp [Ctxt.Sem.snoc]

@[simp]
theorem snoc_toSnoc {t t' : Ty} (s : Γ.Sem) (x : t.toType) 
    (v : Γ.Var t') : (s.snoc x) v.toSnoc = s v := by
  simp [Ctxt.Sem.snoc]


end Ctxt.Sem



/-!
  ## Denotation functions
-/

def IExpr.denote : IExpr Γ ty → Γ.Sem → ty.toType
  | .nat n, _ => n
  | .add a b, ll => ll a + ll b

def ICom.denote : ICom Γ ty → Γ.Sem → ty.toType
  | .ret e, ll => ll e
  | .lete e body, ll => body.denote (ll.snoc (e.denote ll))

def IExprRec.denote : IExprRec Γ ty → Γ.Sem → ty.toType
  | .cst n, _ => n
  | .add a b, ll => a.denote ll + b.denote ll
  | .var v, ll => ll v

def Lets.denote : Lets Γ₁ Γ₂ → Γ₁.Sem → Γ₂.Sem 
  | .nil => id
  | .lete e body => fun ll t v => by
    cases v using Ctxt.Var.casesOn with
    | last => 
      apply body.denote
      apply e.denote
      exact ll
    | toSnoc v =>
      exact e.denote ll v

def LetZipper.denote : LetZipper Γ ty → (ll : Γ.Sem) → ty.toType
  := fun z => z.zip.denote

namespace Example
open Lean Meta Elab Tactic Qq
open PrettyPrinter (delab)


def Γ' : Ctxt := (Ctxt.empty.snoc .nat).snoc .nat

def lhs : ICom Γ' .nat := 
  ICom.lete (.add (.toSnoc <| .last ..) (.last ..)) <|
  ICom.ret (.last ..)

def rhs : ICom Γ' .nat :=
  ICom.lete (.add (.last ..) (.toSnoc <| .last ..)) <|
  ICom.ret (.last ..)

@[simp]
theorem Ctxt.Sem.snoc_last {Γ : Ctxt} {t : Ty} (ll : Γ.Sem) (val : t.toType) :
    (ll.snoc val) (.last Γ t) = val :=
  rfl

@[simp]
theorem Ctxt.Sem.snoc_toSnoc {Γ : Ctxt} {t : Ty} (ll : Γ.Sem) (val : t.toType) (x : Γ.Var u) :
    (ll.snoc v) (.toSnoc x) = ll x :=
  rfl

#check generalize

elab "generalize_tssa_env" : tactic => withMainContext <| do  
  let ctx ← getLCtx
  for ldecl in ctx do
    let Γ₀ : Q(Ctxt) ← mkFreshExprMVar (some (q(Ctxt)))
    dbg_trace "\nChecking\n{ldecl.type}\n\t =\nCtxt.Sem {Γ₀}"
    if ←isDefEq ldecl.type q(Ctxt.Sem $Γ₀) then
      dbg_trace "Match!\n"
      let ll : Q(Ctxt.Sem $Γ₀) := ldecl.toExpr
      let mut Γ : Σ (Γ : Q(Ctxt)), (t : Q(Ty)) → Q(Ctxt.Var $Γ $t) → Q(Ty.toType $t) := 
        ⟨Γ₀, fun _ v => q($ll $v)⟩
      while true do
        let Γ' : Q(Ctxt) ← mkFreshExprMVar (some q(Ctxt))
        let u : Q(Ty) ← mkFreshExprMVar (some q(Ty))    
        if ←isDefEq Γ.1 q(Ctxt.snoc $Γ' $u) then
          let hom : (t : Q(Ty)) → Q(Ctxt.Var (Ctxt.snoc $Γ' $u) $t) → Q(Ctxt.Var $Γ₀ $t) := Γ.2        
          -- update the subcontext to be considered in the next iteration
          Γ := ⟨Γ', fun t v => 
            hom t q(@Ctxt.Var.toSnoc _ $t $u $v)
          ⟩
          -- now, generalize a variable
          let w : Q(Ctxt.Var $Γ₀ $u) := hom u q(Ctxt.Var.last $Γ' $u)
          let _ ← (←getMainGoal).generalize #[{
            expr := w
          }]
          
        else 
          if ←isDefEq Γ.1 q(Ctxt.empty) then
            -- clear Γ₀
          break

  return ()


theorem test : lhs.denote = rhs.denote := by
  simp only [ICom.denote, IExpr.denote]
  funext ll
  simp[Γ'] at ll
  generalize_tssa_env
  generalize ll (.last ..) = x
  generalize ll (.toSnoc <| .last ..) = y
  dsimp only [Ctxt.Sem.snoc_last]
  dsimp[Ty.toType] at x y
  clear ll

  exact Nat.add_comm y x

end Example


/-
  ## Denotation preservation proofs
-/

namespace Lets

@[simp]
theorem lete_toSnoc (lets : Lets Γ Δ) (e : IExpr Δ t) (v : Δ.Var u) (ll : Γ.Sem) :
    lets.denote ll v = (Lets.lete lets e).denote ll v.toSnoc := by
  rfl

end Lets



theorem denote_addLetsAtTop {Γ₁ Γ₂ : Ctxt} :
    (lets : Lets Γ₁ Γ₂) → (inputProg : ICom Γ₂ t₂) →
    (addLetsAtTop lets inputProg).denote = 
      inputProg.denote ∘ lets.denote
  | Lets.nil, inputProg => rfl
  | Lets.lete body e, inputProg => by
    rw [addLetsAtTop, denote_addLetsAtTop body]
    funext
    simp [ICom.denote, Function.comp_apply, Lets.denote, Ctxt.Sem.snoc]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn
    . simp
    . simp

@[simp]
theorem LetZipper.denote_advanceCursor (z : LetZipper Γ t) :
    z.advanceCursor.denote = z.denote := by
  rcases z with ⟨lets, _|_⟩ <;> rfl

@[simp]
theorem LetZipper.nil_com_denote_zip (com : ICom Γ t) :
    LetZipper.denote ⟨.nil, com⟩ = com.denote :=
  rfl



@[simp]
theorem IExpr.denote_changeVars {Γ Γ' : Ctxt}
    (varsMap : (t : Ty) → Γ.Var t → Γ'.Var t)
    (e : IExpr Γ ty)
    (ll : Γ'.Sem) : 
    (e.changeVars varsMap).denote ll = 
    e.denote (fun t v => ll (varsMap t v)) := by
  induction e generalizing ll <;> simp 
    [IExpr.denote, IExpr.changeVars, *]

@[simp]
theorem ICom.denote_changeVars {Γ Γ' : Ctxt}
    (varsMap : (t : Ty) → Γ.Var t → Γ'.Var t) (c : ICom Γ ty)
    (ll : Γ'.Sem) : 
    (c.changeVars varsMap).denote ll = 
    c.denote (fun t v => ll (varsMap t v)) := by
  induction c generalizing ll Γ' with
  | ret x => simp [ICom.denote, ICom.changeVars, *]
  | lete _ _ ih => 
    rw [changeVars, denote, ih]
    simp only [Ctxt.Sem.snoc, Ctxt.Var.snocMap, IExpr.denote_changeVars, denote]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn
    . simp
    . simp

@[simp]
theorem IExprRec.denote_changeVars {Γ Γ' : Ctxt}
    (varsMap : (t : Ty) → Γ.Var t → Γ'.Var t)
    (e : IExprRec Γ ty)
    (ll : Γ'.Sem) : 
    (e.changeVars varsMap).denote ll = 
    e.denote (fun t v => ll (varsMap t v)) := by
  induction e generalizing ll <;> simp 
    [IExprRec.denote, *]




theorem denote_addProgramAtTop {Γ Γ' : Ctxt} (v : Γ'.Var t₁)
    (map : (t : Ty) → Γ.Var t → Γ'.Var t) (s : Γ'.Sem) :
    (rhs : ICom Γ t₁) → (inputProg : ICom Γ' t₂) → 
    (addProgramAtTop v map rhs inputProg).denote s =
      inputProg.denote (fun t' v' => 
        if h : ∃ h : t₁ = t', h ▸ v = v' 
        then h.fst ▸ rhs.denote (fun t' v' => s (map _ v'))
        else s v')
  | .ret e, inputProg => by
    simp only [addProgramAtTop, ICom.denote_changeVars, ICom.denote, ICom.substituteVar]
    congr
    funext t' v'
    split_ifs with h
    . rcases h with ⟨rfl, _⟩
      simp
    . rfl   
  | .lete e body, inputProg => by
    simp only [ICom.denote, IExpr.denote_changeVars]
    rw [denote_addProgramAtTop _ _ _ body]
    simp [ICom.denote_changeVars, Ctxt.Sem.snoc_toSnoc]
    congr
    funext t' v'
    by_cases h : ∃ h : t₁ = t', h ▸ v = v'
    . rcases h with ⟨rfl, h⟩
      dsimp at h
      simp [h]
      congr
      funext t'' v''
      cases v'' using Ctxt.Var.casesOn
      . simp [Ctxt.Sem.snoc, Ctxt.Var.snocMap]
      . simp [Ctxt.Sem.snoc, Ctxt.Var.snocMap]
    . rw [dif_neg h, dif_neg]
      rintro ⟨rfl, h'⟩ 
      simp only [Ctxt.toSnoc_injective.eq_iff] at h'
      exact h ⟨rfl, h'⟩  





theorem denote_addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt} 
    (v : Γ₂.Var t₁) (s : Γ₁.Sem)
    (map : (t : Ty) → Γ₃.Var t → Γ₂.Var t) 
    (l : Lets Γ₁ Γ₂) (rhs : ICom Γ₃ t₁)
    (inputProg : ICom Γ₂ t₂) :
    (addProgramInMiddle v map l rhs inputProg).denote s =
      inputProg.denote (fun t' v' => 
        let s' := l.denote s
        if h : ∃ h : t₁ = t', h ▸ v = v' 
        then h.fst ▸ rhs.denote (fun t' v' => s' (map _ v'))
        else s' v') := by
  rw [addProgramInMiddle, denote_addLetsAtTop, Function.comp_apply, 
    denote_addProgramAtTop]


theorem IExprRec.denote_bind {Γ₁ Γ₂ : Ctxt} (s : Γ₂.Sem) 
    (f : (t : Ty) → Γ₁.Var t → IExprRec Γ₂ t) :
    (e : IExprRec Γ₁ t) → (e.bind f).denote s = 
      e.denote (fun t' v' => (f t' v').denote s)
  | .var v => by simp [bind, denote]
  | .cst n => by simp [bind, denote]
  | .add e₁ e₂ => by
    simp only [IExprRec.denote, bind]
    rw [denote_bind _ _ e₁, denote_bind _ _ e₂]


@[simp]
theorem IExpr.denote_toExprRec : {Γ : Ctxt} → {t : Ty} → 
    (s : Γ.Sem) → (e : IExpr Γ t) → 
    e.toExprRec.denote s = e.denote s
  | _, _, _, .nat n => by simp [IExpr.toExprRec, IExpr.denote, IExprRec.denote]
  | _, _, s, .add e₁ e₂ => by
    simp only [IExpr.toExprRec, IExpr.denote, IExprRec.denote]

@[simp]
theorem ICom.denote_toExprRec : {Γ : Ctxt} → {t : Ty} → 
    (s : Γ.Sem) → (c : ICom Γ t) → 
    c.toExprRec.denote s = c.denote s
  | _, _, _, .ret e => by simp [ICom.toExprRec, ICom.denote, IExprRec.denote]
  | _, _, s, .lete e body => by
    simp only [ICom.toExprRec, ICom.denote, IExprRec.denote,
      IExpr.denote_toExprRec, IExprRec.denote_bind]
    rw [ICom.denote_toExprRec _ body]
    congr
    funext t' v'
    cases v' using Ctxt.Var.casesOn
    . simp [IExprRec.denote]
    . simp [IExpr.denote_toExprRec]

end