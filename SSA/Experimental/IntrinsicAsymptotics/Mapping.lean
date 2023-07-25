import SSA.Experimental.IntrinsicAsymptotics.Context


/-! ### Mapping -/

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




/-! ### Total Mapping -/

/--
  A `TotalMapping Γ Δ V` is just a `Mapping`, with extra knowledge about the variables that are
  alreaady assigned.
  That is, `constraints` is a list of pairs `(V, W)` of variables in the domain and codomain, 
  respectively, such that each variable `v ∈ V` is assigned to a variable `w ∈ W` in the 
  corresponding set.
  These constraints form a stack. `insert v w` adds `v` to the top-most set `V`, and require that 
  `w` is already present in the top-most `W`.
-/
structure TotalMapping (Γ Δ : Ctxt) (constraints : List (Γ.VarSet × Δ.VarSet)) where
  inner : Mapping Γ Δ
  isTotal : ∀ V W, (V, W) ∈ constraints → 
    ∀ t, ∀ v ∈ V t, ∃ w ∈ W t, inner.lookup t v = some w

/-- An empty map, with `W` as the top-most constraint on the codomain -/
def TotalMapping.empty (W : Δ.VarSet) : TotalMapping Γ Δ [(∅, W)] :=
  ⟨[], by intro V W mem h v v_mem; simp at mem; simp[mem] at v_mem; contradiction⟩


/-- Adds a new top-most constraint, without changing anything about the underlying map -/
def TotalMapping.newConstraint (W : Δ.VarSet) :
    TotalMapping Γ Δ constraints → TotalMapping Γ Δ ((∅, W) :: constraints)
  | ⟨map, isTotal⟩ => ⟨map, by
      intro V W mem
      cases mem
      next => intros; contradiction
      next mem_tl => apply isTotal V W mem_tl
    ⟩ 

/-- Combine the two top-most constraints, by taking the union of the respective sets -/
def TotalMapping.popConstraint :
    TotalMapping Γ Δ ((V₁, W₁) :: (V₂, W₂) :: constraints) 
    → TotalMapping Γ Δ ((V₁ ∪ V₂, W₁ ∪ W₂) :: constraints)
  | ⟨map, isTotal⟩ => ⟨map, by
      intro V W mem
      cases mem
      case head =>
        intro t v h_v
        cases h_v
        case inl h_v =>
          rcases isTotal V₁ W₁ (List.Mem.head _) t v h_v with ⟨w, mem_w, h_lookup⟩
          refine ⟨w, Or.inl mem_w, h_lookup⟩ 
        case inr h_v =>
          rcases isTotal V₂ W₂ (List.Mem.tail _ <| List.Mem.head _) t v h_v with ⟨w, mem_w, h_lookup⟩
          refine ⟨w, Or.inr mem_w, h_lookup⟩ 
      case tail mem =>
        apply isTotal V W (List.Mem.tail _ <| List.Mem.tail _ mem)
    ⟩



/-- If mapping succeeds, then `v` and `w` must have the same type -/
theorem Mapping.type_eq_of_insert_isSome {map : Mapping Γ Δ} {v : Γ.Var t₁} {w : Δ.Var t₂} :
    map.insert v w = some mapI → t₁ = t₂ := by
  simp only [insert, Option.isSome]
  split_ifs
  . intro; assumption
  . exact False.elim


