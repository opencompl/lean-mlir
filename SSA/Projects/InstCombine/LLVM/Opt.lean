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

def runMainCmd2 (args : Cli.Parsed) : IO UInt32 := do
  let fileName := args.positionalArg! "file" |>.as! String
  let icom? ← parseComFromFile fileName
  match icom? with
    | none => return 1
    | some (Sigma.mk _Γ icom) => do
    let icom'' := icom.snd.snd
    if args.hasFlag "verbose" then
      IO.println "Flag `--verbose` was set."
      IO.println s!"{repr icom''}"
      return 0
    if args.hasFlag "passriscv64" then
      IO.println s!"{repr icom''}"
      return 0
    else
      IO.println s!"{repr icom}"
      return 0

def mainCmd := `[Cli|
    opt VIA runMainCmd2;
    "opt: apply verified rewrites"
    FLAGS:
      verbose; "Declares a flag `--verbose`. This is the description of the flag."
      passriscv64; "Declares a flag `--pass-riscv64`. This applies a lowering pass to RISC-V 64"
    ARGS:
      file: String; "Input filename"
    ]

def main (args : List String): IO UInt32 :=
  mainCmd.validate args
