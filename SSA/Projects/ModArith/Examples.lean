/-
Released under Apache 2.0 license as described in the file LICENSE.

End-to-end showcase of the framework for verifying rewrites about ModArith semantics,
by analogy to the FHE/Poly `PaperExamples.lean`.

Authors: Jaeho Choi<zerozerozero0216@gmail.com>
-/
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.Tactic
import SSA.Projects.ModArith.Basic
import SSA.Projects.ModArith.Statements
import SSA.Projects.ModArith.Syntax
import SSA.Projects.ModArith.PrettySyntax

open Ctxt (Var Valuation DerivedCtxt)
open MLIR AST

/-
We assume `q : Nat` with `[Fact (q > 1)]`, so that `(ZMod q)` is nontrivial.
You can fix `q = 42` or keep it a variable. This example sets `q=42` per your tests.
-/
namespace ModArithCanonicalization

-- variable {q : Nat} [hq : Fact (q > 1)]
def q : Nat := 42
instance hq : Fact (q > 1) := ⟨by decide⟩
instance h41 : (41 : ZMod q) = -1 := rfl

--------------------------------------------------------------------------------
-- test_add_fold
-- // CHECK-LABEL: @test_add_fold
-- // CHECK: () -> [[T:.*]] {
-- func.func @test_add_fold() -> !Zp {
--   // CHECK: %[[RESULT:.+]] = mod_arith.constant 18 : [[T]]
--   %e1 = mod_arith.constant 12 : !Zp
--   %e2 = mod_arith.constant 34 : !Zp
--   %add = mod_arith.add %e1, %e2 : !Zp
--   %e3 = mod_arith.constant 56 : !Zp
--   %add2 = mod_arith.add %add, %e3 : !Zp
--   // CHECK: return %[[RESULT]] : [[T]]
--   return %add2 : !Zp
-- }
--------------------------------------------------------------------------------

def test_add_fold_LHS :=
[mod_arith q, hq| {
  ^bb0():
    %e1 = mod_arith.constant 12 : !R
    %e2 = mod_arith.constant 34 : !R
    %add = mod_arith.add %e1, %e2 : !R
    %e3 = mod_arith.constant 56 : !R
    %add2 = mod_arith.add %add, %e3 : !R
    return %add2 : !R
}]

def test_add_fold_RHS := [mod_arith q, hq| {
  ^bb0():
    %res = mod_arith.constant 18 : !R
    return %res : !R
}]

noncomputable def TV_add_fold : PeepholeRewrite (ModArith q) [] .modLike :=
{
  lhs := test_add_fold_LHS,
  rhs := test_add_fold_RHS,
  correct := by
    funext valuation
    -- Expand the definitions:
    unfold test_add_fold_LHS test_add_fold_RHS
    simp_peephole [] at valuation
    norm_cast
}

--------------------------------------------------------------------------------
-- test_sub_fold
-- // CHECK-LABEL: @test_sub_fold
-- // CHECK: () -> [[T:.*]] {
-- func.func @test_sub_fold() -> !Zp {
--   // CHECK: %[[RESULT:.+]] = mod_arith.constant 6 : [[T]]
--   %e1 = mod_arith.constant 12 : !Zp
--   %e2 = mod_arith.constant 34 : !Zp
--   %sub = mod_arith.sub %e1, %e2 : !Zp
--   %e3 = mod_arith.constant 56 : !Zp
--   %sub2 = mod_arith.sub %sub, %e3 : !Zp
--   // CHECK: return %[[RESULT]] : [[T]]
--   return %sub2 : !Zp
-- }
--------------------------------------------------------------------------------

def test_sub_fold_LHS :=
[mod_arith q, hq| {
  ^bb0():
    %e1 = mod_arith.constant 12 : !R
    %e2 = mod_arith.constant 34 : !R
    %sub = mod_arith.sub %e1, %e2 : !R
    %e3 = mod_arith.constant 56 : !R
    %sub2 = mod_arith.sub %sub, %e3 : !R
    return %sub2 : !R
}]
def test_sub_fold_RHS := [mod_arith q, hq| {
  ^bb0():
    %res = mod_arith.constant 6 : !R
    return %res : !R
}]
noncomputable def TV_sub_fold : PeepholeRewrite (ModArith q) [] .modLike :=
{
  lhs := test_sub_fold_LHS,
  rhs := test_sub_fold_RHS,
  correct := by
    funext valuation
    unfold test_sub_fold_LHS test_sub_fold_RHS
    simp_peephole [] at valuation
    norm_cast
}

