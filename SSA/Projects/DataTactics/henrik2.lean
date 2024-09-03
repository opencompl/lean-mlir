import Lean.Meta.Basic
import Batteries.Tactic.OpenPrivate
import SSA.Experimental.Bits.Fast.Tactic
import  SSA.Projects.InstCombine.TacticAuto
import Std.Tactic.BVDecide

open Lean Elab Command Meta Tactic

-- Function to check if a theorem can be solved by `bv_automata`
def checkTactic (tac : TacticM Unit) (env : Environment) (declName : Name) : TermElabM Bool := do
  match env.find? declName with
    | some const =>
      try
        let type := const.type
        let goal ← mkFreshExprMVar type
        let mvarId := goal.mvarId!
        let (_, mvarId) ← mvarId.intros
        let  _ ← Term.withDeclName `declName <| Tactic.run mvarId tac
        let result ← instantiateMVars goal
        return !result.hasMVar
      catch e =>
        logError e.toMessageData
        return false
    | none => throwError "unknown constant"
def works (tac : TacticM Unit) (env : Environment) (moduleName : Name) : TermElabM (Nat × Nat) := do
  let mut solved := 0
  let mut unsolved := 0
  let some moduleIdx := env.getModuleIdx? moduleName | unreachable!
  let moduleData := env.header.moduleData.get! moduleIdx
  for declName in moduleData.constNames do
    -- IO.println declName
    if ← checkTactic tac env declName then
      solved := solved + 1
    else
      unsolved := unsolved + 1
  return (solved, unsolved)

-- Function to analyze all theorems in the environment
unsafe def analyzeTheoremsImpl (tac : TacticM Unit) : CommandElabM (Nat × Nat) := do
  let mut solved := 0
  let mut unsolved := 0
  let modules : Array Name := #[
    `SSA.Projects.InstCombine.tests.LLVM.g2004h02h23hShiftShiftOverflow_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2004h11h22hMissedhandhfold_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2008h02h16hSDivOverflow2_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2008h02h23hMulSub_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2008h05h31hAddBool_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2008h05h31hBools_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2008h07h08hSubAnd_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2008h07h09hSubAndError_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2008h07h11hRemAnd_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2010h11h01hlshrhmask_proof,
    `SSA.Projects.InstCombine.tests.LLVM.g2010h11h23hDistributed_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gadd2_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gadd4_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gaddhmaskhneg_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gaddhmask_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gaddhshift_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gaddhshlhsdivhtohsrem_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gaddnegneg_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gadd_or_sub_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gaddsubhconstanthfolding_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gand2_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gandhorhand_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gandhorhnot_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gandhxorhmerge_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gandhxorhor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gand_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gannotations_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthadd_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthandhorhand_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthandhxorhmerge_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthand_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthmul1_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthmul2_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthnot_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthrem1_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthrem2_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthshifthsimplify_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthshift_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthsub_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthxor1_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gapinthxor2_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gashrhdemand_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gashrhlshr_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gbinophandhshifts_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gbinophofhdisplacedhshifts_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gcanonicalizehashrhshlhtohmasking_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gcanonicalizehlshrhshlhtohmasking_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gcanonicalizehshlhlshrhtohmasking_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gdemand_shrink_nsw_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gdemorgan_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gdistribute_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gdivhi1_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gdivhshift_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gearly_constfold_changes_IR_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gexact_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gfoldhinchofhaddhofhnothxhandhyhtohsubhxhfromhy_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gfoldhsubhofhnothtohinchofhadd_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gfreehinversion_proof,
    `SSA.Projects.InstCombine.tests.LLVM.ggethlowbitmaskhuptohandhincludinghbit_proof,
    `SSA.Projects.InstCombine.tests.LLVM.ghighhbithsignmask_proof,
    `SSA.Projects.InstCombine.tests.LLVM.ghoisthnegationhouthofhbiashcalculationhwithhconstant_proof,
    `SSA.Projects.InstCombine.tests.LLVM.ghoisthnegationhouthofhbiashcalculation_proof,
    `SSA.Projects.InstCombine.tests.LLVM.ghoisthnothfromhashrhoperand_proof,
    `SSA.Projects.InstCombine.tests.LLVM.ghoisthxorhbyhconstanthfromhxorhbyhvalue_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gicmphmulhand_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gicmphmul_proof,
    `SSA.Projects.InstCombine.tests.LLVM.ginverthvariablehmaskhinhmaskedhmergehscalar_proof,
    `SSA.Projects.InstCombine.tests.LLVM.glowhbithsplat_proof,
    `SSA.Projects.InstCombine.tests.LLVM.glshr_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gmaskedhmergehadd_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gmaskedhmergehandhofhors_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gmaskedhmergehor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gmaskedhmergehxor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gmisch2002_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gmul_fold_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gmulhpow2_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gnegatedhbitmask_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gnothadd_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gnot_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gorhshiftedhmasks_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gorhxorhxor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gorhxor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gpr14365_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gpr53357_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gpullhbinophthroughhshift_proof,
    `SSA.Projects.InstCombine.tests.LLVM.greassociatehnuw_proof,
    `SSA.Projects.InstCombine.tests.LLVM.grem_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsdivh1_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsdivhcanonicalize_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsdivhexacthbyhnegativehpowerhofhtwo_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsdivhexacthbyhpowerhofhtwo_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsethlowbitshmaskhcanonicalize_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshifthaddhinseltpoison_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshifthadd_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshifthamounthreassociation_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshifthlogic_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshifthshift_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshifthsra_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshlhbo_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshlhdemand_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshlhfactor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gshlhsub_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsignext_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsremhcanonicalize_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsubhandhorhneghxor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsubhfromhsub_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsubhnot_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsubhofhnegatiblehinseltpoison_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsubhofhnegatible_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsubhorhandhxor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsubhxorhorhneghand_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gsubhxor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gunfoldhmaskedhmergehwithhconsthmaskhscalar_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gxor2_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gxorhofhor_proof,
    `SSA.Projects.InstCombine.tests.LLVM.gxor_proof
  ]
  for moduleName in modules do
    let (solved', unsolved') ← withImportModules #[⟨ moduleName, false⟩ , ⟨ `SSA.Experimental.Bits.Fast.Tactic , false⟩ ] {} 0 <| fun (env : Environment) => do
      let res := works tac env moduleName
      Prod.fst <$> res.run'.toIO { fileName := "fake", fileMap := default } { env := env }
    solved := solved + solved'
    unsolved := unsolved + unsolved'
  return (solved, unsolved)


