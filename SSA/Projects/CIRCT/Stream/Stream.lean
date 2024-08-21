import Mathlib.Data.Stream.Defs
import Batteries.Data.List.Basic

/-!

# Preliminaries for DC/Handshake Semantics

In `DC` and `Handshake`, components are connected together via FIFO (first-in, first-out) channels.
We model this as the `.Stream` type

-/
namespace CIRCTStream

/-- A `Stream` in is an infinite sequence of messages (i.e., *potential* values).
Note that semantics of `DC` and `Handshake` are deterministic -/
def Stream (β : Type) := Stream' (Option β)

namespace Stream

def corec {α} {β} (s0 : β) (f : β → (Option α × β)) : Stream α :=
  Stream'.corec (f · |>.fst) (f · |>.snd) s0

def corec₂ {β} (s0 : β) (f : β → (Option α × Option γ × β)) : Stream α × Stream γ :=
  let f' := fun b =>
    let x := f b
    (x.fst, x.snd.fst)
  let g := (f · |>.snd.snd)
  let x := Stream'.corec f' g s0
  (
    fun i => (x i).fst,
    fun i => (x i).snd,
  )

/-- Return the first element of a stream -/
def head : Stream α → Option α := Stream'.head

/-- Drop the first element of a stream -/
def tail : Stream α → Stream α := Stream'.tail

/-- Expand a finite list of values into a stream, by appending an infinte amount of `none`s -/
def ofList (vals : List α) : Stream α :=
  fun i => (vals.get? i).join

/-- `toList n x` returns the first `n` messages (including `none`s) as a list -/
def toList (n : Nat) (x : Stream α) : List (Option α) :=
  List.ofFn (fun (i : Fin n) => x i)
