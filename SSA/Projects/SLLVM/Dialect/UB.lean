/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Core.Util.Poison

namespace LeanMLIR

def UBOr := PoisonOr

namespace UBOr

/-! ## Constructors -/

def ub : UBOr α := PoisonOr.poison
def value : α → UBOr α := PoisonOr.value

/-! ## Monad -/

instance : Monad UBOr := inferInstanceAs (Monad PoisonOr)

end UBOr