--------------------------------------------------------------------------------
-- test_mul_fold
-- // CHECK-LABEL: @test_mul_fold
-- // CHECK: () -> [[T:.*]] {
-- func.func @test_mul_fold() -> !Zp {
--   // CHECK: %[[RESULT:.+]] = mod_arith.constant 0 : [[T]]
--   %e1 = mod_arith.constant 12 : !Zp
--   %e2 = mod_arith.constant 34 : !Zp
--   %mul = mod_arith.mul %e1, %e2 : !Zp
--   %e3 = mod_arith.constant 56 : !Zp
--   %mul2 = mod_arith.mul %mul, %e3 : !Zp
--   return %mul2 : !Zp
-- }
--------------------------------------------------------------------------------
def test_mul_fold_LHS := [mod_arith q, hq| {
  ^bb0():
    %e1 = mod_arith.constant 12 : !R
    %e2 = mod_arith.constant 34 : !R
    %mul = mod_arith.mul %e1, %e2 : !R
    %e3 = mod_arith.constant 56 : !R
    %mul2 = mod_arith.mul %mul, %e3 : !R
    return %mul2 : !R
}]
def test_mul_fold_RHS := [mod_arith q, hq| {
  ^bb0():
    %res = mod_arith.constant 0 : !R
    return %res : !R
}]
noncomputable def TV_mul_fold : PeepholeRewrite (ModArith q) [] .modLike :=
{
  lhs := test_mul_fold_LHS,
  rhs := test_mul_fold_RHS,
  correct := by
    funext valuation
    unfold test_mul_fold_LHS test_mul_fold_RHS
    simp_peephole [] at valuation
    norm_cast
}

--------------------------------------------------------------------------------
-- test_add_zero_rhs
-- // CHECK-LABEL: @test_add_zero_rhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_add_zero_rhs(%x: !Zp) -> !Zp {
--   %zero = mod_arith.constant 0 : !Zp
--   %add = mod_arith.add %x, %zero : !Zp
--   // CHECK: return %[[arg0]] : [[T]]
--   return %add : !Zp
-- }
--------------------------------------------------------------------------------
def test_add_zero_rhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %zero = mod_arith.constant 0 : !R
    %add = mod_arith.add %x, %zero : !R
    return %add : !R
}]
def test_add_zero_rhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    return %x : !R
}]
noncomputable def TV_add_zero_rhs : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_add_zero_rhs_LHS,
  rhs := test_add_zero_rhs_RHS,
  correct := by
    funext valuation
    unfold test_add_zero_rhs_LHS test_add_zero_rhs_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
}
--------------------------------------------------------------------------------
-- test_add_zero_lhs
-- // CHECK-LABEL: @test_add_zero_lhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_add_zero_lhs(%x: !Zp) -> !Zp {
--   %zero = mod_arith.constant 0 : !Zp
--   %add = mod_arith.add %zero, %x : !Zp
--   // CHECK: return %[[arg0]] : [[T]]
--   return %add : !Zp
-- }
--------------------------------------------------------------------------------
def test_add_zero_lhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %zero = mod_arith.constant 0 : !R
    %add = mod_arith.add %zero, %x : !R
    return %add : !R
}]
def test_add_zero_lhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    return %x : !R
}]
noncomputable def TV_add_zero_lhs : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_add_zero_lhs_LHS,
  rhs := test_add_zero_lhs_RHS,
  correct := by
    funext valuation
    unfold test_add_zero_lhs_LHS test_add_zero_lhs_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
}

--------------------------------------------------------------------------------
-- test_sub_zero
-- // CHECK-LABEL: @test_sub_zero
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_sub_zero(%x: !Zp) -> !Zp {
--   %zero = mod_arith.constant 0 : !Zp
--   %sub = mod_arith.sub %x, %zero : !Zp
--   // CHECK: return %[[arg0]] : [[T]]
--   return %sub : !Zp
-- }
--------------------------------------------------------------------------------
def test_sub_zero_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %zero = mod_arith.constant 0 : !R
    %sub = mod_arith.sub %x, %zero : !R
    return %sub : !R
}]
def test_sub_zero_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    return %x : !R
}]
noncomputable def TV_sub_zero : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_sub_zero_LHS,
  rhs := test_sub_zero_RHS,
  correct := by
    funext valuation
    unfold test_sub_zero_LHS test_sub_zero_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
}

