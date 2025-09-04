import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim

namespace CIRCTStream

/-!
  The code below goes in the direction of having `bv_automata` deciding properties
  about both synced streams (e.g. the ones in comb) and non-synced ones.
-/

def syncPrim1 (s : Stream α) : Stream α := s


-- σ is the state spaces
def syncMapAccum₂ (init : σ) (f : α → β → σ → γ × σ) (xs : Stream α) (ys : Stream β) : Stream γ :=
  Stream.corec (⟨xs, ys, init⟩ : _ × _ × _) fun ⟨xs, ys, s⟩ =>
    match xs 0, ys 0 with
    | some x, some y =>
      let ⟨z, s'⟩ := f x y s
      ⟨some z, xs.tail, ys.tail, s'⟩
    | _, _ =>
      let xs := if (xs 0).isNone then xs.tail else xs
      let ys := if (ys 0).isNone then ys.tail else ys
      ⟨none, xs, ys, s⟩

/-- recover the stateless function by setting σ to unit -/
def syncMap₂ (f : α → β → γ) (xs : Stream α) (ys : Stream β) : Stream γ :=
  Stream.corec (xs, ys) fun ⟨xs, ys ⟩ =>
    match xs 0, ys 0 with
    | some x, some y => ⟨some <| f x y, xs.tail, ys.tail⟩
    | _, _ =>
      let xs := if (xs 0).isNone then xs.tail else xs
      let ys := if (ys 0).isNone then ys.tail else ys
      ⟨none, xs, ys⟩

/-- f is bv-decidable and only operates on bitvecs (potentially), it is lifted to work on streams. -/
def syncMap₃ (f : α → β → γ → δ) (xs : Stream α) (ys : Stream β) (zs : Stream γ): Stream δ :=
  Stream.corec (xs, ys, zs) fun ⟨xs, ys, zs⟩ =>
    match xs 0, ys 0, zs 0 with
    | some x, some y, some z => ⟨some <| f x y z, xs.tail, ys.tail, zs.tail⟩
    | _, _, _ =>
      let xs := if (xs 0).isNone then xs.tail else xs
      let ys := if (ys 0).isNone then ys.tail else ys
      let zs := if (zs 0).isNone then zs.tail else zs
      ⟨none, xs, ys, zs⟩


section SyncLemmas
open Stream.Bisim

theorem syncMap₂_eq_syncMap₂ {f : α → β → γ}
    (hxs : xs ~ xs') (hys : ys ~ ys') :
    syncMap₂ f xs ys ~ syncMap₂ f xs' ys' := by
  -- apply corec_eq_corec_of
  sorry


theorem syncMap2_flip {f : α → β → γ} :
  syncMap₂ f xs ys = syncMap₂ (fun y x => f x y) ys xs := by  sorry

theorem syncMap3_flip23 {f : α → β → γ → δ} :
  syncMap₃ f xs ys zs = syncMap₃ (fun x z y => f x y z) xs zs ys := by  sorry


theorem syncMap₃_eq_syncMap₃
    (hxs : xs ~ xs') (hys : ys ~ ys') (hzs : zs ~ zs') :
    syncMap₃ f xs ys zs ~ syncMap₃ f xs' ys' zs' := by
  -- apply corec_eq_corec_of
  sorry

@[simp]
theorem syncMap2_syncMap2_eq_syncMap3 (f : α → β → γ) (g : γ → ε → φ)
    (as : Stream α) (bs : Stream β) (es : Stream ε) :
    syncMap₂ g (syncMap₂ f as bs) es = syncMap₃ (fun a b e => g (f a b) e) as bs es := by
  -- I believe this is equal, but it might only be bisim (~)
  sorry

-- theorem syncMap₃_eq_syncMap₃_iff {f g : α → β → γ}
--     (h : ∀ a b c, f a b c = g a b c) :
--     syncMap₂ f xs ys = syncMap₂ g xs ys := by
--   sorry

end SyncLemmas


namespace Examples

def add₂ : Stream (BitVec w) → Stream (BitVec w) → Stream (BitVec w) :=
  syncMap₂ (· + ·)

def add₃ : Stream (BitVec w) → Stream (BitVec w) → Stream (BitVec w) → Stream (BitVec w) :=
  syncMap₃ (· + · + ·)


example (xs ys zs : Stream (BitVec 8)) : add₂ (add₂ xs ys) zs = add₃ xs ys zs := by
  simp [add₂, add₃]

/-- this is the shape of the decproc for comb parts -/
example (xs ys zs : Stream (BitVec 8)) : add₂ (add₂ xs zs) ys = add₃ xs ys zs := by
  simp only [add₂, add₃]
  simp only [syncMap2_syncMap2_eq_syncMap3]
  rw [syncMap3_flip23]
  congr
  funext a b c
  bv_decide

/-!
  For streams that are not synced, the above will do the above as a preprocessing anyways,
  creating rather large areas of comb regions connected by DC operations.
  To decide properties that can't be synced there are multiple decproc we can write:
  1. blackbox all synced stuff (values), just check the presence of things (just separates
    data from control)
  2. more complex decproc: there are multiple comb nodes, I create an automaton for each comb part
    and the circuit will be the result of combining these automata.
-/


-- example (xs ys zs : Stream (BitVec 8)) : add₂ (add₂ xs zs) ys ~ add₃ xs ys zs := by sorry

open Stream.Bisim







-- example (xs ys zs : Stream (BitVec 8)) : add₂ (add₂ xs zs) ys ~ add₃ xs ys zs := by
--   simp [add₂, add₃]
--   rw [syncMap₃_eq_syncMap₃ xs.removeNone_equiv _ _]
--   funext i


end Examples
