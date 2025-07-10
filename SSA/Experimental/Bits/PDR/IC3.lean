/-
IC3 implementation, based on
'SAT-Based Model Checking without Unrolling'
-/
import SSA.Experimental.Bits.Fast.Circuit
import SSA.Experimental.Bits.Fast.FiniteStateMachine
import SSA.Experimental.Bits.Vars

namespace IC3
open Lean

section Datastructures

variable {arity : Type} (fsm : FSM arity) [DecidableEq arity] [Hashable arity]
  [DecidableEq fsm.α] [Hashable fsm.α] [BEq fsm.α]

structure Literal where
  var : (Vars fsm.α arity 1)
  neg : Bool
deriving DecidableEq, Hashable

structure Cube where
  lits : Std.HashSet (Literal fsm)
deriving Inhabited, BEq


inductive FrameIx
| ofNat (f : Nat)  -- frame that holds for path length f.
| null -- empty frame, holds for no path length.
| infinity -- real invariant, holds for all path lengths.
deriving DecidableEq, Hashable, Repr, Inhabited

instance : OfNat FrameIx n where
  ofNat := .ofNat n

namespace FrameIx

def next : FrameIx → FrameIx
| .ofNat f => .ofNat (f + 1)
| .null => .null
| .infinity => .infinity

def prev : FrameIx → FrameIx
| .ofNat f => .ofNat (f - 1)
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
deriving Inhabited, BEq

structure Frames where
  F : Array (Array (Cube fsm)) -- cubes for each frame.
  hf : 1 < F.size  -- at least one frame exists. The last frame is the f∞ frame.

structure IC3State where
  F : Frames fsm

end Datastructures

namespace Cube

variable {arity : Type} {fsm : FSM arity} [DecidableEq arity] [Hashable arity]
  [DecidableEq fsm.α] [Hashable fsm.α] [BEq fsm.α]

-- larger.subsumes smaller checks for syntactic subsumption of literals.
def subsumes (larger smaller : Cube fsm) : Bool :=
  -- ∀ l ∈ small, l ∈ large.
  smaller.lits.all (larger.lits.contains)

end Cube

namespace TCube

variable {arity : Type} {fsm : FSM arity} [DecidableEq arity] [Hashable arity]
  [DecidableEq fsm.α] [Hashable fsm.α] [BEq fsm.α]

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

variable {arity : Type} {fsm : FSM arity} [DecidableEq arity] [Hashable arity]
  [DecidableEq fsm.α] [Hashable fsm.α] [BEq fsm.α]

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

def size (frames : Frames fsm) : Nat := frames.F.size

instance : ForM m (Frames fsm) (Array (Cube fsm)) where
  forM frame f := frame.F.forM f

-- instance : GetElem (Array α) Nat α fun xs i => i < xs.size where
--   getElem xs i h := xs.getInternal i h


end Frames

section SolverM

variable {arity : Type} (fsm : FSM arity) [DecidableEq arity] [Hashable arity]
  [DecidableEq fsm.α] [Hashable fsm.α] [BEq fsm.α]

abbrev SolverM := StateT (IC3State fsm) MetaM

end SolverM

section Algorithm

variable {arity : Type} {fsm : FSM arity} [DecidableEq arity] [Hashable arity]
  [DecidableEq fsm.α] [Hashable fsm.α] [BEq fsm.α]


def SAT.getBadCube : SolverM fsm (Option (Cube fsm)) :=
  sorry

/--
Forcibly convert a frame index to a natural number.
This throws an error if the frame is null or infinity.
-/
def frameToNat! (f : FrameIx) : SolverM fsm Nat :=
  match f with
  | .ofNat n => return n
  | .null => throwError m!"expected a frame index, but got {repr f}"
  | .infinity => throwError m!"expected a frame index, but got {repr f}"

/--
Convert a frame index to a natural number, but if the frame is infinity,
return the given `dInfty` value.
This throws an error if the frame is null.
-/
def frameToNatInfinityD (f : FrameIx) (dInfty : Nat) : SolverM fsm Nat :=
  match f with
  | .ofNat n => return n
  | .null => throwError m!"expected a frame index, but got {repr f}"
  | .infinity => return dInfty

