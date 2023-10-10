import Std.Data.List.Basic

namespace MLIR.AST

/--
Store the names of the raw SSA variables (as strings).
The order in the list should match the order in which they appear in the code.
-/
abbrev NameMapping := List String

namespace NameMapping

def lookup (nm : NameMapping) (name : String) : Option Nat :=
  nm.indexOf? name

/--
  Add a new name to the mapping, assuming the name is not present in the list yet.
  If the name is already present, return `none`
-/
def add (nm : NameMapping) (name : String) : Option NameMapping := 
  match nm.lookup name with
    | none => some <| name::nm
    | some _ => none

end NameMapping

end MLIR.AST