@[implemented_by analyzeTheoremsImpl]
opaque analyzeTheorems (tactics :  TacticM Unit) : CommandElabM (Nat × Nat)

macro "do_ring": tactic =>
  `(tactic|
      (
        intros
        try simp (config := {failIfUnchanged := false}) [(BitVec.negOne_eq_allOnes)]
        try ring_nf
        try (
            simp only [← BitVec.allOnes_sub_eq_xor]
            simp only [← BitVec.negOne_eq_allOnes]
            ring_nf
        )
      )
   )

macro "bv_ring": tactic =>
  `(tactic|
      (
        simp_alive_undef
        simp_alive_ops
        try (
          simp_alive_case_bash
          ensure_only_goal
        )
        do_ring
      )
   )


-- Command to run the analysis
elab "#analyze_theorems" : command => do
  let (solved, unsolved) ← analyzeTheorems (evalTactic (← `(tactic| bv_automata)))
  logInfo s!"Theorems solved by bv_automata: {solved}"
  logInfo s!"Theorems not solved by bv_automata: {unsolved}"
  let (solved, unsolved) ← analyzeTheorems (evalTactic (← `(tactic| bv_decide)))
  logInfo s!"Theorems solved by bv_decide: {solved}"
  logInfo s!"Theorems not solved by bv_decide: {unsolved}"
  let (solved, unsolved) ← analyzeTheorems (evalTactic (← `(tactic| bv_ring)))
  logInfo s!"Theorems solved by bv_ring: {solved}"
  logInfo s!"Theorems not solved by bv_ring: {unsolved}"
  let (solved, unsolved) ← analyzeTheorems (evalTactic (← `(tactic| alive_auto)))
  logInfo s!"Theorems solved by alive_auto: {solved}"
  logInfo s!"Theorems not solved by alive_auto: {unsolved}"

--  run the analysis
-- #analyze_theorems
