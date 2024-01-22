
-- Pure math statements needed to prove alive statements.
-- Include these, as they are reasonably fast to typecheck.
import SSA.Projects.InstCombine.AliveStatements

-- The semantics for the MLIR base dialect
import SSA.Projects.InstCombine.Base

-- An tactic for automatically proofing the alive math statements
import SSA.Projects.InstCombine.TacticAuto
