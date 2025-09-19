import SSA.Core
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Tactic

namespace CIRCTStream
namespace Stream.Bisim

/-! We implement the rewrites from https://dl.acm.org/doi/pdf/10.1145/3676641.3715993 -/

namespace CIRCTStream

namespace Strean.Bisim

theorem corec₂_eq_val (x : Stream α):
  (corec₂ x fun x => Id.run (x 0, x 0, tail x)) = (corec₂ x fun x => Id.run (x 0, x 0, x.tail)) := by
  apply corec₂_eq_corec₂_of
  rotate_left 2
  · exact Eq.refl _
  · intro b₁ b₂ h
    simp [h]
  · intro b₁ b₂ h
    simp [h]

theorem corec₂_corec1 (s : Stream γ) (f : Stream γ -> Option α × Option β × Stream γ) :
  (corec₂ s f).1 = corec s (fun s' => let ⟨ a, _, b ⟩ := f s'; (a, b) ) := by rfl

theorem corec₂_corec2 (s : Stream γ) (f : Stream γ -> Option α × Option β × Stream γ) :
  (corec₂ s f).2 = corec s (fun s' => let ⟨ _, a, b ⟩ := f s'; (a, b) ) := by rfl


theorem rewrite_a_fst (stream_d : Stream α) (stream_c : Stream (BitVec 1)):
    (HandshakeOp.branch stream_d stream_c).fst =
    (HandshakeOp.supp (HandshakeOp.fork stream_d).fst  (HandshakeOp.not (HandshakeOp.fork stream_c).fst))
     := by
  simp only [HandshakeOp.branch, BitVec.ofNat_eq_ofNat, HandshakeOp.supp, HandshakeOp.fork,
    HandshakeOp.not]
  simp [corec₂_corec1]


  sorry

theorem rewrite_a_snd (stream_d : Stream α) (stream_c : Stream (BitVec 1)):
    (HandshakeOp.branch stream_d stream_c).snd =
    (HandshakeOp.supp (HandshakeOp.fork stream_d).fst (HandshakeOp.fork stream_c).fst)
     := by
  simp only [HandshakeOp.branch, BitVec.ofNat_eq_ofNat, HandshakeOp.supp, HandshakeOp.fork]
  sorry



theorem rewrite_n (stream_d : Stream α) :
    HandshakeOp.sink ((HandshakeOp.fork stream_d).fst) = HandshakeOp.sink stream_d := by
  simp [HandshakeOp.sink, HandshakeOp.fork]
  exact _root_.rfl
