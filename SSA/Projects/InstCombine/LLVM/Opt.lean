import SSA.Projects.InstCombine.LLVM.Parser
import Cli

def runMainCmd (args : Cli.Parsed) : IO UInt32 := do
  let fileName := args.positionalArg! "file" |>.as! String
  let icom? ← parseComFromFile fileName
  match icom? with
    | none => return 1
    | some (Sigma.mk _Γ icom) => do
      let icom'' := icom.snd.snd
      let icom_output := (icom'')
      IO.println s!"OK: parsed"
      IO.println s!"{repr icom_output}"
      return 0
def mainCmd := `[Cli|
    opt VIA runMainCmd;
    "opt: apply verified rewrites"
    ARGS:
      file: String; "Input filename"
    ]

def main (args : List String): IO UInt32 :=
  mainCmd.validate args
