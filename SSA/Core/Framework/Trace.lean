/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Lean

/-!
## LeanMLIR trace classes
-/

-- Trace class for LeanMLIR elaboration code
initialize Lean.registerTraceClass `LeanMLIR.Elab
