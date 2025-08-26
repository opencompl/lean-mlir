import SSA.Projects.LLVMRiscV.PeepholeRefine

open LLVMRiscV

/- This file defines a wrapper to simplify the creation of
   `PeepholeRewrite` instances for the instruction selection pipeline.
   The functions are used to create rewrites for binary and unary operations
   that take two or one input operands, respectively, and produce an output
   operand of a specified width. The functions return a dependent pair containing
   the input types, output type, and the rewrite itself.
-/
def mkRewrite {Γ ty}
  (rw : PeepholeRewrite LLVMPlusRiscV Γ ty) :
  Σ Γ ty, PeepholeRewrite LLVMPlusRiscV Γ ty :=
  ⟨_, _, rw⟩
