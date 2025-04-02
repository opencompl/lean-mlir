/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Aesop

/- Question:
why does `Decidable (s ∈ l)` require `LawfulBEq` if `l` is a list but `DecidableEq` if `l` is an array?
-/
-- Practical ways to relate Finsets and HashSets

@[simp]
theorem ofBool_1_iff_true : BitVec.ofBool b = 1#1 ↔ b := by
  cases b <;> simp

@[simp]
theorem ofBool_0_iff_false : BitVec.ofBool b = 0#1 ↔ ¬ b := by
  cases b <;> simp

 theorem List.dropLast_nodup (l : List X) : l.Nodup → l.dropLast.Nodup := by
  have hsl := List.dropLast_sublist l
  apply List.Nodup.sublist; trivial

-- TODO: make it better
@[simp]
theorem Array.take_ge_size {a : Array α} {n} (h : n ≥ a.size) : a.take n = a := by
  simp [Array.take, Array.extract]
  have heq : min n a.size = a.size := by omega
  rw [heq]
  have h := @Array.extract_size _ a
  rewrite [Array.extract] at h
  simp_all


@[simp]
theorem Array.take_zero {a : Array α} : a.take 0 = #[] := eq_empty_of_size_eq_zero (by simp)

theorem Array.mem_take_iff_getElem {a : Array α} {n} :
    x ∈ a.take n ↔ (∃ (i : Nat) (hm : i < min n a.size), a[i] = x):= by
  rw [mem_def, Array.toList_extract, List.mem_take_iff_getElem]; rfl

theorem Array.mem_take_iff_getElem? {a : Array α} {n} :
    x ∈ a.take n ↔ (∃ (i : Nat) (_ : i < n), a[i]? = some x):= by
  rw [mem_take_iff_getElem]
  constructor
  · rintro ⟨i, hm, heq⟩
    exists i, (by omega)
    rw [getElem?_eq_getElem, heq]
  · rintro ⟨i, hm, heq⟩
    obtain ⟨hm', heq⟩ := Array.getElem?_eq_some_iff.mp heq
    exists i, (by omega)

theorem Array.mem_take_get?_succ {a : Array α} {n} :
    x ∈ a.take (n + 1) ↔ (a[n]? = some x ∨ x ∈ a.take n):= by
  repeat rw [Array.mem_take_iff_getElem?]
  constructor
  · rintro ⟨i, hm, _⟩
    by_cases i = n
    · left; simp_all
    · right; exists i, (by omega)
  · rintro (h | ⟨i, hi, heq⟩)
    · exists n, (by omega)
    · exists i, (by omega)