--------------------------------------------------------------------------------
-- test_mul_zero_rhs
-- // CHECK-LABEL: @test_mul_zero_rhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_mul_zero_rhs(%x: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 0 : [[T]]
--   %zero = mod_arith.constant 0 : !Zp
--   %mul = mod_arith.mul %x, %zero : !Zp
--   // CHECK: return %[[res0]] : [[T]]
--   return %mul : !Zp
-- }
--------------------------------------------------------------------------------
def test_mul_zero_rhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %zero = mod_arith.constant 0 : !R
    %mul = mod_arith.mul %x, %zero : !R
    return %mul : !R
}]
def test_mul_zero_rhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %zero = mod_arith.constant 0 : !R
    return %zero : !R
}]
noncomputable def TV_mul_zero_rhs : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_mul_zero_rhs_LHS,
  rhs := test_mul_zero_rhs_RHS,
  correct := by
    funext valuation
    unfold test_mul_zero_rhs_LHS test_mul_zero_rhs_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
}

--------------------------------------------------------------------------------
-- test_mul_zero_lhs
-- // CHECK-LABEL: @test_mul_zero_lhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_mul_zero_lhs(%x: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 0 : [[T]]
--   %zero = mod_arith.constant 0 : !Zp
--   %mul = mod_arith.mul %zero, %x : !Zp
--   // CHECK: return %[[res0]] : [[T]]
--   return %mul : !Zp
-- }
--------------------------------------------------------------------------------
def test_mul_zero_lhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %zero = mod_arith.constant 0 : !R
    %mul = mod_arith.mul %zero, %x : !R
    return %mul : !R
}]
def test_mul_zero_lhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %zero = mod_arith.constant 0 : !R
    return %zero : !R
}]
noncomputable def TV_mul_zero_lhs : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_mul_zero_lhs_LHS,
  rhs := test_mul_zero_lhs_RHS,
  correct := by
    funext valuation
    unfold test_mul_zero_lhs_LHS test_mul_zero_lhs_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
}

--------------------------------------------------------------------------------
-- test_mul_one_rhs
-- // CHECK-LABEL: @test_mul_one_rhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_mul_one_rhs(%x: !Zp) -> !Zp {
--   %one = mod_arith.constant 1 : !Zp
--   %mul = mod_arith.mul %x, %one : !Zp
--   // CHECK: return %[[arg0]] : [[T]]
--   return %mul : !Zp
-- }
--------------------------------------------------------------------------------
def test_mul_one_rhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %one = mod_arith.constant 1 : !R
    %mul = mod_arith.mul %x, %one : !R
    return %mul : !R
}]
def test_mul_one_rhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    return %x : !R
}]
noncomputable def TV_mul_one_rhs : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_mul_one_rhs_LHS,
  rhs := test_mul_one_rhs_RHS,
  correct := by
    funext valuation
    unfold test_mul_one_rhs_LHS test_mul_one_rhs_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
}

--------------------------------------------------------------------------------
-- test_mul_one_lhs
-- // CHECK-LABEL: @test_mul_one_lhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_mul_one_lhs(%x: !Zp) -> !Zp {
--   %one = mod_arith.constant 1 : !Zp
--   %mul = mod_arith.mul %one, %x : !Zp
--   // CHECK: return %[[arg0]] : [[T]]
--   return %mul : !Zp
-- }
--------------------------------------------------------------------------------
def test_mul_one_lhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %one = mod_arith.constant 1 : !R
    %mul = mod_arith.mul %one, %x : !R
    return %mul : !R
}]
def test_mul_one_lhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    return %x : !R
}]
noncomputable def TV_mul_one_lhs : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_mul_one_lhs_LHS,
  rhs := test_mul_one_lhs_RHS,
  correct := by
    funext valuation
    unfold test_mul_one_lhs_LHS test_mul_one_lhs_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
}