-- | Claim: This is not even necessary. But we should check if frame s.frame
-- blocks the cube s, so the query is something like `TAUTO (F[s.frame] => not(s))`.
-- Note: the paper has no explanation of what this query is.
def SAT.isBlocked (_s : TCube fsm) : SolverM fsm Bool := do
  return false

-- | TODO: we assume that the frame index is not null and not infinity.
def isBlockedFast (s : TCube fsm) : SolverM fsm Bool := do
  -- first check for syntactic subsumption
  let F := (← get).F
  for hd : d in [← frameToNat! s.frame:F.F.size] do
    for hi : i in [0:F.F[d].size] do
      if  F.F[d][i].subsumes s.toCube then
        return true -- cube 's' is subsumed by F[d][i], so it is blocked.
  -- syntactic subsumption failed, let's do slow semantic subsumption.
  SAT.isBlocked s

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

/--
when treating an array as a set, we can erase an element at an index by
swapping it with the last element, and then popping the last element.
This guarantees that no other elements that come later in the iteration
order are changed.
-/
private def ArraySetEraseAt [Inhabited α] (xs : Array α) (i : Nat) (hi : i < xs.size := by omega) : Array α := Id.run do
  let w := xs[xs.size - 1]
  let xs := xs.set i w
  xs.pop

/--
In incremental solving, this reports to the solver that the cube `s.cube`
has been blocked in `s.frame`.
However, since we do not have an incremental solver, this is a noop.
-/
def SAT.blockCubeInSolver (_s : TCube fsm) : SolverM fsm Unit := return ()

def addBlockedCube (s : TCube fsm) : SolverM fsm Unit := do
  -- TODO: this is divined from their implementation, but the computation is a bit sus
  -- to coerce frame as unit.
  let mut F := (← get).F.F
  let k ← frameToNatInfinityD s.frame ((← depth) + 1)
  for hd : d in [1:k+1] do
    -- go up to frame infty, since we do 'depth + 1'.
    let mut Fd := F[d]!
    let mut i := 0
    while hi : i < Fd.size do
      if s.subsumes Fd[i] then
        Fd := ArraySetEraseAt Fd i
      else
        i := i + 1
    F := F.set! d Fd

  -- | TODO: F stores cubes, not timed cubes.
  F := F.set! k (F[k]!.push s.toCube)
  SAT.blockCubeInSolver s


/-- If the cube is not a null-cube, then return 'new', otherwise return 'old' -/
def condAssign (old : TCube fsm) (new : TCube fsm) : SolverM fsm (TCube fsm) :=
    if new.frame ≠ .null then
      return new
    else
      return old


def generalize (s0 : TCube fsm) : SolverM fsm (TCube fsm) := do
  -- | TODO: will Lean compile this correctly? 's' is 'mut', and the loop is looping over 's.lits'.
  let mut s := s0
  for l in s.lits do
    let sl := { s with lits := s.lits.erase l }
    if ! (← SAT.isInitial sl.toCube) then
      -- if the cube is not initial, then we can generalize it.
      -- | TODO: I really think that 'solveRelative' can return 'Option<cube>', and then
      -- we can delete the 'null' frame.
      let sgen ← SAT.solveRelative sl .extractModel .indQuery
      s ← condAssign s sgen
  return s


inductive RecBlockedCubeResult
| successfullyBlocked
| failedToBlock
deriving DecidableEq, Hashable


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
      let isBlocked ← isBlockedFast s
      if hblocked : !isBlocked then do
        assert (! (← SAT.isInitial s.toCube)) m!"cube was unable to be blocked, and cube turned out to be initial."
        let mut z ← SAT.solveRelative s .extractModel .indQuery

        -- | TODO: why can't frame be infty here?
        if z.frame ≠ FrameIx.null then
          -- cube 's' was blocked by image of predecessor.
          z ← generalize z
          -- | TODO: this condition is slightly different from the paper, so be careful.
          while z.frame < FrameIx.ofNat ((← depth) - 1) do
              let z' ← SAT.solveRelative z.next .extractModel .indQuery
              if z'.frame = FrameIx.null then -- condAssign.
                break
              else
                z := z'
          addBlockedCube z
          -- | Claim: this is not necessary, but improves the performance on
          -- UNSAT instances, and allows the solver to find counterexamples
          -- longer than the length of the trace. TODO: Think why!
          if s.frame < FrameIx.ofNat (← depth) && z.frame ≠ .infinity then
            Q := Q.insert s.next
        else
          -- not blocked.
          z := { z with frame := s.frame.prev}
          Q := Q.insert z
          Q := Q.insert s

  return .successfullyBlocked