theorem Array.mem_take_get_succ {a : Array α} {n} (h : n < a.size) : x ∈ a.take (n + 1) ↔ (a[n]'h = x ∨ x ∈ a.take n):= by
  simp [mem_take_get?_succ, getElem?_eq_getElem h]

theorem Array.push_incl {a : Array α} {x : α} (y : α) : x ∈ a → x ∈ a.push y := by
  simp [Array.push]
  intros h
  left
  exact h

theorem Std.HashMap.keys_nodup [BEq K] [LawfulBEq K] [Hashable K] (m : Std.HashMap K V) : m.keys.Nodup := by
  unfold List.Nodup
  have x := distinct_keys (m := m)
  simp_all

@[aesop safe]
theorem Std.HashMap.mem_keys_insert_new [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] (m : Std.HashMap K V) (k : K) : k ∈ m.insert k v := by
  apply mem_insert.mpr; simp_all only [beq_self_eq_true, true_or]

@[aesop 80% unsafe]
theorem Std.HashMap.mem_keys_insert_old [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] (m : Std.HashMap K V) (k k' : K) :
    k ∈ m → k ∈ m.insert k' v := by
  intros _; apply mem_insert.mpr; simp_all only [beq_iff_eq, or_true]

-- Unclear to me why `Inhabited` is required...
theorem Std.HashMap.mem_iff_getElem? [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] [Inhabited V] {m : Std.HashMap K V} {k : K} :
     k ∈ m ↔ ∃ v, m[k]? = some v := by
  constructor
  · rintro hin
    rw [getElem?_eq_some_getD (fallback := default) hin]
    simp
  · rintro ⟨v, heq⟩
    rw [Std.HashMap.mem_iff_contains, Std.HashMap.contains_eq_isSome_getElem?]
    simp_all

-- make equiv
@[aesop 50% unsafe]
theorem Std.HashMap.get?_none_not_mem [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] {m : Std.HashMap K V} {k : K} : m.get? k = none → k ∉ m := by
  simp

@[aesop 50% unsafe]
theorem Std.HashMap.getElem?_none_not_mem [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] {m : Std.HashMap K V} {k : K} :
    m[k]? = none → k ∉ m :=
  fun a => get?_none_not_mem a

@[aesop 50% unsafe]
theorem Std.HashMap.mem_of_getElem? [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] {m : Std.HashMap K V} {k : K} :
    m[k]? = some v → k ∈ m := by
  rintro heq
  have _ : Inhabited V := ⟨v⟩
  apply mem_iff_getElem?.mpr ⟨v, heq⟩

@[aesop 50% unsafe]
theorem Std.HashMap.insert_keys_perm_new [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] (m : Std.HashMap K V) (k : K) (v : V) :
    k ∉ m → (m.insert k v).keys.Perm (k :: m.keys) := by
  sorry

instance subtypeBEq [BEq α]  (P : α → Prop) : BEq { x // P x } := { beq := fun x y => x.val == y.val }
instance [BEq α] [LawfulBEq α]  (P : α → Prop) : LawfulBEq { x // P x } := by constructor <;> simp [subtypeBEq]

-- is it sound? maybe we somehow need to know which instance for BEq was used to prevent some
-- weird stuff...
@[inline] private unsafe def Std.HashSet.attachWithImpl [BEq α] [LawfulBEq α] [Hashable α] [LawfulHashable α]
    (xs : Std.HashSet α) (P : α → Prop) (_ : ∀ x ∈ xs, P x) : Std.HashSet {x // P x} := unsafeCast xs

/-- `O(1)`. "Attach" a proof `P x` that holds for all the elements of `xs` to produce a new hash set
  with the same elements but in the type `{x // P x}`. -/
@[implemented_by attachWithImpl] def Std.HashSet.attachWith [BEq α] [LawfulBEq α] [Hashable α] [LawfulHashable α]
    (xs : Std.HashSet α) (P : α → Prop) (H : ∀ x ∈ xs, P x) : Std.HashSet {x // P x} :=
  Std.HashSet.ofList <| xs.toList.attachWith P fun x h => H x (mem_toList.mp h)

@[simp]
theorem Std.HashSet.mem_attachWith_mem [BEq α] [Hashable α] [LawfulBEq α] (m : HashSet α) {P H} (x : α) h :
    ⟨x, h⟩ ∈ m.attachWith P H ↔ x ∈ m := by
  sorry

@[simp]
theorem Std.HashSet.mem_union [BEq α] [Hashable α] [LawfulBEq α] {m₁ m₂ : HashSet α} :
    x ∈ m₁.union m₂ ↔ x ∈ m₁ ∨ x ∈ m₂ := by
  sorry

@[simp]
theorem Std.HashSet.isEmpty_union_iff_isEmpty [BEq α] [Hashable α] [LawfulBEq α] {m₁ m₂ : HashSet α} :
    (m₁.union m₂).isEmpty ↔ m₁.isEmpty ∧ m₂.isEmpty := by
  simp only [isEmpty_iff_forall_not_mem, mem_union, not_or, forall_and]

@[simp]
theorem Std.HashMap.mem_keysArray [BEq α] [Hashable α] [LawfulBEq α] [LawfulHashable α] {m : HashMap α β} {k : α} :
    k ∈ m.keysArray ↔ k ∈ m := by
  sorry

-- TODO: upstream
@[simp]
theorem List.mem_attachWith_mem (l : List α) {P H}(x : α) h : ⟨x, h⟩ ∈ l.attachWith P H ↔ x ∈ l := by
  induction l <;> simp_all

theorem List.attachWith_nodup (l : List α) (hnd : l.Nodup) P H : (l.attachWith P H).Nodup := by
  induction l
  case nil => simp
  case cons x l ih =>
    simp only [attachWith_cons, nodup_cons, mem_attachWith_mem]; constructor
    · intros h; simp [h] at hnd
    · apply ih; simp_all

def BitVec.ofFn {w : Nat} (f : Fin w → Bool) : BitVec w :=
  BitVec.iunfoldr (fun i _ => ((), f i)) () |>.2

-- TODO: is there a way to only have one of these three lemmas?

theorem BitVec.ofFn_getLsbD_fin {w : Nat} {f : Fin w → Bool} {i : Fin w} :
    (BitVec.ofFn f).getLsbD i = f i := by
  rw [ofFn, BitVec.iunfoldr_getLsbD (fun _ => ())]
  simp

@[simp]
theorem BitVec.ofFn_getLsbD {w : Nat} {f : Fin w → Bool} {i : Nat} (hi : i < w) :
    (BitVec.ofFn f).getLsbD i = f ⟨i, hi⟩ := ofFn_getLsbD_fin (i := ⟨i, hi⟩)

theorem BitVec.ofFn_getLsbD_true {w : Nat} {f : Fin w → Bool} {i : Nat} :
    (BitVec.ofFn f).getLsbD i = true ↔ ∃ (hlt : i < w), f ⟨i, hlt⟩ = true := by
  constructor
  · intro h; have hlt := lt_of_getLsbD h; simp_all [-getLsbD_eq_getElem]
  · rintro ⟨hlt, heq⟩
    simp_all [-getLsbD_eq_getElem]

@[simp]
theorem BitVec.ofFn_getElem {w : Nat} (f : Fin w → Bool) {i : Nat} (hi : i < w) :
    (BitVec.ofFn f)[i] = f ⟨i, hi⟩ := by
  simp_all [←getLsbD_eq_getElem]

theorem BitVec.ofFn_getElem_fin {w : Nat} (f : Fin w → Bool) (i : Fin w) :
    (BitVec.ofFn f)[i.val] = f i := by
  simp
