import SSA.Projects.InstCombine.InstCombineBase
import SSA.Projects.InstCombine.Tests

inductive Dialect
  | InstCombine : Dialect
  deriving Repr

namespace Dialect

def fromString : String → Option Dialect 
 | "InstCombine"  => some Dialect.InstCombine
 | _ => none

def baseType : Dialect → Type
  | Dialect.InstCombine => InstCombine.BaseType 

def userType : Dialect → Type
  | Dialect.InstCombine =>  InstCombine.UserType 

def opType : Dialect → Type
  | Dialect.InstCombine =>  InstCombine.Op

def argUserType (d : Dialect) : d.opType → d.userType := match d with
  | Dialect.InstCombine => InstCombine.argUserType

def rgnDom (d : Dialect) : d.opType → d.userType := match d with
  | Dialect.InstCombine => InstCombine.rgnDom

def rgnCod (d : Dialect) : d.opType → d.userType := match d with
  | Dialect.InstCombine => InstCombine.rgnCod

def outUserType (d : Dialect) : d.opType → d.userType := match d with
  | Dialect.InstCombine => InstCombine.outUserType

instance : Inhabited Dialect := ⟨Dialect.InstCombine⟩

instance {d : Dialect} : SSA.OperationTypes d.opType d.baseType where
  argUserType := d.argUserType
  rgnDom := d.rgnDom
  rgnCod := d.rgnCod
  outUserType := d.outUserType

instance {d : Dialect} : Goedel d.baseType where
 toType := match d with
   | Dialect.InstCombine => InstCombine.instGoedelBaseType.toType

def indexType (d : Dialect) : Type := SSA.TSSAIndex d.baseType
def tSSAEmpty (d : Dialect) : d.indexType → Type := 
  let Γ : SSA.Context d.baseType := ∅   
  SSA.TSSA d.opType Γ


def testType (d : Dialect) : Type := SSA.Test (β := d.baseType)

def getTest (d : Dialect) : String → Option d.testType := 
  match d with
  | Dialect.InstCombine => InstCombine.getTest

instance {d : Dialect} : DecidableEq (SSA.UserType (Dialect.baseType d)) := 
  match d with
  | Dialect.InstCombine => inferInstanceAs (DecidableEq InstCombine.UserType)

-- TODO: Should do proper Repr instances here
instance {d : Dialect} {UT : Dialect.baseType d}: ToString (Goedel.toType UT) := 
  match d with
  | Dialect.InstCombine => match UT with
    | InstCombine.BaseType.bitvec w => 
      ⟨fun x? => match x? with 
        | none => "none" 
        | some x => Std.Format.pretty (Bitvec.instReprBitvec w |>.reprPrec x 0)
      ⟩

instance {d : Dialect} {UT : SSA.UserType (Dialect.baseType d)} : ToString (SSA.UserType.toType UT) where
  toString := match UT with
    | SSA.UserType.base _ => Dialect.instToStringToTypeBaseTypeInstGoedelBaseType.toString
    | _ => fun _ => "unimplemented"

end Dialect