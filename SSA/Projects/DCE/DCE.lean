import SSA.Core.Framework

/-- Delete a variable from a list. -/
def Ctxt.delete (Γ : Ctxt Ty) (v : Γ.Var α) : Ctxt Ty := 
  Γ.removeNth v.val

/-- Witness that Γ' is Γ without v -/
def Deleted {α : Ty} (Γ: Ctxt Ty) (v : Γ.Var α) (Γ' : Ctxt Ty) : Prop := 
  Γ' = Γ.delete v


theorem List.removeNth_zero : List.removeNth (List.cons x xs) 0 = xs := rfl 

theorem List.removeNth_succ : List.removeNth (List.cons x xs) (.succ n) = x :: List.removeNth xs n := rfl

/- removing from `xs ++ [x]` at index `(length xs)` equals `xs`. -/
theorem List.removeNth_eq_len_snoc (hn : n = xs.length) : List.removeNth (xs ++ [x]) n = xs := by
  induction n generalizing xs x   
  case zero => 
    induction xs
    case nil => simp
    case cons x xs' IH => simp at hn
  case succ n' IH' => 
    induction xs
    case nil => simp at hn
    case cons x xs' IH => 
      simp[removeNth_succ]
      apply IH'
      simp at hn
      exact hn

/-- removing at any index `≥ xs.length` does not change the list. -/
theorem List.removeNth_gt_len (hn : xs.length ≤ n) : List.removeNth xs n = xs := by
  induction n generalizing xs   
  case zero => 
    induction xs
    case nil => simp
    case cons x xs' IH => simp at hn
  case succ n' IH' => 
    induction xs
    case nil => simp[removeNth]
    case cons x xs' IH => 
      simp[removeNth_succ]
      apply IH'
      simp at hn
      linarith

/- removing at index `n` does not change indices `k < n` -/
theorem List.get_removeNth_lt_n (hk: k < n) : List.get? (List.removeNth xs n) k = List.get? xs k := by 
  by_cases N_LEN:(xs.length ≤ n)
  case pos => simp[removeNth_gt_len N_LEN]
  case neg =>
    simp at N_LEN
    induction xs generalizing n k
    case nil => simp at N_LEN
    case cons hd tl IHxs =>
    cases n
    case zero => simp at hk
    case succ n' =>
      simp[List.removeNth_succ]
      cases k
      case zero => simp
      case succ k' =>
        simp[List.get?]
        apply IHxs
        linarith
        simp at N_LEN; linarith


/-- Removing index `n` shifts entires of `k ≥ n` by 1. -/
theorem List.get_removeNth_geq_n {xs : List α} {n : Nat} {k : Nat} (hk: n ≤ k) :
  (xs.removeNth n).get? k = xs.get? (k + 1) := by
  induction xs generalizing n k
  case nil => simp[removeNth, List.get]
  case cons hd tl IHxs => 
    simp[List.get];
    cases k
    case zero => 
      simp at hk
      subst hk
      simp[removeNth]
    case succ k' => 
      cases n
      case zero =>
        simp[List.removeNth_succ]
      case succ n' =>
        simp[List.removeNth_succ]
        apply IHxs
        linarith

/-- linarith fails to find a contradiction -/
theorem linarith_failure (x y : Nat) (H1 : ¬ (x = y)) (H2 : ¬ (x < y)) : x > y := 
  by 
    try linarith
    sorry

-- /-- Given  `Γ' := Γ /delv`, transport a variable from `Γ` to `Γ', if `v ≠ delv`. -/
-- def Deleted.pushforward_var {Γ Γ' : Ctxt Ty} {delv : Γ.Var α}
--   (DEL : Deleted Γ delv Γ') ⦃v : Γ.Var β⦄
--   (NEQ: v.val ≠ delv.val) : Γ'.Var β :=
--   if VEQ : v.val = delv.val
--   then by contradiction
--   else 
--   if VLT : v.val < delv.val
--   then ⟨v.val, by {
--     simp[Deleted] at DEL
--     subst DEL
--     have ⟨vix, vproof⟩ := v
--     simp[Ctxt.delete] at *
--     have H := List.get_removeNth_lt_n (xs := Γ) (n := delv.val) (k := vix) (hk := VLT)
--     rw[H]
--     exact vproof
--   }⟩
--   else ⟨v.val - 1, by {
--     have : v.val > delv.val := by {
--       -- No way I need this to prove this?
--       have H := Nat.lt_trichotomy v.val delv.val
--       cases H;
--       . contradiction
--       . case inr H => 
--         cases H;
--         . contradiction
--         . linarith
--     }
--     simp[Deleted] at DEL
--     subst DEL
--     have ⟨vix, vproof⟩ := v
--     simp[Ctxt.delete] at *
--     have : vix > 0 := by linarith
--     cases VIX:vix
--     case zero => subst VIX; contradiction
--     case succ vix' =>
--       have H := List.get_removeNth_geq_n (xs := Γ) (n := delv.val) (k := vix') (hk := by linarith)
--       simp
--       rw[H]
--       subst VIX
--       assumption
--   }⟩


/-- Given  `Γ' := Γ /delv`, transport a variable from `Γ'` to `Γ`. -/
def Deleted.pullback_var (DEL : Deleted Γ delv Γ') (v : Γ'.Var β) : Γ.Var β :=
  if DELV:v.val < delv.val 
  then ⟨v.val, by {
    simp[Deleted] at DEL
    subst DEL
    have ⟨vix, vproof⟩ := v
    simp[Ctxt.delete] at vproof
    have H := List.get_removeNth_lt_n (xs := Γ) (n := delv.val) (k := vix) (hk := DELV)
    rw[H] at vproof
    exact vproof
  }⟩
  else ⟨v.val + 1, by {
    simp[Deleted] at DEL
    subst DEL
    have ⟨vix, vproof⟩ := v
    simp[Ctxt.delete] at vproof
    have H := List.get_removeNth_geq_n (xs := Γ) (n := delv.val) (k := vix) (hk := by linarith)
    rw[H] at vproof
    exact vproof
  }⟩

-- pushforward a valuation.
def Deleted.pushforward_Valuation [Goedel Ty] {α: Ty}  {Γ Γ' : Ctxt Ty} {delv : Γ.Var α}
  (DEL : Deleted Γ delv Γ')
  (vΓ : Γ.Valuation) : Γ'.Valuation := 
  fun _t' v' => vΓ (DEL.pullback_var v')

-- evaluating a pushforward valuation at a pullback variable returns the same result.
theorem Deleted.pushforward_Valuation_denote [Goedel Ty] {α : Ty} {Γ Γ' : Ctxt Ty} {delv : Γ.Var α}
  (DEL : Deleted Γ delv Γ')
  (vΓ : Γ.Valuation)
  (v' : Γ'.Var α) :
  vΓ (DEL.pullback_var v') = (DEL.pushforward_Valuation vΓ) v' := by
    simp[pullback_var, pushforward_Valuation]
    

/-- Given  `Γ' := Γ /delv`, transport a variable from `Γ` to `Γ', if `v ≠ delv`. -/
def Var.tryDelete? [Goedel Ty] {Γ Γ' : Ctxt Ty} {delv : Γ.Var α}
  (DEL : Deleted Γ delv Γ') (v : Γ.Var β) : 
    Option { v' : Γ'.Var β //  ∀ (V : Γ.Valuation), V.eval v = (DEL.pushforward_Valuation V).eval v' } :=
  if VEQ : v.val = delv.val
  then none -- if it's the deleted variable, then return nothing.
  else 
  if VLT : v.val < delv.val
  then .some ⟨⟨v.val, by {
    simp[Deleted] at DEL
    subst DEL
    have ⟨vix, vproof⟩ := v
    simp[Ctxt.delete] at *
    have H := List.get_removeNth_lt_n (xs := Γ) (n := delv.val) (k := vix) (hk := VLT)
    rw[H]
    exact vproof
  }⟩, by
    simp[Deleted] at DEL
    subst DEL
    intros V
    have ⟨vix, vproof⟩ := v
    simp[Ctxt.delete] at *
    have H := List.get_removeNth_lt_n (xs := Γ) (n := delv.val) (k := vix) (hk := VLT)
    simp[Ctxt.Valuation.eval]
    simp[Deleted.pushforward_Valuation]
    simp[Deleted.pullback_var]
    split_ifs;
    case pos _ => rfl
    case neg contra =>
      simp at VLT 
      contradiction
  ⟩
  else .some ⟨⟨v.val - 1, by {
    have : v.val > delv.val := by {
      -- No way I need this to prove this?
      have H := Nat.lt_trichotomy v.val delv.val
      cases H;
      . contradiction
      . case inr H => 
        cases H;
        . contradiction
        . linarith
    }
    simp[Deleted] at DEL
    subst DEL
    have ⟨vix, vproof⟩ := v
    simp[Ctxt.delete] at *
    have : vix > 0 := by linarith
    cases VIX:vix
    case zero => subst VIX; contradiction
    case succ vix' =>
      have H := List.get_removeNth_geq_n (xs := Γ) (n := delv.val) (k := vix') (hk := by linarith)
      simp
      rw[H]
      subst VIX
      assumption
  }⟩, by
        have : v.val > delv.val := by
          -- No way I need this to prove this?
          have H := Nat.lt_trichotomy v.val delv.val
          cases H;
          . contradiction
          . case inr H => 
            cases H;
            . contradiction
            . linarith
        simp[Deleted] at DEL
        subst DEL
        have ⟨vix, vproof⟩ := v
        simp[Ctxt.delete] at *
        have : vix > 0 := by linarith
        intros V
        simp[Ctxt.Valuation.eval, Deleted.pushforward_Valuation, Deleted.pullback_var]
        cases vix
        case zero => contradiction
        case succ vix' =>
          split_ifs
          case pos hvix' => 
            exfalso
            simp at hvix'
            linarith
          case neg hvix' => 
            congr
    ⟩

namespace DCE
variable [Goedel Ty] [OpSignature Op Ty] [OpDenote Op Ty] [DecidableEq Ty]

/-- Try to delete the variable from the argument list.
  Succeeds if variable does not occur in the argument list.
  Fails otherwise. -/
def arglistDeleteVar? {Γ: Ctxt Ty} {delv : Γ.Var α} {Γ' : Ctxt Ty} {ts : List Ty}
  (DEL : Deleted Γ delv Γ')
  (as : HVector (Ctxt.Var Γ) <| ts) : 
  Option 
    { as' : HVector (Ctxt.Var Γ') <| ts // ∀ (V : Γ.Valuation), as.map V.eval = as'.map (DEL.pushforward_Valuation V).eval  } :=
  match as with
  | .nil => .some ⟨.nil, by
      simp[HVector.map]
    ⟩
  | .cons a as => 
    match Var.tryDelete? DEL a with
    | .none => .none
    | .some ⟨a', ha'⟩ =>
      match arglistDeleteVar? DEL as with
      | .none => .none
      | .some ⟨as', has'⟩ =>
        .some ⟨.cons a' as', by
          intros V
          simp[HVector.map]
          constructor
          apply ha'
          apply has'
        ⟩  

def IExpr.deleteVar? (DEL : Deleted Γ delv Γ') (e: IExpr Op Γ t) : 
  Option { e' : IExpr Op Γ' t // ∀ (V : Γ.Valuation), e.denote V = e'.denote (DEL.pushforward_Valuation V) } := 
  match e with
  | .mk op ty_eq args regArgs => 
    match arglistDeleteVar? DEL args with
    | .none => .none
    | .some args' =>
      .some ⟨.mk op ty_eq args' regArgs, by
        intros V
        rw[IExpr.denote_unfold]
        rw[IExpr.denote_unfold]
        simp
        congr 1
        apply args'.property
      ⟩

/-- snoc an `ω` to both the input and output contexts of `Deleted Γ v Γ'` -/
def Deleted.snoc {α : Ty} {Γ: Ctxt Ty} {v : Γ.Var α} (DEL : Deleted Γ v Γ') : Deleted (Γ.snoc ω) v.toSnoc (Γ'.snoc ω) := by
  simp [Deleted, Ctxt.delete] at DEL ⊢
  subst DEL
  rfl


/-- pushforward (V :: newv) (pushforward V) :: newv -/
theorem Deleted.pushforward_Valuation_snoc  {Γ Γ' : Ctxt Ty} {ω : Ty} {delv : Γ.Var α}
  (DEL : Deleted Γ delv Γ')
  (DELω : Deleted (Ctxt.snoc Γ ω) delv.toSnoc (Ctxt.snoc Γ' ω))
  (V : Γ.Valuation) {newv : Goedel.toType ω} :
  DELω.pushforward_Valuation (V.snoc newv) = 
  (DEL.pushforward_Valuation V).snoc newv := by 
    simp[Deleted.pushforward_Valuation]
    simp[Ctxt.Valuation.snoc]
    simp[Deleted.pullback_var]
    funext t var
    split_ifs
    case pos => 
      

    case neg => sorry


    

/-- This is true, because both DEL and DELω delete 'delv', so they leave the 'newv' unedited. -/
theorem pushforward_Valuation_snoc {Γ Γ' : Ctxt Ty} {ω : Ty} {delv : Γ.Var α}
  (DEL : Deleted Γ delv Γ')
  (DELω : Deleted (Ctxt.snoc Γ ω) delv.toSnoc (Ctxt.snoc Γ' ω))
  (V : Γ.Valuation) {newv : Goedel.toType ω} :
  DELω.pushforward_Valuation (V.snoc newv) = (DEL.pushforward_Valuation V).snoc newv := sorry
    



def ICom.deleteVar? (DEL : Deleted Γ delv Γ') (com : ICom Op Γ t) : 
  Option { com' : ICom Op Γ' t // ∀ (V : Γ.Valuation), com.denote V = com'.denote (DEL.pushforward_Valuation V) } :=
  match com with
  | .ret v =>
    match Var.tryDelete? DEL v with
    | .none => .none
    | .some ⟨v, hv⟩ => 
      .some ⟨.ret v, hv⟩
  | .lete (α := ω) e body =>
    match ICom.deleteVar? (Deleted.snoc DEL) body with
    | .none => .none
    | .some ⟨body', hbody'⟩ =>
      match IExpr.deleteVar? DEL e with
        | .none => .none
        | .some ⟨e', he'⟩ =>
          .some ⟨.lete  e' body', by
            intros V
            simp[ICom.denote]
            rw[← he']
            rw[hbody']
            congr
            apply pushforward_Valuation_snoc
            ⟩ 


-- #check Membership

/-- inject a context `Γ` into the context `(Γ.snoc α)` -/
def Ctxt.Hom.toSnoc {Γ : Ctxt Ty} : Ctxt.Hom Γ (Γ.snoc α) := 
  fun _t v => v.toSnoc

/-- swap (Γ.snoc α).snoc ω → (Γ.snoc ω).snoc α -/
def Ctxt.Hom.swapSnocSnoc {Γ : Ctxt Ty} : Ctxt.Hom ((Γ.snoc α).snoc ω) ((Γ.snoc ω).snoc α) := 
  fun _t ⟨v, vh⟩ => 
      if V0 : v = 0 then
      ⟨1, by 
        subst V0
        simp[List.get?] at vh ⊢
        exact vh
      ⟩
      else if V1: v = 1 then ⟨0, by
        subst V1
        simp[List.get?] at vh ⊢
        exact vh
      ⟩
      else ⟨v, by
        simp[List.get?] at vh ⊢
        cases v <;> try contradiction
        case succ v' =>
        cases v' <;> try contradiction
        simp[List.get?] at vh ⊢
        exact vh      
      ⟩

-- inductive DCEResult [OpSignature Op Ty] [OpDenote Op Ty] {Γ : Ctxt Ty} {α : Ty} {t : Ty} (com : ICom Op (Γ.snoc α) t) where
-- | failure  (com' : ICom Op (Γ.snoc α) t) 
-- | success
--   (com' : ICom Op Γ t)
--   (denote_eq : ∀ (Γαv : (Γ.snoc α).Valuation), com.denote Γαv = com'.denote (Γαv.hom Ctxt.Hom.toSnoc)  )

lemma List.get?_snoc (H : List.get? (x :: xs) (ix + 1) = some v) :
  List.get? xs ix = some v := by simp at H; assumption 

/-- try to unSnoc a `Var`, creating a var that has the same value on being evaluated. -/
def Var.tryUnsnoc {Γ : Ctxt Ty} {α β : Ty} (v : (Γ.snoc α).Var β) :
  Option { v' : Γ.Var β //   ∀ (V : (Γ.snoc α).Valuation), V.eval v = (V.hom Ctxt.Hom.toSnoc).eval v' } := 
if H : v.val > 0 
then .some ⟨⟨v.val - 1, by
  have V := v.property
  cases VVAL : v.val
  case zero => 
    rw[VVAL] at H
    contradiction
  case succ v' =>
    simp
    rw[VVAL] at V
    exact List.get?_snoc V
  ⟩, by
    intros V
    simp only[Ctxt.Valuation.hom, Ctxt.Valuation.eval, Ctxt.Hom.toSnoc, Ctxt.Var.toSnoc]
    congr
    induction v
    case e_a.mk val property =>
      simp at H
      simp
      congr
      simp
      rw[Nat.sub_add_cancel]
      linarith
  ⟩
else .none

/-- try to unSnoc a vector of `Var` s by unSnocing each `Var`. -/
def VarVector.tryUnsnoc {Γ : Ctxt Ty} {α : Ty} {ts : List Ty}
  (vec : HVector ((Γ.snoc α).Var) <| ts) :
  Option 
  { vec' : HVector (Γ.Var) <| ts // ∀ (V : (Γ.snoc α).Valuation), vec.map V.eval = vec'.map (V.hom Ctxt.Hom.toSnoc).eval } :=
  match vec with
  | .nil => 
    .some ⟨.nil, by
      intros V
      simp[HVector.map]
      ⟩
  | .cons x xs => 
    match Var.tryUnsnoc x with
    | .none => .none
    | .some ⟨v', hv⟩ => 
      match VarVector.tryUnsnoc xs with
      | .none => .none
      | .some ⟨vec', hvec⟩ => 
        .some ⟨.cons v' vec', by 
          intros V
          simp[HVector.map]
          constructor
          apply hv
          apply hvec
        ⟩ 

/-- try to unSnoc an IExpr by unSnocing all the argument `Var`s.
  Note that since our regions are `isolatedFromAbove`, that is, they create a new context for themselves,
  we can leave the regions unchanged. -/
def IExpr.tryUnsnoc [OpSignature Op Ty] [OpDenote Op Ty] (e : IExpr Op (Γ.snoc α) t) :
  Option { e' : IExpr Op Γ t // ∀ (V : (Γ.snoc α).Valuation), e.denote V = e'.denote (V.hom Ctxt.Hom.toSnoc) } := 
  match e with
  | .mk op ty_eq args regArgs => 
    match VarVector.tryUnsnoc args with
    | .none => .none
    | .some args' =>
      .some ⟨.mk op ty_eq args' regArgs, by
        intros V
        rw[IExpr.denote_unfold]
        rw[IExpr.denote_unfold]
        simp
        congr 1
        apply args'.property
      ⟩


partial def ICom.tryUnsnoc [OpSignature Op Ty] [OpDenote Op Ty] (com : ICom Op (Γ.snoc α) t) : 
  Option { com' : ICom Op Γ t // ∀ (V : (Γ.snoc α).Valuation), com.denote V = com'.denote (V.hom Ctxt.Hom.toSnoc) } :=
  match com with
  | .ret v =>
    match Var.tryUnsnoc v with
    | .none => .none
    | .some ⟨v, hv⟩ => 
      .some ⟨.ret v, hv⟩
  | .lete (α := ω) e body => -- variable added here is a `ω`; `body: ICom Op (Ctxt.snoc (Ctxt.snoc Γ α) ω) t`
    -- TOTHINK:
    -- this is annoying, I need to shuffle the `Ctxt` into a 
    -- (Ctxt.snoc (Ctxt.snoc Γ ω) α) to be able to expose the `α`
    let body_α_outmost := body.changeVars Ctxt.Hom.swapSnocSnoc
    let SIZE : sizeOf (ICom.changeVars Ctxt.Hom.swapSnocSnoc body) ≤ sizeOf e + sizeOf body := by sorry      
    match ICom.tryUnsnoc body_α_outmost with
    | .none => .none
    | .some ⟨body', hbody'⟩ =>
      match IExpr.tryUnsnoc e with
        | .none => .none
        | .some ⟨e', he'⟩ =>
          .some ⟨.lete  e' body', sorry⟩ 

def dce [OpSignature Op Ty] [OpDenote Op Ty]  {Γ : Ctxt Ty} {t : Ty} (com : ICom Op Γ t) : 
  Σ (Γ' : Ctxt Ty) (hom: Ctxt.Hom Γ' Γ),
    { com' : ICom Op Γ' t //  ∀ (V : Γ.Valuation), com.denote V = com'.denote (V.hom hom)} := 
    match com with
    | .ret v => 
      ⟨Γ, Ctxt.Hom.id, ⟨.ret v, by 
        intros V
        simp[Ctxt.Valuation.hom]
        ⟩⟩
    | .lete (α := α) e body => 
      let ⟨Γ2, hom12, com2⟩ := dce body
      sorry 

end DCE