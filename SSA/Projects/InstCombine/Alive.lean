/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

-- Pure math statements needed to prove alive statements.
-- Include these, as they are reasonably fast to typecheck.
import SSA.Projects.InstCombine.AliveStatements

-- Handwritten Alive examples.
-- This has those examples from alive that failed to be
-- translated correctly due to bugs in the translator.
import SSA.Projects.InstCombine.AliveHandwrittenExamples
import SSA.Projects.InstCombine.AliveHandwrittenLargeExamples

-- The semantics for the MLIR base dialect
import SSA.Projects.InstCombine.Base

import SSA.Projects.InstCombine.ComWrappers

-- An tactic for automatically proofing the alive math statements
import SSA.Projects.InstCombine.TacticAuto

-- Theorems to be upstreamed.
import SSA.Projects.InstCombine.ForLean

-- Theorems about our LLVM-level semantics.
import SSA.Projects.InstCombine.LLVM.Lemmas

-- Test cases
import SSA.Projects.InstCombine.Test
-- Examples for the paper
import SSA.Projects.InstCombine.PaperExamples
-- Proofs from Hackers Delight Book
import SSA.Projects.InstCombine.HackersDelight.ch2_1DeMorgan
import SSA.Projects.InstCombine.HackersDelight.ch2_2AdditionAndLogicalOps
