-- should replace with Lean import once Pure is upstream
import SSA.Projects.InstCombine.LLVM.Pure
import SSA.Projects.InstCombine.Base
import SSA.Experimental.IntrinsicAsymptotics

namespace Lean.IR.LLVM.Pure

def Instruction.toOp : Nat → Instruction → Option InstCombine.Op
| _, .alloca _ _ => none
| _, .load2 _ _ _ => none
| _, .store _ _ => none
| _, .gep _ _ _ => none
| _, .inboundsgep _ _ _ => none
| _, .sext _ _ => none
| _, .zext _ _ => none
| _, .sext_or_trunc _ _ => none
| _, .ptrtoint _ _ => none
| _, .phi _ _ => none
| w, .mul _ _ _ => some (InstCombine.Op.mul w)
| w, .add  _ _ _ => some (InstCombine.Op.add w)
| w, .sub  _ _ _ => some (InstCombine.Op.sub w)
| w, .not _ _ => some (InstCombine.Op.not w)
| w, .icmp pred _ _ _ => some (InstCombine.Op.icmp pred w)

abbrev Context := Ctxt InstCombine.Ty
abbrev Expr (Γ : Context) (ty : InstCombine.Ty) := IExpr InstCombine.Op Γ ty
abbrev Bitvec (w : Nat) := InstCombine.Ty.bitvec w

def Instruction.toIExpr : (w : Nat) → (Γ : Context) → Instruction → Option (Expr Γ (Bitvec w))
| _, _, .alloca _ _ => none
| _, _, .load2 _ _ _ => none
| _, _, .store _ _ => none
| _, _, .gep _ _ _ => none
| _, _, .inboundsgep _ _ _ => none
| _, _, .sext _ _ => none
| _, _, .zext _ _ => none
| _, _, .sext_or_trunc _ _ => none
| _, _, .ptrtoint _ _ => none
| _, _, .phi _ _ => none
--| w, Γ, .mul lhs rhs name => some <|
| _, _, _ => none

/-- Takes a basic block and converts into ICom.
The `name` is ignored, `instrs` become `lete`s,
and the `terminator` becomes a `ret`.
-/
def BasicBlock.retTy : BasicBlock → Option InstCombine.Ty
  | _ => none

def BasicBlock.toICom (bb : BasicBlock) (Γ : Context) : Option <| ICom InstCombine.Op Γ (bb.retTy.get!) :=
  none



