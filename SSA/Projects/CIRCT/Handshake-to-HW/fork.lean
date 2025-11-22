import SSA.Projects.CIRCT.Stream.WeakBisim


namespace CIRCTStream

/-- We pack all the outputs in the module in a structure -/
structure out_struct where
  (arg0_ready : Stream' (BitVec 1))
  (arg1_ready : Stream' (BitVec 1))
  (out0_valid : Stream' (BitVec 1))
  (out1_valid : Stream' (BitVec 1))
  (out2_valid : Stream' (BitVec 1))
  (out0 : Stream' (BitVec 1))
  (out1 : Stream' (BitVec 1))
  (out2 : Stream' (BitVec 1))

/-!
Trace monoidal categories:
we model a feedback loop as a function with a-many inputs and x-many inputs, producing b-many outputs
and x-many outputs that are re-fed as inputs to the function (inputs, inputs from feedback, outputs,
outputs to be fed-back)
-/

/--
  We define a register wrapper to describe the behaviour of components with feedback loops.
  We expect the feedback loop to satisfy some laws that will be helpful in proofs.
  · `input` is the the stream of inputs
  · `init_regs` contains the initial values of inputs obtained from the feedback loop
  · `update_fun` is the function computing the output of the component, given all the inputs
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
  We define an isomorphism from two streams `a`, `b` to a stream of their product BitVec 1 × BitVec 1.
  With this isomorphism we map the single streams that define the inputs of the hardware module to
  a unique streams, where each element is composed by the single streams.
-/
def iso (a b : Stream' (BitVec 1)) : Stream' (Vector (BitVec 1) 2) :=
    fun n =>
      {toArray := [a n, b n].toArray, size_toArray := by simp}

/-- We define the module as a function with inputs and outputs.
  we use `Stream'` type, which does not contain `Option` values, because at this level
  of abstractions the content of streams has been concretized

  Initial handshake program:

    handshake.func @test_fork(%arg0: none, %arg1: none, ...) -> (none, none, none) {
      %0:2 = fork [2] %arg0 : none
      return %0#0, %0#1, %arg1 : none, none, none
    }

  Lowered program
  (https://github.com/opencompl/DC-semantics-simulation-evaluation/commit/28ef888954a8726d4858bed925ad067729207655)

    module {
    hw.module @test_fork(in %arg0 : i0, in %arg0_valid : i1, in %arg1 : i0, in %arg1_valid : i1, in %clk : !seq.clock, in %rst : i1, in %out0_ready : i1, in %out1_ready : i1, in %out2_ready : i1, out arg0_ready : i1, out arg1_ready : i1, out out0 : i0, out out0_valid : i1, out out1 : i0, out out1_valid : i1, out out2 : i0, out out2_valid : i1) {
      %c0_i0 = hw.constant 0 : i0
      %c0_i0_0 = hw.constant 0 : i0
      %false = hw.constant false
      %true = hw.constant true
      %0 = comb.xor %12, %true : i1
      %1 = comb.and %5, %0 : i1
      %emitted_0 = seq.compreg sym @emitted_0 %1, %clk reset %rst, %false : i1
      %2 = comb.xor %emitted_0, %true : i1
      %3 = comb.and %2, %arg0_valid : i1
      %4 = comb.and %out0_ready, %3 : i1
      %5 = comb.or %4, %emitted_0 {sv.namehint = "done0"} : i1
      %6 = comb.xor %12, %true : i1
      %7 = comb.and %11, %6 : i1
      %emitted_1 = seq.compreg sym @emitted_1 %7, %clk reset %rst, %false : i1
      %8 = comb.xor %emitted_1, %true : i1
      %9 = comb.and %8, %arg0_valid : i1
      %10 = comb.and %out1_ready, %9 : i1
      %11 = comb.or %10, %emitted_1 {sv.namehint = "done1"} : i1
      %12 = comb.and %5, %11 {sv.namehint = "allDone"} : i1
      hw.output %12, %out2_ready, %c0_i0, %3, %c0_i0_0, %9, %arg1, %arg1_valid : i1, i1, i0, i1, i0, i1, i0, i1
      }
    }

-/
def module
    (arg0 : Stream' (BitVec 1))
    (arg0_valid : Stream' (BitVec 1))
    (arg1 : Stream' (BitVec 1))
    (arg1_valid : Stream' (BitVec 1))
    (rst : Stream' (BitVec 1))
    (out0_ready : Stream' (BitVec 1))
    (out1_ready : Stream' (BitVec 1))
    (out2_ready : Stream' (BitVec 1)) : out_struct :=
  let c_0_i0 : Stream' (BitVec 0) := Stream'.const 0#0
  let c_0_i0_0 : Stream' (BitVec 0) := Stream'.const 0#0
  let False : Stream' (BitVec 1) := Stream'.const 0#1
  let True : Stream' (BitVec 1) := Stream'.const 1#1
  let inputs := iso arg0 True
  let xor := register_wrapper
                (inputs := inputs)
                (init_regs := sorry)
                (update_fun := BitVec.xor)
  sorry


-- def register_wrapper
--     (inputs : Stream' (Vector α m))
--     -- we set the `init_regs` to `none` after using the values for the first iteration
--     (init_regs : Vector α nfeed)
--     -- inputs- and outputs- that are feedback-looped are canceled
--     (update_fun : (Vector α m × Vector α nfeed) → (Vector α r × Vector α nfeed))
--       : Stream' (Vector α r) :=
--   /-
