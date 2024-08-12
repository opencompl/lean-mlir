import Mathlib.Data.Stream.Defs
import Batteries.Data.List.Basic

namespace DC

/-!

# Preliminaries for DC Semantics

In `DC`, components are connected together via FIFO (first-in, first-out) channels.
We model this as the `DC.Stream` type

-/

<<<<<<< HEAD
abbrev Message := Bool

def Val := Option Message
=======
def Val := Option Bool
>>>>>>> main

/-- A `Stream` in `DC` is an infinite sequence of messages (i.e., *potential* values).
Note that semantics of `DC` are deterministic -/
def Stream := Stream' Val

namespace Stream

def corec {β} (s0 : β) (f : β → (Val × β)) : Stream :=
  Stream'.corec (f · |>.fst) (f · |>.snd) s0

def corec₂ {β} (s0 : β) (f : β → (Val × Val × β)) : Stream × Stream :=
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
def head : Stream → Val := Stream'.head

/-- Drop the first element of a stream -/
def tail : Stream → Stream := Stream'.tail

/-- Expand a finite list of values into a stream, by appending an infinte amount of `none`s -/
def ofList (vals : List Val) : Stream :=
  fun i => (vals.get? i).join

/-- `toList n x` returns the first `n` messages (including `none`s) as a list -/
def toList (n : Nat) (x : Stream) : List Val :=
  List.ofFn (fun (i : Fin n) => x i)