/-- After `insert`ing a variable mapping for `v`, `lookup` is guaranteed to be defined on `v` -/
theorem Mapping.lookup_insert_same (map mapInsert : Mapping Γ Δ) {v : Γ.Var t₁} (w : Δ.Var t₂)
    (h_insert : map.insert v w = some mapInsert) :
    (mapInsert.lookup _ v) = some (cast (by rw[type_eq_of_insert_isSome h_insert]) w) := by
  cases (type_eq_of_insert_isSome h_insert)
  simp only [insert, cast_eq, dite_eq_ite, ite_true] at h_insert 
  simp only [cast_eq]  

  induction map generalizing mapInsert
  next =>
    simp only [insert.go, Option.some.injEq] at h_insert
    simp [←h_insert, Option.isSome, lookup]
  next m map ih =>
    simp only [insert.go, Prod.mk.eta, Sigma.eta] at h_insert
    split_ifs at h_insert <;> simp at h_insert
    next h_v h_w =>
      cases h_insert
      simp only [lookup]
      split_ifs
      
      rcases m with ⟨tm, ⟨v', v'_prop⟩, ⟨w', w'_prop⟩⟩
      rcases w with ⟨w, w_prop⟩
      cases h_w
      rw[w'_prop, Option.some_inj] at w_prop
      cases w_prop

      rfl
    next => 
      rcases h_insert with ⟨tl, ⟨h₁, ⟨⟩⟩⟩
      simp[lookup]
      split_ifs
      simp at ih
      apply ih _ h₁

      

/-- If `insert` succeeds, it only add new mappings.
    Thus if `lookup` is defined previous to an insert, then lookup will remain defined afterwards
 -/
theorem Mapping.lookup_insert_preserve (map mapInsert : Mapping Γ Δ) {v : Γ.Var t₁} (w : Δ.Var t₂)
    {v' : Γ.Var t₃} (h : map.insert v w = some mapInsert) (z) :
    (map.lookup t₃ v') = some z → (mapInsert.lookup t₃ v') = some z := by
  unfold insert at h
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
def TotalMapping.insert (map : TotalMapping Γ Δ ((V,W) :: tl)) (v : Γ.Var t₁) (w : Δ.Var t₂) 
    (h_w : w ∈ W _) : 
    Option (TotalMapping Γ Δ ((V ∪ {⟨_, v⟩}, W) :: tl)) := 
  match h_insert : map.inner.insert v w with
    | .some mapI => some {
        inner := mapI
        isTotal := by 
          intro V W h_mem t' v' h_v'
          cases (Mapping.type_eq_of_insert_isSome h_insert)
          rcases map with ⟨map, isTotal⟩
          cases h_mem
          next =>
            specialize isTotal V W (List.Mem.head ..) t' v'
            dsimp[Membership.mem, Set.Mem, Union.union, Set.union, setOf] at h_v'
            cases h_v'
            next h_v' => 
              rcases isTotal h_v' with ⟨w', h_w', h_lookup⟩
              refine ⟨w', h_w', ?_⟩
              apply Mapping.lookup_insert_preserve 
              <;> assumption              
            next h_v' =>
              rcases v with ⟨v, prop_v⟩
              rcases v' with ⟨v', prop_v'⟩
              cases h_v'
              rw[prop_v', Option.some_inj] at prop_v
              cases prop_v
              
              rw [Mapping.lookup_insert_same map mapI w h_insert, cast_eq]
              exact ⟨w, h_w, rfl⟩
            
          next h_mem =>
            rcases isTotal _ _ (List.Mem.tail _ h_mem) t' v' h_v' with ⟨w', h_w', h_insert⟩
            refine ⟨w', h_w', ?_⟩
            apply Mapping.lookup_insert_preserve 
            <;> assumption         
      }
    | .none => none





/-- Change the set of variables that a total mapping is known to be defined on  -/
def TotalMapping.coerceConstraint {Γ : Ctxt} {V V' : Γ.VarSet} {W W' : Δ.VarSet} {cs}
    (hV : V = V') (hW : W = W') : 
    TotalMapping Γ Δ ((V, W) :: cs) → TotalMapping Γ Δ ((V', W') :: cs)
  | ⟨inner, isTotal⟩ => ⟨inner, by cases hV; cases hW; exact isTotal⟩


/-- A specialization of the `isTotal` property to just the constraint at the top of the stack -/
theorem TotalMapping.isTotal_head (map : TotalMapping Γ Δ ((V, W) :: cs)) :
    ∀ v ∈ V t, ∃ w ∈ W t, map.inner.lookup t v = some w :=
  map.isTotal V W (List.Mem.head _) t

/-- `lookup` a variable that is known to occur in a total map -/
def TotalMapping.lookupMem (map : TotalMapping Γ Δ ((V, W) :: cs)) (t : Ty) (v : Γ.Var t) : 
    v ∈ V t → {w : Δ.Var t // w ∈ W t} :=
  fun h_v => ⟨
    (map.inner.lookup t v).get (by
      rcases (map.isTotal_head v h_v) with ⟨w, _, eq⟩
      rw[Option.isSome, eq]
    ),
    by 
      rcases (map.isTotal_head v h_v) with ⟨w, h_w, eq⟩
      have : Option.isSome (Mapping.lookup map.inner t v) := by
        simp_all
      rw [Option.get_of_mem this ?_]
      . assumption
      . rw[eq]; rfl
  ⟩

/-- If the set of known-assigned variables is complete w.r.t. its context, then we can return a 
    total change of variables function -/
def TotalMapping.lookup (map : TotalMapping Γ Δ ((V, W) :: cs)) (h : V.IsComplete) (t : Ty) (v : Γ.Var t) :
    Δ.Var t :=
  map.lookupMem t v (h t v)