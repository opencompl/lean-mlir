import Mathlib.Data.QPF.Univariate.Basic

/-!
## Extensions to QPF theory

TODO: upstream this eventually?
-/

namespace QPF
open Functor

class UniformQPF (F : Type u → Type u) [QPF F] where
  isUniform : IsUniform (F := F)

variable [QPF G] [UniformQPF G]

noncomputable def attachSupp (x : G α) : G { y // y ∈ Functor.supp x } :=
  have hx : Liftp (· ∈ supp x) x := by
    rw [← QPF.abs_repr x, QPF.liftp_iff]
    rcases QPF.repr x with ⟨a, f⟩
    use a, f
    simp [QPF.supp_eq_of_isUniform UniformQPF.isUniform]
  hx.choose

end QPF
export QPF (UniformQPF)

/-! ## Instances for builtin types -/
section Instances

instance : QPF Id where
  P := ⟨Unit, fun _ => Unit⟩
  abs x := x.2 ()
  repr x := ⟨(), fun _ => x⟩
  abs_repr := by simp
  abs_map := by intros; rfl

instance : UniformQPF Id where
  isUniform := by
    intro _ () () f f' (h : f _ = f' _)
    ext a
    have (P : (QPF.P Id).B () → Prop) : (∃ u, P u) ↔ P () :=
      ⟨fun ⟨(), h⟩ => h, fun h => ⟨_, h⟩⟩
    simp [this, h]




-- TODO: upstream to Mathlib
namespace Functor
variable {F} [Functor F] [LawfulFunctor F] {x : F α}

-- Liftp

@[simp] theorem Liftp_true : Liftp (fun _ => True) x := by
  use (Subtype.mk · True.intro) <$> x
  simp

theorem Liftp_map : Liftp (fun x => P (f x)) x → Liftp P (f <$> x) := by
  unfold Liftp
  rintro ⟨u, h_u⟩
  use (fun ⟨y, h_y⟩ => ⟨f y, h_y⟩) <$> u
  simp [← h_u]

variable {m} [Monad m] [LawfulMonad m]

theorem Liftp_bind {mx : m α}
    (hx : Liftp P mx)
    (hf : ∀ x, P x → Liftp Q (f x)) :
    Liftp Q (mx >>= f) := by
  rcases hx with ⟨u, rfl⟩
  use (do
    let ⟨u, hu⟩ ← u
    (hf u hu).choose
  )
  simp only [map_bind, bind_map_left]
  congr
  funext ⟨x, hx⟩
  exact Exists.choose_spec (hf x hx)

variable [QPF m] (h : QPF.IsUniform (F := m)) in
@[simp] lemma supp_pure (x : α) : supp (pure x : m _) = { x } := by
  stop
  ext x'
  simp only [supp, Liftp, forall_exists_index, Set.mem_setOf_eq, Set.mem_singleton_iff]
  constructor
  · intro h
    apply h (pure (⟨x, rfl⟩ : { x' // x' = x }))
    -- rw [map_pure]
    sorry
  · rintro rfl P mx h

    rw [QPF.supp_eq]

    by_contra hP


    have : Subtype.val (p:=P) = fun x => x.val :=
      rfl

    sorry


@[simp] lemma supp_pure' (x : α) : supp (pure x : m _) = { x } := by
  ext x'
  simp only [supp, Liftp, forall_exists_index, Set.mem_setOf_eq, Set.mem_singleton_iff]
  constructor
  · intro h
    apply h (pure (⟨x, rfl⟩ : { x' // x' = x }))
    simp
  · rintro rfl P mx h
    by_contra hP
    have : Subtype.val (p:=P) = fun x => x.val :=
      rfl

    sorry

end Functor
