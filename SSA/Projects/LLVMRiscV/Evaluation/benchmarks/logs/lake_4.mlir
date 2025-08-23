⚠ [1090/1108] Replayed SSA.Projects.LLVMRiscV.PeepholeRefine
warning: SSA/Projects/LLVMRiscV/PeepholeRefine.lean:57:4: declaration uses 'sorry'
ℹ [1093/1108] Replayed SSA.Projects.LLVMRiscV.Pipeline.sext
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:28:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:48:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:68:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:88:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:108:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:128:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:148:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:168:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sext.lean:188:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
ℹ [1095/1110] Replayed SSA.Projects.LLVMRiscV.Pipeline.urem
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    urem_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    urem_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, urem_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, urem_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          urem_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        urem_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/urem.lean:30:2: final right-hand-side of equality is: Γv
    ⟨1,
      urem_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
ℹ [1096/1110] Replayed SSA.Projects.LLVMRiscV.Pipeline.xor
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    xor_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    xor_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, xor_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, xor_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          xor_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        xor_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/xor.lean:29:2: final right-hand-side of equality is: Γv
    ⟨1,
      xor_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2216/2256] Built SSA.Projects.LLVMRiscV.Pipeline.ReconcileCast (9.6s)
ℹ [2218/2256] Built SSA.Projects.LLVMRiscV.Pipeline.rem (10s)
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    rem_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    rem_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, rem_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, rem_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          rem_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        rem_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/rem.lean:28:101: final right-hand-side of equality is: Γv
    ⟨1,
      rem_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2219/2256] Built SSA.Projects.LLVMRiscV.Pipeline.rem:c.o (1.2s)
ℹ [2220/2256] Built SSA.Projects.LLVMRiscV.Pipeline.srl (13s)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    srl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    srl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, srl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, srl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          srl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        srl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:37:101: final right-hand-side of equality is: Γv
    ⟨1,
      srl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    srl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    srl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, srl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, srl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          srl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        srl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/srl.lean:48:107: final right-hand-side of equality is: Γv
    ⟨1,
      srl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
⚠ [2222/2256] Built SSA.Projects.LLVMRiscV.Pipeline.sdiv (16s)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sdiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sdiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sdiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:27:109: final right-hand-side of equality is: Γv
    ⟨1,
      sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sdiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sdiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sdiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:39:108: final right-hand-side of equality is: Γv
    ⟨1,
      sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sdiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sdiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sdiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sdiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:72:4: final right-hand-side of equality is: Γv
    ⟨1,
      sdiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
warning: SSA/Projects/LLVMRiscV/Pipeline/sdiv.lean:67:4: declaration uses 'sorry'
⚠ [2224/2256] Built SSA.Projects.LLVMRiscV.Pipeline.udiv (16s)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    udiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    udiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          udiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:29:2: final right-hand-side of equality is: Γv
    ⟨1,
      udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    udiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    udiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          udiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:41:2: final right-hand-side of equality is: Γv
    ⟨1,
      udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    udiv_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    udiv_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, udiv_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          udiv_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:70:4: final right-hand-side of equality is: Γv
    ⟨1,
      udiv_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
warning: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:67:4: declaration uses 'sorry'
warning: SSA/Projects/LLVMRiscV/Pipeline/udiv.lean:85:4: declaration uses 'sorry'
ℹ [2226/2256] Built SSA.Projects.LLVMRiscV.Pipeline.and (17s)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:26:101: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:53:100: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:80:100: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:107:104: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    and_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    and_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, and_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          and_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/and.lean:134:104: final right-hand-side of equality is: Γv
    ⟨1,
      and_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
