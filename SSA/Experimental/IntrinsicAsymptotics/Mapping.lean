import SSA.Experimental.ErasedContext


def Mapping.Pair (Γ Δ : Ctxt) := Σ t, Γ.Var t × Δ.Var t

/-- `Mapping Γ Δ` is an incrementally built a mapping from variables in `Γ` to variables in `Δ` -/
def Mapping (Γ Δ : Ctxt) := List (Mapping.Pair Γ Δ)

/-- `map.insert v v'` asserts that `v` maps to `v'`
    * if `v` and `w` have different types, return `none`
    * if `v` is not present in the map yet, insert the pair `(v, v')` into the map
    * otherwise, if there is a pair `(v, w)`, with `v` on the left hand side, then 
        - return the map unchanged if `w = v'`, or
        - return `none` otherwise
-/
def Mapping.insert (map : Mapping Γ Δ) (v₁ : Γ.Var t₁) (v₂ : Δ.Var t₂) : Option (Mapping Γ Δ) :=
  if h : t₁ = t₂ then
    go map v₁ <| cast (by rw[h]) v₂
  else
    none
where
  go {t} (map : Mapping Γ Δ) (v₁ : Γ.Var t) (v₂ : Δ.Var t) : Option (Mapping Γ Δ) :=
  match map with
    | [] => some [⟨t, v₁, v₂⟩]
    | origMap@(⟨t', w₁, w₂⟩ :: map) =>
        if w₁.1 = v₁.1 then
          if w₂.1 = v₂.1 then
            some origMap
          else
            none          
        else
          (go map v₁ v₂).map (⟨t', w₁, w₂⟩ :: ·)

/-- The empty mapping -/
def Mapping.empty : Mapping Γ Δ := []

/--
  Create a new mapping, and add an assignment, after checking that the types match.
  This operation can fail, since the types might be different
-/
def Mapping.new (v₁ : Γ.Var t₁) (v₂ : Δ.Var t₂) : Option (Mapping Γ Δ) :=
  if h : t₁ = t₂ then
    let v₂ := cast (by rw[h]) v₂
    some [⟨t₁, v₁, v₂⟩]
  else
    none


/-- Lookup the assignment for a specific variable -/
def Mapping.lookup : Mapping Γ Δ → (t : Ty) → Γ.Var t → Option (Δ.Var t)
  | [],             _, _  => none
  | ⟨t, v, w⟩::map, t', v' =>
      if h : v.1 = v'.1 then
        have t_eq_t' := Ctxt.Var.type_eq_of_index_eq h
        some <| cast (by rw[t_eq_t']) w
      else
        lookup map t' v'


structure TotalMapping (Γ Δ : Ctxt) (V : Γ.VarSet) where
  inner : Mapping Γ Δ
  -- isTotal : ∀ t, ∀ v ∈ expr.vars, (inner.lookup t v).isSome
  isTotal : ∀ t, ∀ v ∈ V t, (inner.lookup t v).isSome

def TotalMapping.empty : TotalMapping Γ Δ ∅ :=
  ⟨[], by intros; contradiction⟩


/-- After `insert`ing a variable mapping for `v`, `lookup` is guaranteed to be defined on `v` -/
theorem Mapping.lookup_insert_same (map mapInsert : Mapping Γ Δ) {v : Γ.Var t₁} (w : Δ.Var t₂)
    (h : map.insert v w = some mapInsert) :
    (mapInsert.lookup _ v).isSome := by
  unfold insert at h
  unfold Option.isSome
  split_ifs at h
  induction map generalizing mapInsert
  next =>
    simp only [insert.go, Option.some.injEq] at h 
    simp [←h, Option.isSome, lookup]
  next m map ih =>
    simp only [insert.go, Prod.mk.eta, Sigma.eta] at h    
    split_ifs at h <;> simp at h
    . cases h
      simp only [lookup]
      split_ifs
      rfl
    . rcases h with ⟨tl, ⟨h₁, ⟨⟩⟩⟩
      simp[lookup]
      split_ifs
      apply ih _ h₁

/-- If `insert` succeeds, it only add new mappings.
    Thus if `lookup` is defined previous to an insert, then lookup will remain defined afterwards
 -/
theorem Mapping.lookup_insert_preserve (map mapInsert : Mapping Γ Δ) {v : Γ.Var t₁} (w : Δ.Var t₂)
    {v' : Γ.Var t₃} (h : map.insert v w = some mapInsert) :
    (map.lookup t₃ v').isSome → (mapInsert.lookup t₃ v').isSome := by
  unfold insert at h
  unfold Option.isSome
  split_ifs at h
  induction map generalizing mapInsert
  next =>
    simp only [insert.go, Option.some.injEq] at h 
    simp [←h, Option.isSome, lookup]
  next m map ih =>
    simp only [insert.go, Prod.mk.eta, Sigma.eta] at h    
    split_ifs at h <;> simp at h
    . cases h
      exact id
    . rcases h with ⟨tl, ⟨h₁, ⟨⟩⟩⟩
      simp[lookup]
      split_ifs
      . exact id
      . apply ih _ h₁
  
/--
  By inserting into a total mapping, we expand the set of variables that it is defined on
-/
def TotalMapping.insert (map : TotalMapping Γ Δ V) (v : Γ.Var t₁) (w : Δ.Var t₂) : 
    Option (TotalMapping Γ Δ (V ∪ {⟨_, v⟩})) := 
  match hm : map.inner.insert v w with
    | .some mapI => some {
        inner := mapI
        isTotal := by 
          intro t' v' h
          rcases map with ⟨map, isTotal⟩          
          dsimp[Membership.mem, Set.Mem, Union.union, Set.union, setOf] at h
          cases h
          next h => 
            apply Mapping.lookup_insert_preserve map mapI w hm
            apply isTotal _ _ h
          next h =>
            apply Mapping.lookup_insert_same map mapI w
            simp at h
            cases (Ctxt.Var.type_eq_of_index_eq h)
            rcases v with ⟨v, hv⟩
            rcases v' with ⟨v', hv'⟩
            cases h
            apply hm
      }
    | .none => none


/-- Change the set of variables that a total mapping is known to be defined on  -/
def TotalMapping.coerceDomain {Γ : Ctxt} {V V' : Γ.VarSet} (h : V = V') : 
    TotalMapping Γ Δ V → TotalMapping Γ Δ V' 
  | ⟨inner, isTotal⟩ => ⟨inner, by simp_all⟩

/-- `lookup` a variable that is known to occur in a total map -/
def TotalMapping.lookupMem (map : TotalMapping Γ Δ V) (t : Ty) (v : Γ.Var t) : v ∈ V t → Δ.Var t :=
  (map.inner.lookup t v).get ∘ map.isTotal t v

/-- If the set of known-assigned variables is complete w.r.t. its context, then we can return a 
    total change of variables function -/
def TotalMapping.lookup (map : TotalMapping Γ Δ V) (h : V.IsComplete) (t : Ty) (v : Γ.Var t) :
    Δ.Var t :=
  map.lookupMem t v (h t v)