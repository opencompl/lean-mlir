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

-- The semantics for the MLIR base dialect
import SSA.Projects.InstCombine.Base

import SSA.Projects.InstCombine.ComWrappers

-- An tactic for automatically proofing the alive math statements
import SSA.Projects.InstCombine.TacticAuto
