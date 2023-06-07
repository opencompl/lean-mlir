-- Core
-- ====

import SSA.Core.Framework
import SSA.Core.WellTypedFramework


-- Projects
-- ========

-- Eventually, all projects must be imported.
import SSA.Projects.InstCombine.InstCombinePeepholeRewrites
import SSA.Projects.InstCombine.InstCombineAlive
import SSA.Projects.Tensor1D.Tensor1D
import SSA.Projects.Tensor2D.Tensor2D


-- EXPERIMENTAL
-- ============

-- Bit-fiddling decision procedure
-- import SSA.Experimental.Bits.Decide
