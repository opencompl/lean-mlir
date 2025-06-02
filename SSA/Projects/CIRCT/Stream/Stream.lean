import Mathlib.Data.Stream.Defs
import Batteries.Data.List.Basic
import SSA.Core.HVector

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

def map {α β : Type} (s : Stream α) (f : α → β) : Stream β :=
  fun i => (s i).map f

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
  fun i => vals[i]?.join

/-- `toList n x` returns the first `n` messages (including `none`s) as a list -/
def toList (n : Nat) (x : Stream α) : List (Option α) :=
  List.ofFn (fun (i : Fin n) => x i)

/--
Returns the tail of a stream `x`, if the first element is a `none`.
Otherwise, returns `x` unchanged.

NOTE: this only removes the *first* `none`; the returned stream could still
have more leading `none`s.
-/
def dropFirstNone (x : Stream α) : Stream α :=
  if x.head.isNone then
    x.tail
  else
    x


/--
Transpose a vector of streams into a single stream of vectors, such that all
values (i.e., not-`none` entries of the stream) are preserved.

See also `transpose`, which is a bit more lenient about the shape of the input
vector, at the cost of needing an extra proof.
-/
def transpose' {A : α → Type} {as : List α}
    (xs : HVector (fun a => Stream (A a)) as) :
    Stream (HVector A as) :=
  corec xs fun xs =>
    let xs := xs.map fun _ x => x.dropFirstNone
    let out := xs.mapM fun _ x => x.head
    -- ^^ `out` is `none` if *any* of `x.head` is `none`.
    let xs :=
      if out.isSome
        then xs.map fun _ x => x.tail
        else xs

    (out, xs)

/--
Transpose a vector of streams into a single stream of vectors, such that all
values (i.e., not-`none` entries of the stream) are preserved.

See also `transpose'`, which does not require the extra proof.
-/
def transpose {A} {as : List α} (xs : HVector A as)
    {B : α → Type}
    (h : ∀ (i : Fin as.length), A as[i] = Stream (B as[i])) :
    Stream (HVector B as) :=
  transpose' <| xs.castFun h


  -- corec xs fun xs =>
  --   -- map the vector of streams (input) to streams where the first none have been removed
  --   -- e.g. f ~ popFirstNone
  --   -- then, we foldl over this new vector of streams (monadic map???? the side effect is returning a `none`)
  --   let xs' := xs.map fun a x =>
  --     let x : Stream (B a) := cast h x
  --     x.dropFirstNone

  --   let out := xs'.mapM' fun a x => x.head
  --   (cast (by congr; sorry) out,
  --    xs'.map fun a x => h ▸ x)
  --   -- use the state of the corec to remember what elements we know/have already and what not
  --   -- match as, xs with
  --   -- | [], _ => corec () fun _ => (none, ())
  --   -- | _::_, x ::ₕ xs => _
