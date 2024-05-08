/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Std
import Lean.Meta.Tactic.Rewrite
import Lean.Meta.Tactic.Refl
import Lean.Meta.Tactic.Simp
import Lean.Meta.Tactic.Replace
import Lean.Elab.Tactic.Basic
import Lean.Elab.Tactic.Rewrite
import Lean.Elab.Tactic.ElabTerm
import Lean.Elab.Tactic.Location
import Lean.Elab.Tactic.Config
import Lean.Data.Json

namespace MatchGoal

initialize Lean.registerTraceClass `matchgoal
open Lean Elab Meta Tactic Term Std RBMap



declare_syntax_cat goal_matcher
declare_syntax_cat hyp_matcher
declare_syntax_cat hyps_matcher
declare_syntax_cat unification_var
declare_syntax_cat unification_expr

syntax "?" ident : unification_var
syntax unification_var : term -- allow unification variables to be used in terms.

syntax unification_var : unification_expr -- this needs a converter
syntax term : unification_expr
syntax "(" unification_var ":" unification_expr ")" : hyp_matcher
syntax hyp_matcher+ : hyps_matcher


structure MVar where
  id: MVarId

def MVar.toExpr (mvar : MVar) : Expr := Expr.mvar mvar.id

instance : Coe MVar Expr where
  coe := MVar.toExpr

structure MGState where
 -- map unification variable names to metavars
  unifName2Metavar : Std.RBMap String MVar Compare
  -- map hypothesis names to expression
  hypsMatchers : Std.RBMap String Expr Compare
  -- if we have goal matcher, map to expression and metavar corresponding to it.
  goalMatcher : Option (MVar × Expr)

abbrev MatchGoalM α := StateT MGState MacroM α

-- instantiate the unification variable and create a real Lean metavariable
-- corresponding to it.
-- Also update the state to recored new unification variables.
def instantiateUnificationVar : TSyntax `unification_var → MatchGoalM (TSyntax `term) :=
  by sorry

-- instantiate all unification variables in the expression and create a real Lean term.
-- Also update the state to recored new unification variables
def instantiateUnificationExpr : TSyntax `unification_expr → MatchGoalM (TSyntax `term) :=
  by sorry

elab "matchgoal"
  hypsMatcher?:(" hyps " hyps_matcher)?
  goalMatcher?:(" goal " unification_expr)? " => "
  finalTactic:tactic : tactic => withMainContext do
    trace[matchgoal] "starting matching '{hypsMatcher?}' |- {goalMatcher?} => {finalTactic}"
    let goalType ← getMainTarget

    return ()



end MatchGoal