--------------------------------------------------------------------------------
-- test_add_add_const
-- // CHECK-LABEL: @test_add_add_const
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_add_add_const(%x: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 4 : [[T]]
--   // CHECK: %[[res1:.+]] = mod_arith.add %[[arg0]], %[[res0]] : [[T]]
--   %c0 = mod_arith.constant 12 : !Zp
--   %c1 = mod_arith.constant 34 : !Zp
--   %add = mod_arith.add %x, %c0 : !Zp
--   %add2 = mod_arith.add %add, %c1 : !Zp
--   // CHECK: return %[[res1]] : [[T]]
--   return %add2 : !Zp
-- }
--------------------------------------------------------------------------------
def test_add_add_const_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %c0 = mod_arith.constant 12 : !R
    %c1 = mod_arith.constant 34 : !R
    %add = mod_arith.add %x, %c0 : !R
    %add2 = mod_arith.add %add, %c1 : !R
    return %add2 : !R
}]
def test_add_add_const_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %res0 = mod_arith.constant 4 : !R
    %res1 = mod_arith.add %x, %res0 : !R
    return %res1 : !R
}]
noncomputable def TV_add_add_const : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_add_add_const_LHS,
  rhs := test_add_add_const_RHS,
  correct := by
    funext valuation
    unfold test_add_add_const_LHS test_add_add_const_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
    rfl
}

--------------------------------------------------------------------------------
-- test_add_sub_const_rhs
-- // CHECK-LABEL: @test_add_sub_const_rhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_add_sub_const_rhs(%x: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 22 : [[T]]
--   // CHECK: %[[res1:.+]] = mod_arith.add %[[arg0]], %[[res0]] : [[T]]
--   %c0 = mod_arith.constant 12 : !Zp
--   %c1 = mod_arith.constant 34 : !Zp
--   %sub = mod_arith.sub %x, %c0 : !Zp
--   %add = mod_arith.add %sub, %c1 : !Zp
--   // CHECK: return %[[res1]] : [[T]]
--   return %add : !Zp
-- }
--------------------------------------------------------------------------------
def test_add_sub_const_rhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %c0 = mod_arith.constant 12 : !R
    %c1 = mod_arith.constant 34 : !R
    %sub = mod_arith.sub %x, %c0 : !R
    %add = mod_arith.add %sub, %c1 : !R
    return %add : !R
}]
def test_add_sub_const_rhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %res0 = mod_arith.constant 22 : !R
    %res1 = mod_arith.add %x, %res0 : !R
    return %res1 : !R
}]
noncomputable def TV_add_sub_const_rhs : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_add_sub_const_rhs_LHS,
  rhs := test_add_sub_const_rhs_RHS,
  correct := by
    funext valuation
    unfold test_add_sub_const_rhs_LHS test_add_sub_const_rhs_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
}

--------------------------------------------------------------------------------
-- test_add_sub_const_lhs
-- // CHECK-LABEL: @test_add_sub_const_lhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_add_sub_const_lhs(%x: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 4 : [[T
--   // CHECK: %[[res1:.+]] = mod_arith.sub %[[res0]], %[[arg0]] : [[T]]
--   %c0 = mod_arith.constant 12 : !Zp
--   %c1 = mod_arith.constant 34 : !Zp
--   %sub = mod_arith.sub %c0, %x : !Zp
--   %add = mod_arith.add %sub, %c1 : !Zp
--   // CHECK: return %[[res1]] : [[T]]
--   return %add : !Zp
-- }
--------------------------------------------------------------------------------
def test_add_sub_const_lhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %c0 = mod_arith.constant 12 : !R
    %c1 = mod_arith.constant 34 : !R
    %sub = mod_arith.sub %c0, %x : !R
    %add = mod_arith.add %sub, %c1 : !R
    return %add : !R
}]
def test_add_sub_const_lhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %res0 = mod_arith.constant 4 : !R
    %res1 = mod_arith.sub %res0, %x : !R
    return %res1 : !R
}]
noncomputable def TV_add_sub_const_lhs : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_add_sub_const_lhs_LHS,
  rhs := test_add_sub_const_lhs_RHS,
  correct := by
    funext valuation
    unfold test_add_sub_const_lhs_LHS test_add_sub_const_lhs_RHS
    simp_peephole [] at valuation
    intro x
    norm_cast
    ring_nf
    rfl
}

