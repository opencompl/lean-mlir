/-
Properties of chordal graphs.
Proof that a chordal graphs possess a perfect eliminiation ordering.
This implies that greedy coloring is optimal for chordal graphs.
We also provide easy lemmas that make the fact that
the interference graph of a SSA program is chordal.

References:
- https://compilers.cs.uni-saarland.de/projects/ssara/
- Optimal register allocation for SSA form programs in polytime:
    https://www.sciencedirect.com/science/article/pii/S0020019006000196?via%3Dihub
 -/

 /-
 TODO: think if this can be written abstractly in terms
 of a matroid?
 -/
import Mathlib.Combinatorics.SimpleGraph.Basic
import Mathlib.Combinatorics.SimpleGraph.Coloring
import Mathlib.Combinatorics.SimpleGraph.Finite
import Mathlib.Combinatorics.SimpleGraph.Operations
import Mathlib.Combinatorics.SimpleGraph.Maps
import Mathlib.Combinatorics.SimpleGraph.IncMatrix
import Mathlib.Data.Matroid.Basic
import Mathlib.Data.Matroid.IndepAxioms
import Mathlib.Combinatorics.SimpleGraph.Acyclic -- dominator tree.
