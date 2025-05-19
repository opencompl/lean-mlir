import SSA.Projects.InstCombine.LLVM.Parser
import Cli
-- The import below is needed to access transformation flags for the LLVMAndRiscVhybrid dialect.
import SSA.Projects.LLVMRiscV.ParseAndTransform

/-- `verbose_flag` takes in a filename and assuming the file is wellformed,
 prints verbose output to the command line. Additionally it prints
 a string indicating that the verbose flag was set. If the parsing fails,
 it returns with the exit code of 1 to signalize failure. The exit code 1
 indicates success. -/
def verbose_flag (fileName : String ) : IO UInt32 := do
      let icom? ← parseComFromFile fileName
      match icom? with
      | none => return 1
      | some (Sigma.mk _Γ icom) => do
      IO.println "Flag `--verbose` was set."
      IO.println s!"{repr icom}" -- we print everything, meaning effect, return type and com
      return 0

def wellformed (fileName : String ) : IO UInt32 := do
    let icom? ← parseComFromFile fileName
    match icom? with
    | none => return 1
    | some (Sigma.mk _Γ ⟨_eff, ⟨_retTy, c⟩⟩) => do
      IO.println s!"{toString c}"
      return 0

def runMainCmd (args : Cli.Parsed) : IO UInt32 := do
  let fileName := args.positionalArg! "file" |>.as! String
  if args.hasFlag "verbose" then -- in this case we just mirror the llvm program again and checked that it is wellformed.
    let code ← verbose_flag fileName
    return code
  else
    let code ← wellformed fileName
    return code

def mainCmd := `[Cli|
    opt VIA runMainCmd;
    "opt: apply verified rewrites"
    FLAGS:
      verbose; "Prints verbose output for debugging using the Repr typeclass to print."
    ARGS:
      file: String; "Input filename"
    ]

def main (args : List String): IO UInt32 :=
  mainCmd.validate args