--------------------------------------------------------------------------------
-- test_add_mul_neg_one_rhs
-- // CHECK-LABEL: @test_add_mul_neg_one_rhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_add_mul_neg_one_rhs(%x: !Zp, %y: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.sub %[[arg0]], %[[arg1]] : [[T]]
--   %neg_one = mod_arith.constant 41 : !Zp
--   %mul = mod_arith.mul %y, %neg_one : !Zp
--   %add = mod_arith.add %x, %mul : !Zp
--   // CHECK: return %[[res0]] : [[T]]
--   return %add : !Zp
-- }
--------------------------------------------------------------------------------
def test_add_mul_neg_one_rhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R, %y : !R):
    %neg_one = mod_arith.constant 41 : !R
    %mul = mod_arith.mul %y, %neg_one : !R
    %add = mod_arith.add %x, %mul : !R
    return %add : !R
}]
def test_add_mul_neg_one_rhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R, %y : !R):
    %res0 = mod_arith.sub %x, %y : !R
    return %res0 : !R
}]
noncomputable def TV_add_mul_neg_one_rhs : PeepholeRewrite (ModArith q) [.modLike, .modLike] .modLike :=
{
  lhs := test_add_mul_neg_one_rhs_LHS,
  rhs := test_add_mul_neg_one_rhs_RHS,
  correct := by
    funext valuation
    unfold test_add_mul_neg_one_rhs_LHS test_add_mul_neg_one_rhs_RHS
    simp_peephole [] at valuation
    intro x y
    simp [h41]
    ring_nf
}

--------------------------------------------------------------------------------
-- test_add_mul_neg_one_lhs
-- // CHECK-LABEL: @test_add_mul_neg_one_lhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_add_mul_neg_one_lhs(%x: !Zp, %y: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.sub %[[arg1]], %[[arg0]] : [[T]]
--   %neg_one = mod_arith.constant 41 : !Zp
--   %mul = mod_arith.mul %neg_one, %x : !Zp
--   %add = mod_arith.add %mul, %y : !Zp
--   // CHECK: return %[[res0]] : [[T]]
--   return %add : !Zp
-- }
--------------------------------------------------------------------------------
def test_add_mul_neg_one_lhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R, %y : !R):
    %neg_one = mod_arith.constant 41 : !R
    %mul = mod_arith.mul %neg_one, %x : !R
    %add = mod_arith.add %mul, %y : !R
    return %add : !R
}]
def test_add_mul_neg_one_lhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R, %y : !R):
    %res0 = mod_arith.sub %y, %x : !R
    return %res0 : !R
}]
noncomputable def TV_add_mul_neg_one_lhs : PeepholeRewrite (ModArith q) [.modLike, .modLike] .modLike :=
{
  lhs := test_add_mul_neg_one_lhs_LHS,
  rhs := test_add_mul_neg_one_lhs_RHS,
  correct := by
    funext valuation
    unfold test_add_mul_neg_one_lhs_LHS test_add_mul_neg_one_lhs_RHS
    simp_peephole [] at valuation
    intro x y
    simp [h41]
    ring_nf
}

--------------------------------------------------------------------------------
-- test_sub_mul_neg_one_rhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]], %[[arg1:.*]]: [[T]]) -> [[T]]
-- func.func @test_sub_mul_neg_one_lhs(%x: !Zp, %y: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 0 : [[T]]
--   // CHECK: %[[res1:.+]] = mod_arith.add %[[arg0]], %[[arg1]] : [[T]]
--   // CHECK: %[[res2:.+]] = mod_arith.sub %[[res0]], %[[res1]] : [[T]]
--   %neg_one = mod_arith.constant 41 : !Zp
--   %mul = mod_arith.mul %x, %neg_one : !Zp
--   %sub = mod_arith.sub %mul, %y : !Zp
--   // CHECK: return %[[res2]] : [[T]]
--   return %sub : !Zp
-- }
--------------------------------------------------------------------------------
def test_sub_mul_neg_one_rhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R, %y : !R):
    %neg_one = mod_arith.constant 41 : !R
    %mul = mod_arith.mul %x, %neg_one : !R
    %sub = mod_arith.sub %mul, %y : !R
    return %sub : !R
}]
def test_sub_mul_neg_one_rhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R, %y : !R):
    %res0 = mod_arith.constant 0 : !R
    %res1 = mod_arith.add %x, %y : !R
    %res2 = mod_arith.sub %res0, %res1 : !R
    return %res2 : !R
}]
noncomputable def TV_sub_mul_neg_one_rhs : PeepholeRewrite (ModArith q) [.modLike, .modLike] .modLike :=
{
  lhs := test_sub_mul_neg_one_rhs_LHS,
  rhs := test_sub_mul_neg_one_rhs_RHS,
  correct := by
    funext valuation
    unfold test_sub_mul_neg_one_rhs_LHS test_sub_mul_neg_one_rhs_RHS
    simp_peephole [] at valuation
    intro x y
    simp [h41]
    ring_nf
}

