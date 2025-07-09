/-
An implementation of IC3/PDR for model checking.
Based on [0]

[0] Efficient Implementation of Property Directed Reachability
    https://people.eecs.berkeley.edu/~alanmi/publications/2011/fmcad11_pdr.pdf
-/
import SSA.Experimental.Bits.Fast.Circuit
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Vars

namespace PDR
open Lean

section Datastructures

variable {arity : Type} [DecidableEq α] [Hashable α] (fsm : FSM arity)

structure Literal where
  var : (Vars fsm.α arity 1)
  neg : Bool

structure Cube where
  lits : Array (Literal fsm)



inductive FrameIx
| ofNat (f : Nat)  -- frame that holds for path length f.
| null -- empty frame, holds for no path length.
| infinity -- real invariant, holds for all path lengths.
deriving DecidableEq, Hashable

instance : OfNat FrameIx n where
  ofNat := .ofNat n

namespace FrameIx

def next : FrameIx → FrameIx
| .ofNat f => .ofNat (f + 1)
| .null => .null
| .infinity => .infinity

def compare : FrameIx → FrameIx → Ordering
| .null, .null => .eq
| .null, _ => .lt -- everything is smaller than null.
| _, .null => .gt -- everything is bigger than null.
| .infinity, .infinity => .eq
| _, .infinity => .lt -- everything is smaller than infinity.
| .infinity, _ => .gt -- infinity is greater than everything.
| .ofNat f, .ofNat g => Ord.compare f g

instance : Ord FrameIx where
  compare := FrameIx.compare

instance : LT FrameIx := ltOfOrd 

end FrameIx

structure TCube extends Cube fsm where
  frame : FrameIx


structure Frames where
  F : Array (Array (TCube fsm)) -- cubes for each frame.
  hf : 1 < F.size  -- at least one frame exists. The last frame is the f∞ frame.

structure PDRState where
  F : Frames fsm

end Datastructures

namespace TCube

def isNull (cube : TCube fsm) : Bool :=
  match cube.frame with
  | .null => true
  | _ => false

def next (cube : TCube fsm) : TCube fsm where
  frame := cube.frame.next
  lits := cube.lits

def compare (c1 c2 : TCube fsm) : Ordering :=
  FrameIx.compare c1.frame c2.frame

end TCube

namespace Frames

/-
Invraiant: F[-1] = F∞. F[0] = F_0.
-/
def newFrame (frames : Frames fsm) : Frames fsm :=
  let F := frames.F.push #[] -- add a new empty frame for F_0
  let F := frames.F.push #[] -- add a new empty frame F_∞
  let F := frames.F.swap (frames.F.size - 1) (frames.F.size - 2)
    (by have := frames.hf; omega)
    (by have := frames.hf; omega)
  { F := F, hf := by simp [F, hf] }

def depth (frames : Frames fsm) : Nat :=
  frames.F.size - 2

end Frames

abbrev SolverM (fsm : FSM arity) := StateT (PDRState fsm) MetaM

def SAT.getBadCube : SolverM fsm (Option (Cube fsm)) :=
  sorry

def SAT.isBlocked (c : TCube fsm) : SolverM fsm Bool :=
  sorry

def SAT.isInitial (c : Cube fsm) : SolverM fsm Bool :=
  sorry


inductive ModelExtractKind
| extractModel
| noExtractModel

inductive QueryKind
| indQuery
| noIndQuery

def SAT.solveRelative (c : TCube fsm)
    (mk : ModelExtractKind)
    (qk : QueryKind) : SolverM fsm (TCube fsm) :=
  sorry


def depth : SolverM fsm Nat := do
  let s ← get
  return s.F.depth

def newFrame : SolverM fsm Unit := do
  modify fun s => { s with F := s.F.newFrame }

def assert (b : Bool) (msg : MessageData) : SolverM fsm Unit := do
  if !b then
    throwError "Assertion failed: {msg}"

def addBlockedCube (c : TCube fsm) : SolverM fsm Unit := sorry


def generalize (s0 : TCube fsm) : SolverM fsm (TCube fsm) := sorry

inductive RecBlockedCubeResult
| blocked
| failedToBlock
deriving DecidableEq, Hashable


def condAssign (dest : TCube fsm) (src : TCube fsm) : SolverM fsm (TCube fsm) := 
    if src.frame ≠ .null then
      return src
    else
      return dest

-- Figure 6
def recBlockedCube (s0 : TCube fsm) : SolverM fsm RecBlockedCubeResult := do
  let mut Q : Std.TreeSet (TCube fsm) TCube.compare := ∅
  Q := Q.insert s0
  while hq : !Q.isEmpty do
    let s := Q.min (by simpa using hq)
    Q := Q.erase s

    if hframe : s.frame = 0 then
      -- failed to block the cube, it is an initial cube.
      return .failedToBlock
    else
      let isBlocked ← SAT.isBlocked s
      if hblocked : !isBlocked then do
        assert (! (← SAT.isInitial s.toCube)) m!"cube was unable to be blocked, and cube turned out to be initial."
        let z ← SAT.solveRelative s .extractModel .indQuery
        if z.frame ≠ FrameIx.null then
          -- cube 's' was blocked by image of predecessor.
          let mut z ← generalize z
          -- | TODO: this condition is slightly different from the paper, so be careful.
          while z.frame < FrameIx.ofNat ((← depth) - 1) do
              let z' ← SAT.solveRelative z.next .extractModel .indQuery
              if z'.frame = FrameIx.null then -- condAssign.
                break
              else
                z := z'
          addBlockedCube z
          -- TODO: think
          if s.frame < FrameIx.ofNat (← depth) && z.frame ≠ .infinity then
            Q := Q.insert s.next
        else
          sorry
      else
       sorry

  return .blocked

def isBlocked (s : TCube fsm) : SolverM fsm Bool := sorry

inductive PropagationResult
| propagatedAll
| blocked
deriving DecidableEq, Hashable

def propagateBlockedCubes : SolverM fsm PropagationResult := sorry


-- Figure 5
def mainLoop : SolverM fsm Bool := do
  let c? ← SAT.getBadCube
  if let .some c := c? then
    if .failedToBlock = (← recBlockedCube (TCube.mk c (FrameIx.ofNat (← depth)))) then
      -- failed to block 'c', so counter-example has been found.
      return false -- failed to block the cube.
    return false
  else do
    newFrame
    if let .propagatedAll ← propagateBlockedCubes then
      return true -- found invariant.
    return false


def main : SolverM fsm Bool := mainLoop

end PDR

