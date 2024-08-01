import Lean

open Lean
open Lean.Meta
open Lean.Elab
open Lean.Elab.Command

-- Function to count declarations and sorries in a given syntax tree
def countDeclsAndSorries (stx : Syntax) : MetaM (Nat × Nat) := do
  let mut declCount := 0
  let mut sorryCount := 0

  -- Helper function to traverse the syntax tree
  let rec traverse (stx : Syntax) : MetaM Unit := do
    if stx.isOfKind `Lean.Parser.Command.declaration then
      let mut declCount := declCount + 1
    if stx.isOfKind `Lean.Parser.Term.sorry then
      let mut sorryCount := sorryCount + 1
    for child in stx.getArgs do
      traverse child

  traverse stx
  return (declCount, sorryCount)

-- Function to analyze a file
def analyzeFile (fileName : String) : IO Unit := do
  let env ← importModules [{ module := `Init }, { module := `Lean }] {}
  let input ← IO.FS.readFile fileName
  let (stx, _) ← Parser.runParserCategory env `command input
  let (declCount, sorryCount) ← MetaM.run' (countDeclsAndSorries stx)
  IO.println s!"Number of declarations: {declCount}"
  IO.println s!"Number of sorries: {sorryCount}"

-- Main function to analyze "addition.lean"
def main : IO Unit := do
  analyzeFile "addition.lean"
