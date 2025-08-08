import Mathlib.Data.List.AList

import SSA.Core.ErasedContext


/-!
## Mapping

This file defines the `Mapping` structure, which we use to incrementally build
a context homomorphism while matching a peephole rewrite.
-/

open Ctxt (Var)
variable {Ty : Type}

--TODO: rename `Mapping` to `PartialHom` and move to the `ErasedContext` file
/-- `Mapping Γ Δ` represents a partial homomorphism from context `Γ` to `Δ`.
It's used to incrementally build a total homorphism -/
abbrev Mapping (Γ Δ : Ctxt Ty) : Type :=
  @AList (Σ t, Var Γ t) (fun x => Var Δ x.1)
--^^^^^^ Morally this is `{t : _} → Γ.Var t → Option (Δ.Var t)`
--       We write it as an `AList` for performance reasons

open AList
section AListTheorems

/--
if (k, v) is in s.entries then k is in s.
-/
--TODO: upstream this to mathlib
theorem _root_.AList.mem_of_mem_entries {α : Type _} {β : α → Type _} {s : AList β}
    {k : α} {v : β k} :
    ⟨k, v⟩ ∈ s.entries → k ∈ s := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp only [Membership.mem, keys] at h ⊢
  clear nd
  induction h
  next    => apply List.Mem.head
  next ih => apply List.Mem.tail _ ih

/--
if k is in s, then there is v such that (k, v) is in s.entries.
-/
theorem _root_.AList.mem_entries_of_mem {α : Type _} {β : α → Type _} {s : AList β} {k : α} :
    k ∈ s → ∃ v, ⟨k, v⟩ ∈ s.entries := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp only [Membership.mem, keys, List.keys] at h ⊢
  clear nd;
  induction entries
  next    => contradiction
  next hd tl ih =>
    cases h
    next =>
      use hd.snd
      apply List.Mem.head
    next h =>
      rcases ih h with ⟨v, ih⟩
      exact ⟨v, .tail _ ih⟩

end AListTheorems

namespace Mapping

variable {Γ Δ : Ctxt Ty} [DecidableEq Ty]

variable [TyDenote Ty] [∀ t' : Ty, Inhabited ⟦t'⟧] in
/--
Map a valuation of context `Δ` along a partial map `m : Mapping Γ Δ` into
a valuation of context `Γ`. This returns the default value of `⟦t'⟧` for
any variable `Γ.Var t'` which is not mapped in `m`.
-/
def mapValuation (m : Mapping Γ Δ) (V : Δ.Valuation) : Γ.Valuation :=
  fun t' v' =>
    match m.lookup ⟨t', v'⟩ with
    | some mappedVar => V mappedVar
    | none => default

/-- Whether the mapping has an entry for every variable in the domain. -/
def IsTotal (m : Mapping Γ Δ) : Prop :=
  ∀ {t} v, ⟨t, v⟩ ∈ m

/--
Convert a known-total mapping into a context morphism.
-/
def toHom (m : Mapping Γ Δ) (h : m.IsTotal) : Γ.Hom Δ :=
  fun t v =>
    m.lookup ⟨t, v⟩ |>.get <| by
      simpa [AList.lookup_isSome] using h _