ℹ [2228/2256] Built SSA.Projects.LLVMRiscV.Pipeline.zext (19s)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:26:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:45:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:64:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:83:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:102:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:121:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:140:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:159:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))]) (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/zext.lean:178:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
✔ [2229/2256] Built SSA.Projects.LLVMRiscV.Pipeline.zext:c.o (1.1s)
ℹ [2230/2256] Built SSA.Projects.LLVMRiscV.Pipeline.or (22s)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:30:107: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:45:109: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:71:110: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:86:112: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:112:110: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:126:112: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:152:106: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    or_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    or_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, or_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          or_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/or.lean:166:108: final right-hand-side of equality is: Γv
    ⟨1,
      or_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
ℹ [2232/2256] Built SSA.Projects.LLVMRiscV.Pipeline.ashr (25s)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:35:110: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:39:107: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:74:113: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:78:110: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:112:113: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:116:110: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:150:109: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    ashr_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    ashr_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, ashr_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          ashr_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/ashr.lean:154:106: final right-hand-side of equality is: Γv
    ⟨1,
      ashr_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
ℹ [2234/2256] Built SSA.Projects.LLVMRiscV.Pipeline.select (28s)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨4,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨4,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨4,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨4,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    ⟨4,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨3,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨3,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨3,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨3,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:47:68: final right-hand-side of equality is: Γv
    ⟨3,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨4,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨4,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨4,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨4,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    ⟨4,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨3,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨3,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨3,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨3,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:77:70: final right-hand-side of equality is: Γv
    ⟨3,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨4,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨4,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨4,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨4,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    ⟨4,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨3,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨3,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨3,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨3,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:107:70: final right-hand-side of equality is: Γv
    ⟨3,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨4,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨4,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨4, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨4,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨4,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    ⟨4,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨2, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨6, select_riscv._proof_4⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨3,
    select_riscv._proof_4⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨3,
    select_riscv._proof_4⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨3, select_riscv._proof_4⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨3,
          select_riscv._proof_4⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨3,
        select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/select.lean:137:68: final right-hand-side of equality is: Γv
    ⟨3,
      select_riscv._proof_4⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2235/2256] Built SSA.Projects.LLVMRiscV.Pipeline.select:c.o (1.2s)
ℹ [2236/2256] Built SSA.Projects.LLVMRiscV.Pipeline.sub (29s)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv
      RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv
      RISCV64.Ty.bv)), Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))]) (Ty.riscv RISCV64.Ty.bv)))
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))]) (Ty.riscv RISCV64.Ty.bv)))
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv
            RISCV64.Ty.bv))::ₕΓv
          (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv
          RISCV64.Ty.bv))::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:31:91: final right-hand-side of equality is: Γv
    (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv
        RISCV64.Ty.bv))::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last (↑[Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:54:108: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:67:104: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:78:104: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:89:108: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:120:111: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:133:107: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:144:107: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:155:111: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:183:111: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:196:107: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:207:107: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    sub_riscv_self._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    sub_riscv_self._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, sub_riscv_self._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          sub_riscv_self._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/sub.lean:218:111: final right-hand-side of equality is: Γv
    ⟨1,
      sub_riscv_self._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
ℹ [2238/2256] Built SSA.Projects.LLVMRiscV.Pipeline.mul (29s)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:48:108: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:52:107: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:56:110: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:60:110: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:108:111: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:112:110: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:116:113: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:120:113: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:168:111: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:172:110: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:176:112: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:180:113: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:228:107: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:232:106: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:236:108: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/mul.lean:240:109: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, mul_riscv._proof_3⟩::ₕHVector.nil)
✔ [2239/2256] Built SSA.Projects.LLVMRiscV.Pipeline.mul:c.o (369ms)
ℹ [2240/2256] Built SSA.Projects.LLVMRiscV.Pipeline.shl (31s)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:50:100: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:54:104: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:58:104: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:62:108: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:111:103: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:115:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:119:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:123:111: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:172:104: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:176:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:180:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:184:111: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:233:100: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:237:103: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:241:103: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    shl_riscv._proof_2⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    shl_riscv._proof_2⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, shl_riscv._proof_2⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          shl_riscv._proof_2⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/shl.lean:245:107: final right-hand-side of equality is: Γv
    ⟨1,
      shl_riscv._proof_2⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
✔ [2241/2256] Built SSA.Projects.LLVMRiscV.Pipeline.shl:c.o (387ms)
✖ [2242/2256] Building SSA.Projects.LLVMRiscV.Pipeline.add (32s)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/add.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/add.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/add.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/add.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/add.setup.json --json
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:54:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:59:110: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:64:110: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:68:114: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:122:112: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:127:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:132:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:136:117: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:189:112: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:194:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:199:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:203:117: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 16))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:256:108: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:261:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:266:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:270:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 8))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:324:108: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:329:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:334:109: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    add_riscv._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    add_riscv._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, add_riscv._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          add_riscv._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/add.lean:338:113: final right-hand-side of equality is: Γv
    ⟨1,
      add_riscv._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
