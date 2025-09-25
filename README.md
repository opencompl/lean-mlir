<h1>
Lean-MLIR
<img src="./images/logo.png"
     alt="LeanMLIR" title="LeanMLIR"
     class="center"
     width=80 height=80
     style="width: 2.5em; height: 2.5em"/>
</h1>
     
Theory of static single assignment developed in the Lean proof assistant.
We also build a wealth of tooling to interact closely with the [MLIR compiler ecosystem](https://mlir.llvm.org/),
to enable workflows that include formal verification in the day-to-day of MLIR development.

#### Documentation

- **Publication: [Verifying Peephole Rewriting In SSA Compiler IRs](https://arxiv.org/abs/2407.03685)**
- [API Documentation (auto-generated)](https://opencompl.github.io/lean-mlir/)
- Playground at [lean-mlir.grosser.es](https://lean-mlir.grosser.es)

#### Installation

- First, setup the Lean toolchain with [elan](https://github.com/leanprover/elan?tab=readme-ov-file#installation).
- Next, run:

```
git clone https://github.com/opencompl/lean-mlir.git && cd lean-mlir && lake exe cache get && lake build
```

#### Core theorems

- The proof that rewrites preserve semantics is found at `denote_rewritePeepholeAt`.
- All core theorems are guarded by `#guard_msgs in #print axioms` to make sure that we never use `sorry` as an axiom to prove
  a core theorem of the framework.

#### Directory Structure

This directory structure is heavily inspired by the [Research Codebase Manifesto](https://www.moderndescartes.com/essays/research_code/).

#### `SSA/Core`: 

> Libraries for reusable components. Code is reviewed to
> engineering standards. Code is tested, covered by continuous integration, and
> should never be broken. Very low tolerance for tech debt.
> Breaking changes to core code should be accompanied by fixes to affected
> project code. The project owner should assist in identifying potential
> breakage. No need to fix experimental code.

##### `SSA/Projects`: 

> A top-level folder for each major effort (rough criteria: a project represents 1-6 months of work).
>   - Code is reviewed for correctness. Testing is recommended but optional, as
>     is continuous integration.
>   - No cross-project dependencies. If you need code from a different project,
>     either go through the effort of polishing the code into core, or clone
>     the code.

##### `SSA/Experimental`:

> Anything goes. Recommend namespacing by time (e.g. a new directory every month).
>     - Rubber-stamp approvals. Code review is optional and comments may be
>       ignored without justification. Do not plug this into continuous
>       integration.
>     - The goal of this directory is to create a safe space for researchers so
>       that they do not need to hide their work. By passively observing research
>       code “in the wild”, engineers can understand research pain points.

##### - `related-work/`: 

> Top-level folder for research dependencies.

##### `artifact-evaluation/`:

> Docker container build for the current version of the library.