inductive PropagationResult
| propagatedAll
| blocked
deriving DecidableEq, Hashable

def propagateBlockedCubes : SolverM fsm PropagationResult := sorry

/-- Formula for initial state. -/
def s0 : SolverM fsm (Circuit (Vars fsm.α arity 1)) := do
  sorry

/-- Formula for the transition relation. -/
def T : SolverM fsm (Circuit (Vars fsm.α arity 2)) := do
  sorry

/-- Formula for the safety of the given states. -/
def P : SolverM fsm (Circuit (Vars fsm.α arity 1)) := do
  sorry

/-- Prime a formula. -/
def prime (f : Circuit (Vars fsm.α arity n)) (δ : Nat) : Circuit (Vars fsm.α arity (n + δ)) :=
  sorry

def cast (f : Circuit (Vars fsm.α arity n)) (m : Nat) (hnm : n ≤ m := by omega) :
    Circuit (Vars fsm.α arity m) :=
  sorry

inductive SATResult {σ : Type} (c : Circuit σ) where
| model (model : σ)
| unsatProof (proof : String) -- LRAT certificate.
deriving DecidableEq, Hashable


def SATResult.counterexample {σ : Type} {c : Circuit σ} (model : σ) : SATResult c :=
  .model model

def SAT.checkSAT (c : Circuit σ) : SolverM fsm (SATResult c) :=
  sorry

inductive ProveResult
| badPath (k : Nat)
| goodIvariant

def F (k : Nat) : SolverM fsm (Circuit (Vars fsm.α arity k)) := do
  sorry

def strengthen (k : Nat) : SolverM fsm Bool := do
   -- (1) A.1−4
   -- (2) ∀c∈clauses(Fk+1),Fk∧T⇒c (3) ∀ i>k+1, |clauses(Fi)|=0 }
   while true do
     let Fk ← F k
     if let .counterexample x ← SAT.checkSAT ((cast Fk (k + 1))  &&& (← T) &&& ~~~ prime (← P) 1) then
       -- we have a counterexample, so we can strengthen the invariant.
       let s0 := (← s0)
       let s1 := cast s0
       let s2 := prime s1
       let c := x
   return false


-- Figure 1
def prove : SolverM fsm ProveResult := do
  if let .counterexample x ← SAT.checkSAT ((← s0) &&& ~~~ (← P)) then
    return .badPath 0
  if let .counterexample x ← SAT.checkSAT ((cast (← s0) 2) &&& (← T) &&& ~~~ (prime (← P) 1)) then
    return .badPath 1
  let mut k := 1
  while true do
    -- (1) ∀i≥0, I → Fi
    -- (2) ∀i≥0, Fi → P
    -- (3) ∀ i > 0, clauses(Fi+1) ⊆ clauses(Fi) ′
    -- (4) ∀0≤i<k,Fi∧T⇒Fi+1
    -- (5) ∀i>k, |clauses(Fi)|=0 }
    sorry
  return .goodIvariant

  -- let c? ← SAT.getBadCube
  -- if let .some c := c? then
  --   if .failedToBlock = (← recBlockedCube (TCube.mk c (FrameIx.ofNat (← depth)))) then
  --     -- failed to block 'c', so counter-example has been found.
  --     return false -- failed to block the cube.
  --   return false
  -- else do
  --   newFrame
  --   if let .propagatedAll ← propagateBlockedCubes then
  --     return true -- found invariant.
  --   return false


def main : SolverM fsm ProveResult := prove
end Algorithm

end IC3


