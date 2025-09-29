/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

/-
This file should import everything in the LeanMLIR core, *besides* individual dialects
-/

import LeanMLIR.Framework
import LeanMLIR.Tactic
import LeanMLIR.Util
import LeanMLIR.MLIRSyntax

-- ## Transformations
import LeanMLIR.Transforms.Rewrite
import LeanMLIR.Transforms.CSE
import LeanMLIR.Transforms.DCE
