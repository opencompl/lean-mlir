
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gbswap_proof
theorem PR39793_bswap_u64_as_u16_trunc_thm (x : BitVec 64) : setWidth 8 (x >>> 8) &&& 255#8 = setWidth 8 (x >>> 8) := sorry

theorem PR39793_bswap_u32_as_u16_trunc_thm (x : BitVec 32) : setWidth 8 (x >>> 8) &&& 255#8 = setWidth 8 (x >>> 8) := sorry

