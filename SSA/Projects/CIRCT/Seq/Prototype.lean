import SSA.Projects.CIRCT.Stream.WeakBisim
import SSA.Projects.CIRCT.Stream.Stream

/-! We model a register storing a value for one cycle -/

namespace CIRCTStream

/--
  We ignore the `clk` operand under the assumption that one clock cycle corresponds to one step
  in the `Stream`.
-/
def compRegTok (input : Stream (BitVec 1)) (initialValue: BitVec 1) : Stream (BitVec 1) :=
  Stream.corec (β := Stream (BitVec 1) × Option (BitVec 1) × Option (BitVec 1))
    (input, none,  some initialValue) fun (input, store, init) =>
  match init with
  | some initVal  => (initVal, input.tail, input.head, none)
  | _ => (store, input.tail, input.head, none)


def compRegBv64 (input : Stream (BitVec 64)) (initialValue: BitVec 64) : Stream (BitVec 64) :=
  Stream.corec (β := Stream (BitVec 64) × Option (BitVec 64) × Option (BitVec 64))
    (input, none,  some initialValue) fun (input, store, init) =>
  match init with
  | some initVal  => (initVal, input.tail, input.head, none)
  | _ => (store, input.tail, input.head, none)

def compRegBv (input : Stream (BitVec n)) (initialValue: BitVec n) : Stream (BitVec n) :=
  Stream.corec (β := Stream (BitVec n) × Option (BitVec n) × Option (BitVec n))
    (input, none,  some initialValue) fun (input, store, init) =>
  match init with
  | some initVal  => (initVal, input.tail, input.head, none)
  | _ => (store, input.tail, input.head, none)

def compReg (input : Stream α) (initialValue : α) : Stream α :=
  Stream.corec (β := Stream α × Option α × Option α)
    (input, none,  some initialValue) fun (input, store, init) =>
  match init with
  | some initVal  => (initVal, input.tail, input.head, none)
  | _ => (store, input.tail, input.head, none)
