/-
Implement abstractions for loading IRs at runtime from the 
frontend.

Author: Andres Goens, Siddharth Bhat
-/

import SSA.Core.WellTypedFramework

/--
Structure used to parse IRs from the command line and run
user defined programs.
-/
structure IRMetadata : Type 1 where 
  name : String
  opType : Type 
  baseType : Type
  goedelBaseType : Goedel baseType
  typedUserSemantics : SSA.TypedUserSemantics opType baseType 

open Lean 

builtin_initialize irMetadataExt : TagDeclarationExtension ←
  mkTagDeclarationExtension -- (name := `ir_metadata)

builtin_initialize
  registerBuiltinAttribute {
    name  := `ir_metadata
    descr := "tag instances of `SSA.IR.IRMetadata` for parsing and printing support from the frontend."
    add   := fun declName stx kind => do
      Attribute.Builtin.ensureNoArgs stx
      -- unless kind == AttributeKind.global do throwError "invalid attribute 'cpass', must be global"
      modifyEnv <| irMetadataExt.tag (declName := declName)
  }
