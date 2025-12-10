import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas

/-! We model a register storing a value for one cycle -/

namespace HandshakeStream

/--
  We ignore the `clk` operand under the assumption that one clock cycle corresponds to one step
  in the `Stream`.
-/
def compReg (input : Stream α) (initialValue : α) : Stream α :=
  corec (β := Stream α × Option α × Option α)
    (input, none,  some initialValue) fun (input, store, init) =>
  match init with
  | some initVal  => (initVal, input.tail, input.head, none)
  | _ => (store, input.tail, input.head, none)
