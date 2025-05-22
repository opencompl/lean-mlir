/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Core.Util.Poison
import SSA.Projects.SLLVM.Tactic.SimpSet

namespace LeanMLIR

abbrev UBOr := PoisonOr

namespace UBOr

/-! ## Constructors -/

abbrev ub : UBOr α := PoisonOr.poison
abbrev value : α → UBOr α := PoisonOr.value


end UBOr
