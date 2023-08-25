-- should replace with Lean import once Pure is upstream
import SSA.Projects.InstCombine.LLVM.Pure
import SSA.Projects.InstCombine.Base

namespace Lean.IR.LLVM.Pure

--def Reg.toAddress : Reg → Nat

/-- Pretty useless function, we should just use IntPredicate in `Op` -/
def IntPredicate.toComparison : IntPredicate → InstCombine.Comparison
| .eq => InstCombine.Comparison.eq
| .ne => InstCombine.Comparison.ne
| .ugt => InstCombine.Comparison.ugt
| .uge => InstCombine.Comparison.uge
| .ult => InstCombine.Comparison.ult
| .ule => InstCombine.Comparison.ule
| .sgt => InstCombine.Comparison.sgt
| .sge => InstCombine.Comparison.sge
| .slt => InstCombine.Comparison.slt
| .sle => InstCombine.Comparison.sle


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
| w, .icmp pred _ _ _ => some (InstCombine.Op.icmp pred.toComparison w)

open SSA
def Instruction.toStatement : Nat → Context InstCombine.BaseType → Instruction → Option (TSSA InstCombine.Op)
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
| w, Γ, .mul lhs rhs name => some <|
| w, Γ, .add  _ _ _ => some (InstCombine.Op.add w)
| w, Γ, .sub  _ _ _ => some (InstCombine.Op.sub w)
| w, Γ, .not _ _ => some (InstCombine.Op.not w)
| w, Γ, .icmp pred _ _ _ => some (InstCombine.Op.icmp pred.toComparison w)


/-- Takes a basic block and converts into TSSA.
The `name` is ignored, `instrs` become `TSSA.STMT`s,
and the `terminator` becomes a `TSSA.TERMINATOR`.
-/
def BasicBlock.toTSSA : BasicBlock → SSA.Context InstCombine.BaseType → SSA.TSSA InstCombine.Op :=
fun bb Γ =>
let stmts := bb.instrs.map (Instruction.toOp Γ.wordSize);



end Lean.IR.LLVM.Pure