warning: SSA/Projects/LLVMRiscV/Pipeline/add.lean:364:4: declaration uses 'sorry'
error: SSA/Projects/LLVMRiscV/Pipeline/add.lean:393:38: INTERNAL ERROR : While trying to transform from MLIR AST to dialect specific AST
         the transformation failed. The errors thrown are:
          s!Unsupported type and s!Unsupported type
error: SSA/Projects/LLVMRiscV/Pipeline/add.lean:408:13: INTERNAL ERROR : While trying to transform from MLIR AST to dialect specific AST
         the transformation failed. The errors thrown are:
          s!Unsupported type and s!Unsupported type
error: SSA/Projects/LLVMRiscV/Pipeline/add.lean:401:70: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/add.lean:401:70: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: Lean exited with code 1
ℹ [2244/2256] Built SSA.Projects.LLVMRiscV.Pipeline.icmp (32s)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:32:4: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:61:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:83:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:105:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:126:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:147:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:169:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:191:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:212:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:233:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:255:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:277:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:298:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:319:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:341:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:363:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:390:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (HVector.nil : [])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:412:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid HVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:435:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 64))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩ : RISCV64.Ty.bv) (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  ⟨1,
    icmp_ugt_riscv_i64._proof_3⟩, Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: built proof riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩)
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        ⟨1,
          icmp_ugt_riscv_i64._proof_3⟩::ₕΓv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil) =
  (Γv
      ⟨1,
        icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
      (Γv
          (Ctxt.Var.last
            (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
                Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
            (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: final right-hand-side of equality is: Γv
    ⟨1,
      icmp_ugt_riscv_i64._proof_3⟩::ₕriscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: found (llvmArgsFromHybrid (HVector.cons (Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)) : RISCV64.Ty.bv) (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil : [RISCV64.Ty.bv])
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: calling riscvArgsFromHybrid_cons_eq.lemma with RISCV64.Ty.bv, [RISCV64.Ty.bv], Γv
  (Ctxt.Var.last
    (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
        Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
    (Ty.riscv RISCV64.Ty.bv)), Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: XXXX
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: YYYY
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: built proof riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: reduced proof to riscvArgsFromHybrid_cons_eq.lemma
  (Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv)))
  (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: reduced type of proof (i.e. the equality) to riscvArgsFromHybrid
    (Γv
        (Ctxt.Var.last
          (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
              Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
          (Ty.riscv RISCV64.Ty.bv))::ₕΓv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil) =
  (Γv
      (Ctxt.Var.last
        (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
            Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
        (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil))
info: SSA/Projects/LLVMRiscV/Pipeline/icmp.lean:458:2: final right-hand-side of equality is: Γv
    (Ctxt.Var.last
      (↑[Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv, Ty.riscv RISCV64.Ty.bv,
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32)),
          Ty.llvm (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 32))])
      (Ty.riscv RISCV64.Ty.bv))::ₕriscvArgsFromHybrid (Γv ⟨1, icmp_ugt_riscv_i64._proof_3⟩::ₕHVector.nil)
✔ [2245/2256] Built SSA.Projects.LLVMRiscV.Pipeline.icmp:c.o (534ms)
✖ [2246/2256] Building SSA.Projects.LLVMRiscV.Pipeline.pseudo (1.6s)
trace: .> LEAN_PATH=/home/lc985/lean-mlir/.lake/packages/batteries/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Qq/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/aesop/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/proofwidgets/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/importGraph/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/plausible/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/mathlib/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/Cli/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/packages/leanwuzla/.lake/build/lib/lean:/home/lc985/lean-mlir/.lake/build/lib/lean /home/lc985/.elan/toolchains/leanprover--lean4-nightly---nightly-2025-08-06/bin/lean --tstack=400000 /home/lc985/lean-mlir/SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean -o /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/pseudo.olean -i /home/lc985/lean-mlir/.lake/build/lib/lean/SSA/Projects/LLVMRiscV/Pipeline/pseudo.ilean -c /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/pseudo.c --setup /home/lc985/lean-mlir/.lake/build/ir/SSA/Projects/LLVMRiscV/Pipeline/pseudo.setup.json --json
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:22:8: unexpected identifier; expected 'const', 'li', 'llvm.icmp', 'llvm.mlir.constant', 'llvm.select', InstCombine.cmp_op_name, InstCombine.int_cast_op, MLIR.Pretty.RV.opWithImmediate, MLIR.Pretty.RV.opWithShamt, MLIR.Pretty.disjoint_op, MLIR.Pretty.exact_op, MLIR.Pretty.nneg_op, MLIR.Pretty.overflow_int_cast_op, MLIR.Pretty.overflow_op, MLIR.Pretty.uniform_op or string literal
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:28:33: Unknown identifier `icmp_eq_riscv_i64_pseudo`
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:28:2: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:28:2: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:36:8: unexpected identifier; expected 'const', 'li', 'llvm.icmp', 'llvm.mlir.constant', 'llvm.select', InstCombine.cmp_op_name, InstCombine.int_cast_op, MLIR.Pretty.RV.opWithImmediate, MLIR.Pretty.RV.opWithShamt, MLIR.Pretty.disjoint_op, MLIR.Pretty.exact_op, MLIR.Pretty.nneg_op, MLIR.Pretty.overflow_int_cast_op, MLIR.Pretty.overflow_op, MLIR.Pretty.uniform_op or string literal
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:42:33: Unknown identifier `icmp_eq_riscv_i32_pseudo`
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:42:2: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:42:2: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:51:8: unexpected identifier; expected 'const', 'li', 'llvm.icmp', 'llvm.mlir.constant', 'llvm.select', InstCombine.cmp_op_name, InstCombine.int_cast_op, MLIR.Pretty.RV.opWithImmediate, MLIR.Pretty.RV.opWithShamt, MLIR.Pretty.disjoint_op, MLIR.Pretty.exact_op, MLIR.Pretty.nneg_op, MLIR.Pretty.overflow_int_cast_op, MLIR.Pretty.overflow_op, MLIR.Pretty.uniform_op or string literal
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:57:34: Unknown identifier `icmp_ne_riscv_i64_pseudo`
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:57:2: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:57:2: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:65:8: unexpected identifier; expected 'const', 'li', 'llvm.icmp', 'llvm.mlir.constant', 'llvm.select', InstCombine.cmp_op_name, InstCombine.int_cast_op, MLIR.Pretty.RV.opWithImmediate, MLIR.Pretty.RV.opWithShamt, MLIR.Pretty.disjoint_op, MLIR.Pretty.exact_op, MLIR.Pretty.nneg_op, MLIR.Pretty.overflow_int_cast_op, MLIR.Pretty.overflow_op, MLIR.Pretty.uniform_op or string literal
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:71:34: Unknown identifier `icmp_ne_riscv_i32_pseudo`
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:71:2: could not synthesize default value for field 'correct' of 'LLVMPeepholeRewriteRefine' using tactics
error: SSA/Projects/LLVMRiscV/Pipeline/pseudo.lean:71:2: None of the hypotheses are in the supported BitVec fragment after applying preprocessing.
There are three potential reasons for this:
1. If you are using custom BitVec constructs simplify them to built-in ones.
2. If your problem is using only built-in ones it might currently be out of reach.
   Consider expressing it in terms of different operations that are better supported.
3. The original goal was reduced to False and is thus invalid.
error: Lean exited with code 1
Some required targets logged failures:
- SSA.Projects.LLVMRiscV.Pipeline.add
- SSA.Projects.LLVMRiscV.Pipeline.pseudo
error: build failed
