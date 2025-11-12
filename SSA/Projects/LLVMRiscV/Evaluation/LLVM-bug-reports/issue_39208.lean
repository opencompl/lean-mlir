import SSA.Projects.RISCV64.PrettyEDSL
import LeanMLIR.Framework
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

/-!
  Bug reported in https://github.com/llvm/llvm-project/issues/39208
  and fixed in https://github.com/llvm/llvm-project/commit/4041c44853588c1e4918ec4a160c053cf08432b5
-/

namespace BitVec
open LLVMRiscV


-- Source:
-- i8 %tmp0 = 0xff (255, -1)
-- i8 %tmp1 = 0x7e (126)
-- i1 %ret = 0x1 (1, -1)

-- Target:
-- i8 %tmp0 = 0xff (255, -1)
-- i1 %1 = 0x0 (0)
-- Source value: 0x1 (1, -1)
-- Target value: 0x0 (0)
