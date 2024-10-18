/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import Std.Data.HashMap
import Aesop


/- Question:
why does `Decidable (s ∈ l)` require `LawfulBEq` if `l` is a list but `DecidableEq` if `l` is an array?
-/
-- Practical ways to relate Finsets and HashSets

theorem ofBool_1_iff_true : BitVec.ofBool b = 1#1 ↔ b := by
  cases b <;> simp

theorem ofBool_0_iff_false : BitVec.ofBool b = 0#1 ↔ ¬ b := by
  cases b <;> simp

theorem List.dropLast_nodup (l : List X) : l.Nodup → l.dropLast.Nodup := by
  have hsl := List.dropLast_sublist l
  apply List.Nodup.sublist; trivial

@[simp]
theorem Array.not_elem_back_pop (a : Array X) (x : X) : a.toList.Nodup → a.back? = some x → x ∉ a.pop := by sorry

/- Upstream? -/
theorem Array.back?_mem (a : Array X) (x : X) : a.back? = some x → x ∈ a := by sorry

theorem Array.not_elem_back_pop_list (a : Array X) (x : X) : a.toList.Nodup → a.back? = some x → x ∉ a.toList.dropLast := by sorry

theorem Array.back_mem (a : Array X) (x : X) : a.back? = some x → x ∈ a := by sorry

/- Upstream? -/
theorem Array.mem_of_mem_pop (a : Array α) (x : α) : x ∈ a.pop → x ∈ a := by sorry

theorem Array.mem_push (a : Array α) (x y : α) : x ∈ a.push y → x ∈ a ∨ x = y := by sorry

theorem Array.mem_pop_iff (a : Array α) (x : α) : x ∈ a ↔ x ∈ a.pop ∨ a.back? = some x := by sorry

theorem Std.HashMap.keys_nodup [BEq K] [Hashable K] (m : Std.HashMap K V) : m.keys.Nodup := by sorry

@[simp]
theorem Std.HashMap.mem_keys_iff_mem [BEq K] [Hashable K] (m : Std.HashMap K V) (k : K) : k ∈ m.keys ↔ k ∈ m := by sorry

@[aesop safe]
theorem Std.HashMap.mem_keys_insert_new [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] (m : Std.HashMap K V) (k : K) : k ∈ m.insert k v := by
  apply mem_insert.mpr; simp_all only [beq_self_eq_true, true_or]

@[aesop 80% unsafe]
theorem Std.HashMap.mem_keys_insert_old [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] (m : Std.HashMap K V) (k k' : K) : k ∈ m → k ∈ m.insert k' v := by
  intros _; apply mem_insert.mpr; simp_all only [beq_iff_eq, or_true]

@[aesop 50% unsafe]
theorem Std.HashMap.get?_none_not_mem [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] {m : Std.HashMap K V} {k : K} : m.get? k = none → k ∉ m := by
  sorry

@[aesop 50% unsafe]
theorem Std.HashMap.mem_of_get? [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] {m : Std.HashMap K V} {k : K} :
    m.get? k = some v → k ∈  m := by
  sorry

@[aesop 50% unsafe]
theorem Std.HashMap.insert_keys_perm_new [BEq K] [LawfulBEq K] [Hashable K] [LawfulHashable K] (m : Std.HashMap K V) (k : K) (v : V) :
  k ∉ m → (m.insert k v).keys.Perm (k :: m.keys) := by
  sorry

theorem List.mem_attachWith_mem (l : List α) {P H}(x : α) h : ⟨x, h⟩ ∈ l.attachWith P H → x ∈ l := by
  induction l
  case nil => simp
  case cons x l ih => simp only [attachWith_cons, mem_cons, Subtype.mk.injEq]; intros h; rcases h <;> simp_all

theorem List.attachWith_nodup (l : List α) (hnd : l.Nodup) P H : (l.attachWith P H).Nodup := by
  induction l
  case nil => simp
  case cons x l ih =>
    simp; constructor
    · intros h; simp only [nodup_cons] at hnd; rcases hnd; have := l.mem_attachWith_mem x _ h; contradiction
    · apply ih; simp_all
