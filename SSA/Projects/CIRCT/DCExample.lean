
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Projects.CIRCT.DC
import SSA.Projects.CIRCT.DC.Stream

/-!
## Examples
-/
namespace DC
namespace Examples

unseal String.splitOnAux in
def BranchEg1 := [dc_com| {
  ^entry(%0: !Stream_Int, %1: !Stream_Bool):
    %out = "dc.branch" (%0, %1) : (!Stream_Int, !Stream_Bool) -> (!Stream2_Int)
    %outf = "dc.fst" (%out) : (!Stream2_Int) -> (!Stream_Int)
    %outs = "dc.snd" (%out) : (!Stream2_Int) -> (!Stream_Int)
    %out2 = "dc.merge" (%outs, %outf) : (!Stream_Int, !Stream_Int) -> (!Stream_Int)
    "return" (%out2) : (!Stream_Int) -> ()
  }]

#check BranchEg1
#eval BranchEg1
#reduce BranchEg1
#check BranchEg1.denote
#print axioms BranchEg1

def ofList (vals : List (Option α)) : Stream α :=
  fun i => (vals.get? i).join

def c : Stream Bool := ofList [some true, none, some false, some true, some false]
def x : Stream Int := ofList [some 1, some 2, none, some 3]

def test : Stream Int :=
  BranchEg1.denote (Ctxt.Valuation.ofPair c x)

def remNone (lst : List (Option Bool)) : List (Option Bool) :=
  lst.filter (fun | some x => true
                  | none => false)

end Examples
end DC
