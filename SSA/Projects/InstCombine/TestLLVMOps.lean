/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import LeanMLIR.Dialects.LLVM.Syntax
import SSA.Projects.InstCombine.LLVM.CLITests

open MLIR AST
open Ctxt (Var)

-- Hardcoding the i4 for now, should change to w once I get
-- the signature working with that

deftest test_and :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.and %X, %Y : i4
  llvm.return %r : i4
}

deftest test_or :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.or %X, %Y : i4
  llvm.return %r : i4
}

-- don't use this one since not in LLVM
--deftest test_not :=
--{
--^bb0(%X : i4):
--  %r = llvm.not %X : i4
--  llvm.return %r : i4
--}

deftest test_xor :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.xor %X, %Y : i4
  llvm.return %r : i4
}

deftest test_shl :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.shl %X, %Y : i4
  llvm.return %r : i4
}

deftest test_lshr :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.lshr %X, %Y : i4
  llvm.return %r : i4
}

deftest test_ashr :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.ashr %X, %Y : i4
  llvm.return %r : i4
}

deftest test_urem :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.urem %X, %Y : i4
  llvm.return %r : i4
}

deftest test_srem :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.srem %X, %Y : i4
  llvm.return %r : i4
}

deftest test_select :=
{
^bb0(%X : i1, %Y : i4, %Z : i4):
  %r = llvm.select %X,  %Y, %Z : i4
  llvm.return %r : i4
}

deftest test_add :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.add %X, %Y : i4
  llvm.return %r : i4
}

deftest test_sub :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.sub %X, %Y : i4
  llvm.return %r : i4
}

deftest test_mul :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.mul %X, %Y : i4
  llvm.return %r : i4
}

-- don't use this one since not in LLVM
-- deftest test_neg :=
-- {
-- ^bb0(%X : i4):
--   %r = llvm.neg %X : i4
--   llvm.return %r : i4
-- }

-- don't use this one since not in LLVM
-- deftest test_copy :=
-- {
-- ^bb0(%X : i4):
--   %r = llvm.copy %X : i4
--   llvm.return %r : i4
-- }

deftest test_udiv :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.udiv %X, %Y : i4
  llvm.return %r : i4
}

deftest test_sdiv :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.sdiv %X, %Y : i4
  llvm.return %r : i4
}

deftest test_icmp_eq :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.eq %X, %Y : i4
  llvm.return %r : i1
}

deftest test_icmp_ne :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.ne %X, %Y : i4
  llvm.return %r : i1
}

deftest test_icmp_ult :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.ult %X, %Y : i4
  llvm.return %r : i1
}

deftest test_icmp_ugt :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.ugt %X, %Y : i4
  llvm.return %r : i1
}


deftest test_icmp_slt :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.slt %X, %Y : i4
  llvm.return %r : i1
}

deftest test_icmp_sgt :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.sgt %X, %Y : i4
  llvm.return %r : i1
}

deftest test_icmp_ule :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.ule %X, %Y : i4
  llvm.return %r : i1
}

deftest test_icmp_uge :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.uge %X, %Y : i4
  llvm.return %r : i1
}


deftest test_icmp_sle :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.sle %X, %Y : i4
  llvm.return %r : i1
}

deftest test_icmp_sge :=
{
^bb0(%X : i4, %Y : i4):
  %r = llvm.icmp.sge %X, %Y : i4
  llvm.return %r : i1
}