--------------------------------------------------------------------------------
-- test_sub_mul_neg_one_lhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]], %[[arg1:.*]]: [[T]]) -> [[T]]
-- func.func @test_sub_mul_neg_one_lhs(%x: !Zp, %y: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 0 : [[T]]
--   // CHECK: %[[res1:.+]] = mod_arith.add %[[arg0]], %[[arg1]] : [[T]]
--   // CHECK: %[[res2:.+]] = mod_arith.sub %[[res0]], %[[res1]] : [[T]]
--   %neg_one = mod_arith.constant 41 : !Zp
--   %mul = mod_arith.mul %x, %neg_one : !Zp
--   %sub = mod_arith.sub %mul, %y : !Zp
--   // CHECK: return %[[res2]] : [[T]]
--   return %sub : !Zp
-- }
def test_sub_mul_neg_one_lhs_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R, %y : !R):
    %neg_one = mod_arith.constant 41 : !R
    %mul = mod_arith.mul %neg_one, %x : !R
    %sub = mod_arith.sub %mul, %y : !R
    return %sub : !R
}]
def test_sub_mul_neg_one_lhs_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R, %y : !R):
    %res0 = mod_arith.constant 0 : !R
    %res1 = mod_arith.add %x, %y : !R
    %res2 = mod_arith.sub %res0, %res1 : !R
    return %res2 : !R
}]
noncomputable def TV_sub_mul_neg_one_lhs : PeepholeRewrite (ModArith q) [.modLike, .modLike] .modLike :=
{
  lhs := test_sub_mul_neg_one_lhs_LHS,
  rhs := test_sub_mul_neg_one_lhs_RHS,
  correct := by
    funext valuation
    unfold test_sub_mul_neg_one_lhs_LHS test_sub_mul_neg_one_lhs_RHS
    simp_peephole [] at valuation
    intro x y
    simp [h41]
    ring_nf
}
--------------------------------------------------------------------------------
-- test_mul_mul_const
-- // CHECK-LABEL: @test_mul_mul_const
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_mul_mul_const(%x: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 30 : [[T]]
--   // CHECK: %[[res1:.+]] = mod_arith.mul %[[arg0]], %[[res0]] : [[T]]
--   %c0 = mod_arith.constant 12 : !Zp
--   %c1 = mod_arith.constant 34 : !Zp
--   %mul = mod_arith.mul %x, %c0 : !Zp
--   %mul2 = mod_arith.mul %mul, %c1 : !Zp
--   // CHECK: return %[[res1]] : [[T]]
--   return %mul2 : !Zp
-- }
--------------------------------------------------------------------------------
def test_mul_mul_const_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %c0 = mod_arith.constant 12 : !R
    %c1 = mod_arith.constant 34 : !R
    %mul = mod_arith.mul %x, %c0 : !R
    %mul2 = mod_arith.mul %mul, %c1 : !R
    return %mul2 : !R
}]
def test_mul_mul_const_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %res0 = mod_arith.constant 30 : !R
    %res1 = mod_arith.mul %x, %res0 : !R
    return %res1 : !R
}]
noncomputable def TV_mul_mul_const : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_mul_mul_const_LHS,
  rhs := test_mul_mul_const_RHS,
  correct := by
    funext valuation
    unfold test_mul_mul_const_LHS test_mul_mul_const_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
    rfl
}

--------------------------------------------------------------------------------
-- test_sub_rhs_add_const
-- // CHECK-LABEL: @test_sub_rhs_add_const
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_sub_rhs_add_const(%x: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 20 : [[T]]
--   // CHECK: %[[res1:.+]] = mod_arith.add %[[arg0]], %[[res0]] : [[T]]
--   %c0 = mod_arith.constant 12 : !Zp
--   %c1 = mod_arith.constant 34 : !Zp
--   %add = mod_arith.add %x, %c0 : !Zp
--   %sub = mod_arith.sub %add, %c1 : !Zp
--   // CHECK: return %[[res1]] : [[T]]
--   return %sub : !Zp
-- }
--------------------------------------------------------------------------------
def test_sub_rhs_add_const_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %c0 = mod_arith.constant 12 : !R
    %c1 = mod_arith.constant 34 : !R
    %add = mod_arith.add %x, %c0 : !R
    %sub = mod_arith.sub %add, %c1 : !R
    return %sub : !R
}]
def test_sub_rhs_add_const_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %res0 = mod_arith.constant 20 : !R
    %res1 = mod_arith.add %x, %res0 : !R
    return %res1 : !R
}]
noncomputable def TV_sub_rhs_add_const : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_sub_rhs_add_const_LHS,
  rhs := test_sub_rhs_add_const_RHS,
  correct := by
    funext valuation
    unfold test_sub_rhs_add_const_LHS test_sub_rhs_add_const_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
    rfl
}

