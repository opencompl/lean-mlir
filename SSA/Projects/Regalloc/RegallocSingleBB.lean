-- Register allocation for a single basic block program.
import SSA.Core.Framework

namespace Pure

inductive BinopKind
| add 

inductive Op 
| binop (binopKind : BinopKind)
| const (i : Int)

inductive Ty 
-- | int (width : Nat) : Ty
| int : Ty


abbrev dialect : Dialect where 
 Op := Op
 Ty := Ty

def Op.signature : Op → Signature Ty
| .binop .add => {
    sig := [.int, .int],
    regSig := .nil,
    outTy := .int
  }
| .const _x => {
    sig := []
    regSig := .nil,
    outTy := .int
  }

 instance : DialectSignature dialect where
   signature := Op.signature
 end Pure



 namespace RegAlloc
 end RegAlloc
  
#check Dialect
#check Lets
