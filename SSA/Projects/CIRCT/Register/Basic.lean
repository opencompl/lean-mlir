import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Handshake.Handshake

/-! We model a register storing a value for one cycle -/

namespace HandshakeStream

/--
  The sequential logics defining the behaviour of a register, assuming it operates on a stream
  of optional values `HandshakeStream.Stream`.
  We ignore the `clk` operand under the assumption that one clock cycle corresponds to one step
  in the `Stream`.
-/
def compReg (input : Stream α) (initialValue : α) : Stream α :=
  corec (β := Stream α × Option α × Option α)
    (input, none,  some initialValue) fun (input, store, init) =>
  match init with
  | some initVal  => (initVal, input.tail, input.head, none)
  | _ => (store, input.tail, input.head, none)


/--
  A register wrapper enabling the description of components with feedback loops.
  We expect the feedback loop to satisfy some laws that will be helpful in proofs.
  · `input` is the the stream of inputs
  · `init_regs` contains the initial values of inputs obtained from the feedback loop
  · `update_fun` is the function computing the output of the component, given all the inputs

  In this model, we are inspired by trace monoidal category theory, by which
  we model a feedback loop as a function with a-many inputs and x-many inputs,
  producing b-many outputs and x-many outputs that are re-fed as inputs to the function
  (inputs, inputs from feedback, outputs, outputs to be fed-back)
-/
def register_wrapper
    (inputs : Stream' (Vector α m))
    -- we set the `init_regs` to `none` after using the values for the first iteration
    (init_regs : Vector α nfeed)
    -- inputs- and outputs- that are feedback-looped are canceled
    (update_fun : (Vector α m × Vector α nfeed) → (Vector α r × Vector α nfeed))
      : Stream' (Vector α r) :=
  /-
    The state-space β is the product of the input stream (Stream' (Vector α m)),
    the values we store because they're part of the feedback loop (Vector α nfeed),
    the initial values for the very first iteration, where no values are stored (Option (Vector α nfeed))
  -/
  let β := Stream' (Vector α m) × (Vector α nfeed) × Option (Vector α nfeed)
  /-
    `f` computes the output
  -/
  let f : β → Vector α r :=
    fun (input_stream, current_regs_opt, init_regs) =>
      /-
        `init_regs` is different than none only at the very first iteration.
      -/
      match init_regs with
      | some iv =>
                  /-
                    We apply `update_fun` and only extract the output that is not fed back to the loop.
                    At the first iteration, we use the initial values `iv` as arguments for `update_fun`
                  -/
                  let (output, _) := update_fun (input_stream.head, iv)
                  output
      | _ =>  /-
                We apply `update_fun` and only extract the output that is not fed back to the loop.
                After the first iteration, we use the stored values `current_regs_opt` as arguments for `update_fun`
              -/
              let (output, _) := update_fun (input_stream.head, current_regs_opt)
              output
  /-
    `g` computes the next state
  -/
  let g : β → β :=
    fun (input_stream, current_regs_opt, init_regs) =>
/-
  At every iteration we update the state as follows:
  · `input_stream` is updated to `input_stream.tail`
  · `current_regs_opt` is updated to store the portion of the result of `update_fun` that is
                       used as input (fed-back) at the next cycle
  · `init_regs` remains `none`, as it is only different than `none` at the very first call
-/
    match init_regs with
    | some iv =>
                /-
                  We apply `update_fun` and use the output that is fed back to the loop in the next iteration.
                  At the first iteration, we use the initial value `iv` as input for `update_fun`
                -/
                let (_, output_feedback) := update_fun (input_stream.head, iv)
                (input_stream.tail, output_feedback, none)
    | _ =>  /-
              We apply `update_fun` and use the output that is fed back to the loop in the next iteration.
              After the first iteration, we use the stored value `current_regs_opt` as input for `update_fun`
            -/
            let (_, output_feedback) := update_fun (input_stream.head, current_regs_opt)
            (input_stream.tail, output_feedback, none)
  Stream'.corec f g (inputs, init_regs, none)

/--
  We define an isomorphism from a streams `a` to a stream of their product BitVec 1.
  With this isomorphism we map the single streams that define the inputs of the hardware module to
  a unique streams, where each element is composed by the single streams.
-/
def iso_unary (a : Stream' (BitVec 1)) : Stream' (Vector (BitVec 1) 1) :=
    fun n =>
      {toArray := [a n].toArray, size_toArray := by simp}

/-- Convert a `Stream'` to `Stream` -/
def iso_unary' (a : Stream' (BitVec 1)) : Stream (BitVec 1) :=
    fun i => a.get i

/--
  We define an isomorphism from two streams `a`, `b` to a stream of their product BitVec 1 × BitVec 1.
  With this isomorphism we map the single streams that define the inputs of the hardware module to
  a unique streams, where each element is composed by the single streams.
-/
def iso_binary (a b : Stream' (BitVec 1)) : Stream' (Vector (BitVec 1) 2) :=
    fun n =>
      {toArray := [a n, b n].toArray, size_toArray := by simp}

/--
  Map the `i`-th element of stream `s` in `xv` to the output vector, using `Stream'`.
-/
def streams_to_vec' {α : Type u} {n : Nat} (xv : Vector (Stream' α) n) : Stream' (Vector α n) :=
  /- `map` applies `fun (s : Stream' α) => s i` to every element in `xv` -/
  fun (i : Nat) => xv.map (fun (s : Stream' α) => s i)

/--
  Map each element at the `k`-th position of `xv` to the `k`-th stream of the output, using `Stream'`.
-/
def vec_to_streams' {α : Type u} {n : Nat} (xv : Stream' (Vector α n)) : Vector (Stream' α) n :=
  /- `.ofFn` creates a vector with `n` elements (for each `k` from `0` to `n - 1`),
      where each element is a stream `fun (i : Nat) => ...` containing the `k`-th element of the
      `i`-th element of stream `xv`.
  -/
  Vector.ofFn (fun (k : Fin n) => fun (i : Nat) => (xv i).get k)

/--
  Drop the first `n` elements of all the three streams in `x`.
-/
def drop_from_bitvecs (x : Vector (Stream' (BitVec 1)) 3) (n : Nat) : Vector (Stream' (BitVec 1)) 3 :=
  x.map (fun (s : Stream' (BitVec 1)) => s.drop n)

/--
  We define the relation between a vector `Vector (Stream' (BitVec 1)) 3` containing the
  data, ready and valid signals, and a `Stream (BitVec 1)` containing the same information
  at handshake level.
  `a[0]` contains the data, `a[1]` contains the `ready` signal, `a[2]` contains the `valid` signal.
  This relation is useful to prove the bisimilarity between streams at handshake and hardware levels.
-/
def ReadyValid  (a : Vector (Stream' (BitVec 1)) 3) (b : Stream (BitVec 1)) :=
  ∀ (n : Nat),
      ((a[1] n = 1#1) ∧ (a[2] n = 1#1) ∧ (some (a[0] n) = b.get n))
      ∨ ((a[1] n = 0#1) ∨ (a[2] n = 0#1) ∧ (none = b.get n))
