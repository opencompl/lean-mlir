import SSA.Core.MLIRSyntax.GenericParser
import SSA.Projects.CIRCT.Handshake.Handshake
import SSA.Projects.CIRCT.Stream.Stream
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.PaperExamples.PaperExamples

namespace MLIR2Simple
/-!
## Examples
-/
open MLIR AST in
def lhs :=
  [simple_com| {
    ^bb0(%x : i32):
      %c0 = "const" () { value = 0 : i32 } : () -> i32
      %out = "add" (%x, %c0) : (i32, i32) -> i32
      "return" (%out) : (i32) -> (i32)
  }]
end MLIR2Simple

namespace MLIR2Handshake
open MLIR AST in
def branchEg₀ :=
  [handshake_com| {
    ^entry(%0 : i32):
      "return" (%0) : (i32) -> (i32)
  }]
-- def BranchEg1 : Com Handshake (Ctxt.ofList [(.stream .int), (.stream .int)]) .pure (.stream .int) :=
--   [simple_com| {
--     ^entry(%0: i32, %1: i32):
--       -- %out = "handshake.branch" (%0, %1) : (!Stream, !Stream) -> (!Stream2)
--       -- %outf = "handshake.fst" (%out) : (!Stream2) -> (!Stream)
--       -- %outs = "handshake.snd" (%out) : (!Stream2) -> (!Stream)
--       -- %out2 = "handshake.merge" (%outf, %outs) : (!Stream, !Stream) -> (!Stream)
--       "return" (%0) : (i32) -> ()
--   }]


-- #check BranchEg1
-- #eval BranchEg1
-- #reduce BranchEg1
-- #check BranchEg1.denote
-- #print axioms BranchEg1

-- def x := Stream.ofList [some true, none, some false, some true, some false]
-- def c := Stream.ofList [some true, some false, none, some true]

-- def test : Stream :=
--   BranchEg1.denote (Valuation.ofPair c x)

-- def remNone (lst : List Val) : List Val :=
--   lst.filter (fun | some x => true
--                   | none => false)

-- theorem equiv_arg1 (x1Stream x2Stream : Stream) : x1Stream ≈ BranchEg1.denote (Valuation.ofPair x1Stream x2Stream) := by
--   simp [BranchEg1, Valuation.ofPair, Valuation.ofHVector]
--   let v : Valuation [Ty.Stream, Ty.Stream] := Valuation.ofPair x1Stream x2Stream
--   simp_peephole at v
--   unfold Stream.branch
--   unfold Stream.merge


-- theorem determinate :
--   Set.Subsingleton (SSA.Projects.CIRCT.Stream.nondeterminify2 (fun s1 s2 => BranchEg1.denote (Valuation.ofPair s1 s2)) (s1', s2')) := by
--   intro x Hx y  Hy
--   simp [Stream.nondeterminify2, Stream.StreamWithoutNones.hasStream] at *
--   rcases Hx with ⟨ x1Stream, x1, x2Stream, x2, rfl ⟩
--   rcases Hy with ⟨ y1Stream, y1, y2Stream, y2, rfl ⟩
--   apply Quotient.sound
--   -- simp [BranchEg1]
--   -- simp [Stream.Bisim, Stream.IsBisim]
--   subst s2'; subst s1'
--   have y1' := Quotient.exact y1
--   have y2' := Quotient.exact y2
--   clear y1; clear y2
--   trans x1Stream
--   apply (equiv_arg1 _ _).symm
--   trans y1Stream
--   · assumption
--   · apply equiv_arg1
