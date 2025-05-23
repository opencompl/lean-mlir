/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Algebra.Order.Group.Unbundled.Int


-- Core
-- ====
import SSA.Core


-- Projects
-- ========

-- Eventually, all projects must be imported.
import SSA.Projects.InstCombine.Alive
import SSA.Projects.FullyHomomorphicEncryption
import SSA.Projects.Tensor1D.Tensor1D
import SSA.Projects.Tensor2D.Tensor2D
import SSA.Projects.Holor.Holor
import SSA.Projects.DCE.DCE
import SSA.Projects.CSE.CSE
import SSA.Projects.PaperExamples.PaperExamples
import SSA.Projects.Scf.ScfFunctor
import SSA.Projects.LeanMlirCommon.LeanMlirCommon
import SSA.Projects.SLLVM.SLLVM


-- EXPERIMENTAL
-- ============

-- Bit-fiddling decision procedure
import SSA.Experimental.Bits.Fast
