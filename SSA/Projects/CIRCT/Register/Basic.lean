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
  To avoid using heterogeneous bitvectors without compromising on a faithful representation,
  we introduce an ad-hoc structure for the input and output of the circuit in case it contains both
  signals (`BitVec 1`) and data (`BitVec w`).
-/
structure wiresStruc (nops nsig w: Nat) where
  result : Vector (BitVec w) nops
  signals : Vector (BitVec 1) nsig

structure wiresStructStream (nops nsig w : Nat) where
  result : Vector (Stream' (BitVec w)) nops
  signals : Vector (Stream' (BitVec 1)) nsig

/-- We define a more general `register_wrapper` that operates on both streams of signals (`BitVec 1`)
  as well as streams of operands (`BitVec w`) -/
def register_wrapper_generalized
    (inputs : Stream' (wiresStruc inops insigs w))
    (init_regs : wiresStruc regops regsigs w)
    -- the generalized wrapper supports registers for both operands and signals
    (update_fun : (wiresStruc inops insigs w × wiresStruc regops regsigs w) →
                  (wiresStruc outops outsigs w × wiresStruc regops regsigs w))
      : Stream' (wiresStruc outops outsigs w) :=
  let β := Stream' (wiresStruc inops insigs w) × -- inputs
            wiresStruc regops regsigs w × -- feedback signals
            Option (wiresStruc regops regsigs w) -- registers' initial value
  let f : β → wiresStruc outops outsigs w :=
    fun (inputs, regs, init_regs) =>
      match init_regs with
      | some init => let ⟨out, _⟩ := update_fun (inputs.head, init)
                    out
      | none => let ⟨out, _⟩  := update_fun  (inputs.head, regs)
                out
  let g : β → β :=
    fun (inputs, regs, init_regs) =>
      match init_regs with
      | some init => let ⟨_, regs_out⟩ := update_fun (inputs.head, init)
                    ⟨inputs.tail, regs_out, none⟩
      | none =>  let ⟨_, regs_out⟩  := update_fun (inputs.head, regs)
              ⟨inputs.tail, regs_out, none⟩
  Stream'.corec f g  (inputs, init_regs, none)

/-- We define a weaker `register_wrapper` that operates with `Option` values. -/
def het_register_wrapper
    (inputs : Stream' (HVector f lin))
    (init_regs : HVector f ls)
    (update_fun : (HVector f lin × HVector f ls) →
                  (HVector f ls × HVector f lout))
      : Stream' (HVector f lout) :=
  let β := Stream' (HVector f lin) × -- inputs
            HVector f ls × -- feedback signals
            Bool -- first iteration flag
  let f : β → HVector f lout :=
    fun (inputs, regs, start) =>
      match start with
      | true => let ⟨_, lout'⟩ := update_fun (inputs.head, init_regs)
                lout'
      | false => let ⟨_, lout'⟩  := update_fun (inputs.head, regs)
                lout'
  let g : β → β :=
    fun (inputs, regs, start) =>
      match start with
      | true => let ⟨ls', _⟩ := update_fun (inputs.head, init_regs)
                ⟨inputs.tail, ls', false⟩
      | false =>  let ⟨ls', _⟩  := update_fun (inputs.head, regs)
                ⟨inputs.tail, ls', false⟩
  Stream'.corec f g  (inputs, init_regs, true)

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

-- /--
--   Map the `i`-th element of stream `s` in `xv` to the output heterogeneous vector, using `Stream'`.
-- -/
-- def streams'_to_hvec {α : Type u} {n : Nat} (xv : HVector f lin) : Stream' (HVector f lin) :=
--   /- `map` applies `fun (s : Stream' α) => s i` to every element in `xv` -/
--   fun (f, lin) => xv.map (fun (s : Stream' α) => s i)

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

/--
  We generalize the `ReadyValid` definition for a `wiresStruc`, to avoid implementing
  heterogeneous vectors.
  The `result` field of the structure will contain the data, while the two signals contain
  the `ready` and `valid` signal, respectively.
-/
def ReadyValidStruc (a : wiresStructStream 1 2 w) (b : Stream (BitVec w)) :=
  ∀ (n : Nat),
    ((a.signals[0] n = 1#1) ∧ (a.signals[1] n = 1#1) ∧ (some (a.result[0] n) = b.get n))
    ∨ ((a.signals[0] n = 0#1) ∨ (a.signals[1] n = 0#1) ∧ (none = b.get n))

/-- Map each element at the k-th position of each element of `Stream' (wiresStruc nops nsig)`
  to a stream of its own. -/
def wires_to_streams (ws : Stream' (wiresStruc nops nsig w)) : wiresStructStream nops nsig w :=
  { result := Vector.ofFn (fun k => fun i => (ws i).result.get k),
    signals := Vector.ofFn (fun k => fun i => (ws i).signals.get k) }

/-- Map each element in each stream of `ws` to an element in a `Stream' (wiresStruc nops nsig)` object. -/
def streams_to_wires {nops nsig : Nat} (ws : wiresStructStream nops nsig w) : Stream' (wiresStruc nops nsig w) :=
  fun (i : Nat) =>
    { result := ws.result.map (fun s => s i),
      signals := ws.signals.map (fun s => s i) }

/--
  Executes `f` until all the register values `reg` are defined.
  reg : initial set of registers
  f : function to find fp over, takes registers and returns register
  FP of a function `BitVec w → BitVec w` is easy (?).
-/
-- suggestion: use `partial_fixpoint`
-- parameterized fixed point operator
-- def calc_fix {f} (fuel : Nat) (reg : HVector f l) (f : HVector f l → HVector f l) : Option (HVector f l) :=
--   match fuel with
--   | 0 => .none
--   | n+1 =>
--     let freg := f reg
--     if freg == reg then
--       return freg
--     else
--       calc_fix n (f reg) f

def fix_wrapper (s : Vector (Stream' (Option α)) n) (f : Vector (Option α) n → Vector (Option α) n) : Option (Vector (Stream' α) n) := sorry


-- /- 0 = fork(1)
-- 1 = add(0) -/

-- /--

--   fix_wrapper takes:
--   · initial state: (#v[.none, .none])
--   · connections are defined iteratively
-- -/
-- -- def protocol (fork add : Stream' (BitVec 1) → Stream' (BitVec 1)) (x y : Stream' (BitVec 1)) : BitVec 1 :=
-- --   fix_wrapper (α := BitVec 1) (#v[.none, .none]) (fun vals =>
-- --       let v_0 : Option (BitVec 1) := do
-- --         --try to get a value if possible
-- --         let v_1' ← vals[1]
-- --         return fork(v_1')
-- --       let v_1 : Option (BitVec 1) := do
-- --         let v_0' ← vals[0]
-- --         return add(v_0')
-- --       #v[v_0, v_1]
-- --     )

-- /-
--   Fork
--   | ^
--   | |
--   x y
--   | |
--   v |
--   Add
-- -/
-- -- def protocol (fork add : Stream' (BitVec 1) → Stream' (BitVec 1)) (x y : Stream' (BitVec 1)) : BitVec 1 :=
-- --   let state_space := (Stream' (BitVec 1) → Stream' (BitVec 1)) × (Stream' (BitVec 1) → Stream' (BitVec 1))
-- --   let output_fun : state_space → BitVec 1 :=
-- --       fun (fork, add) =>
-- --         (add x).head
-- --   let update_fun : state_space → state_space :=

-- --     sorry
-- --   Stream'.corec state_space output_fun update_state
