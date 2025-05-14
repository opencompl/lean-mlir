import SSA.Projects.InstCombine.LLVM.Parser
import Cli

def runMainCmd (args : Cli.Parsed) : IO UInt32 := do
  let fileName := args.positionalArg! "file" |>.as! String
  let icom? ← parseComFromFile fileName
  match icom? with
    | none => return 1
    | some (Sigma.mk _Γ ⟨_eff, ⟨_retTy, c⟩⟩) => do
      IO.println s!"OK: parsed"
      IO.println s!"{toString c}"
      return 0

def mainCmd := `[Cli|
    opt VIA runMainCmd;
    "opt: apply verified rewrites"
    ARGS:
      file: String; "Input filename"
    ]

def main (args : List String): IO UInt32 :=
  mainCmd.validate args