--------------------------------------------------------------------------------
-- test_sub_lhs_add_const
-- // CHECK-LABEL: @test_sub_lhs_add_const
-- // CHECK: (%[[arg0:.*]]: [[T:.*]]) -> [[T]]
-- func.func @test_sub_lhs_add_const(%x: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 22 : [[T]]
--   // CHECK: %[[res1:.+]] = mod_arith.sub %[[res0]], %[[arg0]] : [[T]]
--   %c0 = mod_arith.constant 12 : !Zp
--   %c1 = mod_arith.constant 34 : !Zp
--   %add = mod_arith.add %x, %c0 : !Zp
--   %sub = mod_arith.sub %c1, %add : !Zp
--   // CHECK: return %[[res1]] : [[T]]
--   return %sub : !Zp
-- }
--------------------------------------------------------------------------------
def test_sub_lhs_add_const_LHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %c0 = mod_arith.constant 12 : !R
    %c1 = mod_arith.constant 34 : !R
    %add = mod_arith.add %x, %c0 : !R
    %sub = mod_arith.sub %c1, %add : !R
    return %sub : !R
}]
def test_sub_lhs_add_const_RHS := [mod_arith q, hq| {
  ^bb0(%x : !R):
    %res0 = mod_arith.constant 22 : !R
    %res1 = mod_arith.sub %res0, %x : !R
    return %res1 : !R
}]
noncomputable def TV_sub_lhs_add_const : PeepholeRewrite (ModArith q) [.modLike] .modLike :=
{
  lhs := test_sub_lhs_add_const_LHS,
  rhs := test_sub_lhs_add_const_RHS,
  correct := by
    funext valuation
    unfold test_sub_lhs_add_const_LHS test_sub_lhs_add_const_RHS
    simp_peephole [] at valuation
    intro x
    ring_nf
}

--------------------------------------------------------------------------------
-- test_sub_sub_lhs_rhs_lhs
-- // CHECK-LABEL: @test_sub_sub_lhs_rhs_lhs
-- // CHECK: (%[[arg0:.*]]: [[T:.*]], %[[arg1:.*]]: [[T]]) -> [[T]]
-- func.func @test_sub_sub_lhs_rhs_lhs(%a: !Zp, %b: !Zp) -> !Zp {
--   // CHECK: %[[res0:.+]] = mod_arith.constant 0 : [[T]]
--   // CHECK: %[[res1:.+]] = mod_arith.sub %[[res0]], %[[arg1]] : [[T]]
--   %sub = mod_arith.sub %a, %b : !Zp
--   %sub2 = mod_arith.sub %sub, %a : !Zp
--   // CHECK: return %[[res1]] : [[T]]
--   return %sub2 : !Zp
-- }
--------------------------------------------------------------------------------
def test_sub_sub_lhs_rhs_lhs_LHS := [mod_arith q, hq| {
  ^bb0(%a : !R, %b : !R):
    %sub = mod_arith.sub %a, %b : !R
    %sub2 = mod_arith.sub %sub, %a : !R
    return %sub2 : !R
}]
def test_sub_sub_lhs_rhs_lhs_RHS := [mod_arith q, hq| {
  ^bb0(%a : !R, %b : !R):
    %res0 = mod_arith.constant 0 : !R
    %res1 = mod_arith.sub %res0, %b : !R
    return %res1 : !R
}]
noncomputable def TV_sub_sub_lhs_rhs_lhs : PeepholeRewrite (ModArith q) [.modLike, .modLike] .modLike :=
{
  lhs := test_sub_sub_lhs_rhs_lhs_LHS,
  rhs := test_sub_sub_lhs_rhs_lhs_RHS,
  correct := by
    funext valuation
    unfold test_sub_sub_lhs_rhs_lhs_LHS test_sub_sub_lhs_rhs_lhs_RHS
    simp_peephole [] at valuation
    intro a b
    ring_nf
}

end ModArithCanonicalization
