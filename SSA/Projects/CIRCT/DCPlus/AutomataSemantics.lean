import SSA.Projects.CIRCT.Stream.Stream
import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Core.Framework
import SSA.Core.Framework.Macro
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL2
import SSA.Core.Tactic.SimpSet
import Blase

namespace CIRCTStream
namespace DCPlusOp

def ValueStream := Stream

def TokenStream := Stream Unit

def VariadicValueStream (w : Nat) := CIRCTStream.Stream (List (BitVec w))

/-!
-- arity = # input_bits, given by a type that has as many values as the bit-width we want
structure FSM (arity : Type) : Type 1 where
  /--
  The arity of the (finite) type `α` determines how many bits the internal carry state of this
  FSM has -/
  ( α  : Type ) -- type of the internal state, given by a type that has as many values as the bit-width we want
  [ i : FinEnum α ]
  [ h : Hashable α ]
  [ dec_eq : DecidableEq α ]
  /--
  `initCarry` is the value of the initial internal carry state.
  It maps each `α` to a bit, thus it is morally a bitvector where the width is the arity of `α`
  represents initial state, given by a type that has as many values as the bit-width we want
  -/
  ( initCarry : α → Bool )
  /--
  `nextBitCirc` is a family of Boolean circuits,
  which may refer to the current input bits *and* the current state bits
  as free variables in the circuit.

  `nextBitCirc none` computes the current output bit as a function of the state and inputs.
  `nextBitCirc (some a)`, computes the *one* bit of the new state that corresponds to `a : α`. -/
  outputCirc : Circuit (α ⊕ arity) -- circuit, which always computes a single boolean value: receives as input `α ⊕ arity` (wires labeled by `α` and by `arity`)
  nextStateCirc : α → Circuit (α ⊕ arity) -- collection of circuits, for every bit in the state (`nextState`) gives us a circuit on how to compute `nextState` from the current state (given by `α`) and current input (given by `arity`)

-- α is the input to the circuit, given by a type that has as many values as the bit-width we want
inductive Circuit (α : Type u) : Type u
  | tru : Circuit α -- circuit that always outputs true
  | fals : Circuit α -- circuit that always outputs false
  /-- `var b x` represents literal `x` if `b = true` or the negated literat `¬x` if `b = false` -/
  | var : (positive: Bool) → α → Circuit α -- circuit that always outputs the value of an input (possibly negated)
  | and : Circuit α → Circuit α → Circuit α  -- circuit that outputs `and` between the outputs of two circuits
  | or : Circuit α → Circuit α → Circuit α -- circuit that outputs `or` between the outputs of two circuits
  | xor : Circuit α → Circuit α → Circuit α -- circuit that outputs `xor` between the outputs of two circuits
deriving Repr, DecidableEq

-/

/-!
def join (x y : TokenStream) : TokenStream  :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some (), (x.tail, y.tail))
    | some _, none => (none, (x, y.tail))
    | none, some _ => (none, (x.tail, y))
    | none, none => (none, (x.tail, y.tail))
-/

-- def join : FSM (Fin 4) := -- pick any type that has as many values as the length we want
--   { α := Unit,
--     initCarry := fun () => false,
--     nextStateCirc := fun () =>
--       -- Only if both are `0` we produce a `0`.
--       (Circuit.var true (.inr false)  |||
--       ((Circuit.var false (.inr true) |||
--       -- But if we have failed and have value `1`, then we produce a `1` from our state.
--       (Circuit.var true (.inl ())))))
--     outputCirc := -- must succeed in both arguments, so we are `0` if both are `0`.
--       Circuit.var true (.inr true) |||
--       Circuit.var true (.inr false)
--   }

-- def fsmFork : FSM (Unit × Unit) where
--   α := Unit
--   initCarry := fun () => false
--   outputCirc :=
--     let x : Circuit (Unit ⊕ Unit) := Circuit.var (.inr default)
--     Circuit.pair x x
--   nextStateCirc := fun () =>
--     let state : Circuit (Unit ⊕ Bool) := Circuit.var (positive := true) (.inr false)
--     state × state

-- def forkFSM [Encodable σ] [Default σ] : FSM (σ × σ) where
--   -- The state type. Since `fork` is stateless, we use `Unit`.
--   α := Unit

