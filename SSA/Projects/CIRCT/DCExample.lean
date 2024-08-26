
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Projects.CIRCT.DC
import SSA.Projects.CIRCT.DC.Stream



/-!
## Examples
-/
namespace DC
namespace Examples

def BranchEg1 := [dc_com| {
  ^entry(%0: !Stream_Bool, %1: !Stream_Bool):
    %out = "dc.branch" (%0, %1) : (!Stream_Bool, !Stream_Bool) -> (!Stream2_Bool)
    %0 = "dc.fst" (%out) : (!Stream2_Bool) -> (!Stream_Bool)
    %outs = "dc.snd" (%out) : (!Stream2_Bool) -> (!Stream_Bool)
    %out2 = "dc.merge" (%outf, %outs) : (!Stream_Bool, !Stream_Bool) -> (!Stream_Bool)
    "return" (%out) : (!Stream_Bool) -> ()
  }]


#check BranchEg1
#eval BranchEg1
#reduce BranchEg1
#check BranchEg1.denote
#print axioms BranchEg1

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def x : Stream Bool := ofList [some true, none, some false, some true, some false]
def c : Stream Bool := ofList [some true, some false, none, some true]

def test : Stream Bool :=
  BranchEg1.denote (Valuation.ofPair c x)

def remNone (lst : List (Option Bool)) : List (Option Bool) :=
  lst.filter (fun | some x => true
                  | none => false)


end Examples
end DC
