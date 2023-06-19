/-
Implement abstractions for loading IRs at runtime from the 
frontend.

Author: Andres Goens, Siddharth Bhat
-/

import SSA.Core.WellTypedFramework

open Lean 

/--
A test case for an IR. This is used to test the IR parser.
-/
structure IRTest where
  name : String
  opType : Type 
  baseType : Type
  goedelBaseType : Goedel baseType
  reprBaseType : Repr baseType
  typedUserSemantics : SSA.TypedUserSemantics opType baseType 
  inputTypeCode : SSA.UserType baseType
  outputTypeCode : SSA.UserType baseType
  reprTypeCode : Repr baseType
  test : ⟦inputTypeCode⟧ → ⟦outputTypeCode⟧ 

def IRTest.ofFun (name : String) (Op : Type)
  [Goedel β] [Repr β] [SSA.TypedUserSemantics Op β] (inputTypeCode : SSA.UserType β)
  (outputTypeCode : SSA.UserType β) (test : ⟦inputTypeCode⟧ → ⟦outputTypeCode⟧) : IRTest where 
  name := name
  opType := Op
  baseType := β
  reprBaseType := inferInstance
  goedelBaseType := inferInstance
  typedUserSemantics := inferInstance
  inputTypeCode := inputTypeCode
  outputTypeCode := outputTypeCode
  test := test