--   -- The initial state (or carry) is just `()`.
--   initCarry := fun () => ()

--   -- The circuit for the output.
--   outputCirc :=
--     -- Define a circuit variable `x` to represent the input from the stream.
--     -- The input to the circuit is `Unit ⊕ σ`, where `.inl` is the state
--     -- and `.inr` is the stream's value.
--     let x : Circuit (Unit ⊕ σ) := Circuit.var (.inr default)
--     -- The output is the pair (x, x).
--     Circuit.pair x x

--   -- The circuit for the next state.
--   nextStateCirc := fun _ =>
--     -- Since the FSM is stateless, the next state is always `()`.
--     Circuit.const ()


def fork (x : TokenStream) : TokenStream × TokenStream  :=
  Stream.corec₂ (β := TokenStream) x
    fun x => Id.run <| do
      (x 0, x 0, x.tail)

def forkVal (x : ValueStream (BitVec 1)) : ValueStream (BitVec 1) × ValueStream (BitVec 1)  :=
  Stream.corec₂ (β := ValueStream (BitVec 1)) x
    fun x => Id.run <| do
      (x 0, x 0, x.tail)

def join (x y : TokenStream) : TokenStream  :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some (), (x.tail, y.tail))
    | some _, none => (none, (x, y.tail))
    | none, some _ => (none, (x.tail, y))
    | none, none => (none, (x.tail, y.tail))

def merge (x y : TokenStream) : ValueStream (BitVec 1) :=
  Stream.corec (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some _, some _ => (some 1, (x.tail, y))
    | some _, none => (some 1, (x.tail, y.tail))
    | none, some _ => (some 0, (x.tail, y.tail))
    | none, none => (none, (x.tail, y.tail))

def mux (x y : TokenStream) (c : ValueStream (BitVec 1)): TokenStream :=
  Stream.corec (β := TokenStream × TokenStream × ValueStream (BitVec 1)) (x, y, c)
  fun ⟨x, y, c⟩ =>
    match (c 0) with
    | none => (none, x, y, c.tail) -- wait on 'c'.
    | some 1#1 =>
      match (x 0) with
      | none => (none, x.tail, y, c) -- have 'c', wait on 'x'.
      | some _ => (some (), x.tail, y, c.tail) -- consume 'c' and 'x'.
    | some 0#1 =>
      match (y 0) with
      | none => (none, x, y.tail, c) -- hace 'c', wait on 'y'.
      | some _ => (some (), x, y.tail, c.tail) -- consume 'c' and 'y'.

def cMerge (x y : TokenStream) : ValueStream (BitVec 1) × TokenStream :=
  Stream.corec₂ (β := TokenStream × TokenStream) (x, y) fun ⟨x, y⟩ =>
    match x 0, y 0 with
    | some x', some _ => (some 1, some x', (x.tail, y))
    | some x', none => (some 1, some x', (x.tail, y.tail))
    | none, some y' => (some 0, some y', (x.tail, y.tail))
    | none, none => (none, none, (x.tail, y.tail))

def branch (c : ValueStream (BitVec 1)) (x : TokenStream) : TokenStream × TokenStream  :=
  Stream.corec₂ (β := ValueStream (BitVec 1) × TokenStream) (c, x) fun ⟨c, x⟩ =>
    Id.run <| do
      match c 0 with
        | none => (none, none, (c.tail, x))
        | some x₀ =>
          if x₀.msb then
            (some (), none, (c.tail, x.tail))
          else
            (none, some (), (c.tail, x.tail))

def source : TokenStream :=
  Stream.corec () fun () => (some (), ())

def sink (x : TokenStream) : TokenStream :=
  Stream.corec (β := TokenStream) x fun x => (none, x.tail)

def supp (c : ValueStream (BitVec 1)) (x : TokenStream) : TokenStream := (branch c x).snd

def not (c : ValueStream (BitVec 1)) : (ValueStream (BitVec 1)) :=
  Stream.corec (β := ValueStream (BitVec 1)) c fun c =>
  match c 0 with
  | some 1 => (some 0, c.tail)
  | some 0 => (some 1, c.tail)
  | _ => (none, c.tail)

end DCPlusOp

end CIRCTStream
