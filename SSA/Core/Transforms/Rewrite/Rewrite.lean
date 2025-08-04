import SSA.Core.Framework
import SSA.Core.Transforms.Rewrite.Match

/-!
# Peephole Rewriter

This file defines the rewrite procedure which apply a peephole rewrite at a location
previously matched by `matchVar` and co.

-/
set_option deprecated.oldSectionVars true

open Ctxt (Var VarSet Valuation)

variable {d} [DialectSignature d] [TyDenote d.Ty] [DialectDenote d] [Monad d.m]
variable [DecidableEq d.Ty] [DecidableEq d.Op]
variable [∀ (t : d.Ty), Inhabited (toType t)]

/-!
## Program Splitting
-/

/-- `splitProgramAtAux pos lets prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAtAux : (pos : ℕ) → (lets : Lets d Γ₁ eff Γ₂) →
    (prog : Com d Γ₂ eff t) →
    Option (Σ (Γ₃ : Ctxt d.Ty), Lets d Γ₁ eff Γ₃ × Com d Γ₃ eff t × (t' : d.Ty) × Var Γ₃ t')
  | 0, lets, .var e body => some ⟨_, .var lets e, body, _, Var.last _ _⟩
  | _, _, .ret _ => none
  | n+1, lets, .var e body =>
    splitProgramAtAux n (lets.var e) body

theorem denote_splitProgramAtAux [LawfulMonad d.m] : {pos : ℕ} → {lets : Lets d Γ₁ eff Γ₂} →
    {prog : Com d Γ₂ eff t} →
    {res : Σ (Γ₃ : Ctxt d.Ty), Lets d Γ₁ eff Γ₃ × Com d Γ₃ eff t × (t' : d.Ty) × Var Γ₃ t'} →
    (hres : res ∈ splitProgramAtAux pos lets prog) →
    (s : Valuation Γ₁) →
    (res.2.1.denote s) >>= res.2.2.1.denote  = (lets.denote s) >>= prog.denote
  | 0, lets, .var e body, res, hres, s => by
    obtain rfl := by
      simpa only [splitProgramAtAux, Option.mem_def, Option.some.injEq] using hres
    simp only [Lets.denote, bind_assoc, pure_bind, Com.denote_var]
  | _+1, _, .ret _, res, hres, s => by
    simp [splitProgramAtAux, Option.mem_def] at hres
  | n+1, lets, .var e body, res, hres, s => by
    rw [splitProgramAtAux] at hres
    simp [denote_splitProgramAtAux hres s]

-- TODO: have `splitProgramAt` return a `Zipper`
/-- `splitProgramAt pos prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAt (pos : ℕ) (prog : Com d Γ₁ eff t) :
    Option (Σ (Γ₂ : Ctxt d.Ty), Lets d Γ₁ eff Γ₂ × Com d Γ₂ eff t × (t' : d.Ty) × Var Γ₂ t') :=
  splitProgramAtAux pos .nil prog

theorem denote_splitProgramAt [LawfulMonad d.m] {pos : ℕ} {prog : Com d Γ₁ eff t}
    {res : Σ (Γ₂ : Ctxt d.Ty), Lets d Γ₁ eff Γ₂ × Com d Γ₂ eff t × (t' : d.Ty) × Var Γ₂ t'}
    (hres : res ∈ splitProgramAt pos prog) (s : Valuation Γ₁) :
     (res.2.1.denote s) >>= res.2.2.1.denote = prog.denote s := by
  simp [denote_splitProgramAtAux hres s]

/-
  ## Rewriting
-/

/-- `rewriteAt lhs rhs hlhs pos target`, searches for `lhs` at position `pos` of
`target`. If it can match the variables, it inserts `rhs` into the program
with the correct assignment of variables, and then replaces occurences
of the variable at position `pos` in `target` with the output of `rhs`.  -/
def rewriteAt (lhs rhs : Com d Γ₁ .pure t₁)
    (hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : Com d Γ₂ eff t₂) :
    Option (Com d Γ₂ eff t₂) := do
  let ⟨Γ₃, targetLets, target', t', vm⟩ ← splitProgramAt pos target
  if h : t₁ = t'
  then
    let flatLhs := lhs.toFlatCom
    let m ← matchVarMap targetLets vm flatLhs.lets (flatLhs.ret.cast h)
      (by subst h; exact hlhs)
    let zip : Zipper .. := ⟨targetLets, target'⟩;
    let zip := zip.insertPureCom vm (h ▸ rhs.changeVars m)
    return zip.toCom
  else none

@[simp] lemma Com.denote_toFlatCom_lets [LawfulMonad d.m] (com : Com d Γ .pure t) :
    com.toFlatCom.lets.denote = com.denoteLets := by
  funext Γv; simp [toFlatCom, Com.denoteLets_eq]

@[simp] lemma Com.toFlatCom_ret [LawfulMonad d.m] (com : Com d Γ .pure t) :
    com.toFlatCom.ret = com.returnVar := by
  simp [toFlatCom]

theorem denote_rewriteAt [LawfulMonad d.m]
    {lhs rhs : Com d Γ₁ .pure t₁}
    (hl : lhs.denote = rhs.denote)
    {hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars}
    {pos : ℕ} {target : Com d Γ₂ eff t₂}
    {rew : Com d Γ₂ eff t₂}
    (hrew : rew ∈ rewriteAt lhs rhs hlhs pos target) :
    rew.denote = target.denote := by
  funext V
  simp only [rewriteAt, Com.toFlatCom_ret, Option.pure_def, Option.bind_eq_bind, Option.mem_def,
    Option.bind_eq_some_iff, Option.dite_none_right_eq_some, Option.some.injEq, Sigma.exists,
    Prod.exists] at hrew
  rcases hrew with ⟨Γ', lets', com', t', v', h_split, rfl, varMap', hmap, rfl⟩
  simp only [Var.cast_rfl] at *
  suffices
    (do
      let V_mid ← lets'.denote V
      com'.denote
      <| V_mid.reassignVar v'
        <| lhs.toFlatCom.lets.denote (V_mid.comap varMap') lhs.returnVar
    ) = lets'.denote V >>= com'.denote
  by
    simpa [Zipper.denote_insertPureCom, hl, denote_splitProgramAt h_split]

  simp only [lets'.denote_eq_denoteIntoSubtype, bind_map_left]
  simp [denote_matchLets_of_matchVarMap hmap]

variable (d : Dialect) [DialectSignature d] [TyDenote d.Ty] [DialectDenote d] [Monad d.m] in
/--
  Rewrites are indexed with a concrete list of types, rather than an (erased) context, so that
  the required variable checks become decidable
-/
structure PeepholeRewrite (Γ : List d.Ty) (t : d.Ty) where
  lhs : Com d (.ofList Γ) .pure t
  rhs : Com d (.ofList Γ) .pure t
  correct : lhs.denote = rhs.denote

instance {Γ : List d.Ty} {t' : d.Ty} {lhs : Com d (.ofList Γ) .pure t'} :
    Decidable (∀ (t : d.Ty) (v : Var (.ofList Γ) t), ⟨t, v⟩ ∈ lhs.vars) :=
  decidable_of_iff
    (∀ (i : Fin Γ.length),
      let v : Var (.ofList Γ) (Γ.get i) := ⟨i, by simp⟩
      ⟨_, v⟩ ∈ lhs.vars) <|  by
  constructor
  · intro h t v
    rcases v with ⟨i, hi⟩
    try simp only [Erased.out_mk] at hi
    rcases List.getElem?_eq_some_iff.1 hi with ⟨h', rfl⟩
    simp at h'
    convert h ⟨i, h'⟩
  · intro h i
    apply h

def rewritePeepholeAt (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂ eff t₂) :
    (Com d Γ₂ eff t₂) := if hlhs : ∀ t (v : Var (.ofList Γ) t), ⟨_, v⟩ ∈ pr.lhs.vars then
      match rewriteAt pr.lhs pr.rhs hlhs pos target
      with
        | some res => res
        | none => target
      else target

variable [LawfulMonad d.m] [QPF d.m] [UniformQPF d.m]
theorem denote_rewritePeepholeAt (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂  eff t₂) :
    (rewritePeepholeAt pr pos target).denote = target.denote := by
    simp only [rewritePeepholeAt]
    split_ifs
    · split
      · apply denote_rewriteAt pr.correct; assumption
      · rfl
    · rfl

/-- info: 'denote_rewritePeepholeAt' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms denote_rewritePeepholeAt

/- repeatedly apply peephole on program. -/
section SimpPeepholeApplier

/-- rewrite with `pr` to `target` program, at location `ix` and later, running
at most `fuel` steps. -/
def rewritePeephole_go (fuel : ℕ) (pr : PeepholeRewrite d Γ t)
    (ix : ℕ) (target : Com d Γ₂ eff t₂) : (Com d Γ₂ eff t₂) :=
  match fuel with
  | 0 => target
  | fuel' + 1 =>
     let target' := rewritePeepholeAt pr ix target
     rewritePeephole_go fuel' pr (ix + 1) target'

/-- rewrite with `pr` to `target` program, running at most `fuel` steps. -/
def rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) : (Com d Γ₂ eff t₂) :=
  rewritePeephole_go fuel pr 0 target

/-- `rewritePeephole_go` preserve semantics -/
theorem denote_rewritePeephole_go (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂ eff t₂) :
    (rewritePeephole_go fuel pr pos target).denote = target.denote := by
  induction fuel generalizing pr pos target
  case zero =>
    simp [rewritePeephole_go]
  case succ fuel' hfuel =>
    simpa [rewritePeephole_go, hfuel] using denote_rewritePeepholeAt ..

/-- `rewritePeephole` preserves semantics. -/
theorem denote_rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) :
    (rewritePeephole fuel pr target).denote = target.denote := by
  exact denote_rewritePeephole_go ..

/-- info: 'denote_rewritePeephole' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms denote_rewritePeephole

variable {d : Dialect} [DialectSignature d] [DecidableEq (Dialect.Ty d)] [DecidableEq (Dialect.Op d)]
[TyDenote d.Ty] [DialectDenote d] [Monad d.m] in
/--  rewrite with the list of peephole optimizations `prs` at the `target` program, at location `ix`
and later, running at most `fuel` steps. -/
def multiRewritePeepholeAt (fuel : ℕ) (prs : List (Σ Γ, Σ ty, PeepholeRewrite d Γ ty))
    (ix : ℕ) (target : Com d Γ₂ eff t₂) : Com d Γ₂ eff t₂ :=
  match fuel with
  | 0 => target
  | fuel' + 1 =>
    let target' := prs.foldl (fun acc ⟨_Γ, _ty, pr⟩ => rewritePeepholeAt pr ix acc) target
    multiRewritePeepholeAt fuel' prs (ix + 1) target'

variable {d : Dialect} [DialectSignature d] [DecidableEq (Dialect.Ty d)] [DecidableEq (Dialect.Op d)]
[TyDenote d.Ty] [DialectDenote d] [Monad d.m] in
/-- rewrite with the list of peephole optimizations `prs` at the `target` program, running at most
`fuel` steps starting at location 0. -/
def multiRewritePeephole (fuel : ℕ)
    (prs : List (Σ Γ, Σ ty, PeepholeRewrite d Γ ty)) (target : Com d Γ₂ eff t₂) : (Com d Γ₂ eff t₂) :=
  multiRewritePeepholeAt fuel prs 0 target

/-- helper lemma for the proof of `denote_rewritePeephole_go_multi`. It proofs that folding
a list of semantics preserving peephole rewrites over the target program does preserve the semantics
of the target program. -/
lemma denote_foldl_rewritePeepholeAt
  (prs : List (Σ Γ, Σ ty, PeepholeRewrite d Γ ty)) (ix : ℕ) (target : Com d Γ₂ eff t₂) :
    (prs.foldl (fun acc ⟨_Γ, _ty, pr⟩=> rewritePeepholeAt pr ix acc) target).denote = target.denote := by
  induction prs generalizing target
  case nil =>
    simp
  case cons prog rest ih =>
    let ⟨Γ, ty, pr⟩ := prog
    simp only [List.foldl]
    have h : (rewritePeepholeAt pr ix target).denote = target.denote :=
      denote_rewritePeepholeAt pr ix target
    let mid := rewritePeepholeAt pr ix target
    have h' := ih mid
    rw [←h'] at h
    exact h

/- The proof that applying `rewritePeephole_go_multi` preserves the semantics of the target program
to which the peephole rewrites get applied. -/
theorem denote_multiRewritePeepholeAt (fuel : ℕ)
  (prs : List (Σ Γ, Σ ty, PeepholeRewrite d Γ ty)) (ix : ℕ) (target : Com d Γ₂ eff t₂) :
    (multiRewritePeepholeAt fuel prs ix target).denote = target.denote := by
  induction fuel generalizing prs ix target
  case zero =>
    simp [multiRewritePeepholeAt]
  case succ hp =>
    simpa [multiRewritePeepholeAt, hp] using denote_foldl_rewritePeepholeAt ..

/- The proof that `rewritePeephole_multi` is semantics preserving  -/
theorem denote_multiRewritePeephole (fuel : ℕ)
  (prs : List (Σ Γ, Σ ty, PeepholeRewrite d Γ ty)) (target : Com d Γ₂ eff t₂) :
    (multiRewritePeephole fuel prs target).denote = target.denote := by
  exact denote_multiRewritePeepholeAt ..

theorem Expr.denote_eq_of_region_denote_eq {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (eff' : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (DialectSignature.sig op))
    (regArgs regArgs' : HVector (fun t => Com d t.1 EffectKind.impure t.2)
      (DialectSignature.regSig op))
    (hregArgs' : regArgs'.denote = regArgs.denote) :
  (Expr.mk op ty_eq eff' args regArgs').denote = (Expr.mk op ty_eq eff' args regArgs).denote := by
  funext Γv
  cases eff
  case pure =>
    subst ty_eq
    have heff' : DialectSignature.effectKind op = EffectKind.pure := by simp [eff']
    simp [Expr.denote, hregArgs']
  case impure =>
    subst ty_eq
    simp [Expr.denote, hregArgs']

mutual

def rewritePeepholeRecursivelyRegArgs (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) {ts :  List (Ctxt d.Ty × d.Ty)}
    (args : HVector (fun t => Com d t.1 EffectKind.impure t.2) ts)
    : { out : HVector (fun t => Com d t.1 EffectKind.impure t.2) ts // out.denote = args.denote} :=
  match ts with
  | .nil =>
    match args with
    | .nil => ⟨HVector.nil, rfl⟩
  | .cons .. =>
    match args with
    | .cons (a := a) (as := as) com coms =>
      let ⟨com', hcom'⟩ := rewritePeepholeRecursively fuel pr com
      let ⟨coms', hcoms'⟩ := (rewritePeepholeRecursivelyRegArgs fuel pr coms)
      ⟨.cons com' coms', by simp [hcom', hcoms']⟩
termination_by (fuel, ts.length + 2)

def rewritePeepholeRecursivelyExpr (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) {ty : d.Ty}
    (e : Expr d Γ₂ eff ty) : { out : Expr d Γ₂ eff ty // out.denote = e.denote } :=
  match e with
  | Expr.mk op ty eff' args regArgs =>
    let ⟨regArgs', hregArgs'⟩ := rewritePeepholeRecursivelyRegArgs fuel pr regArgs
    ⟨Expr.mk op ty eff' args regArgs', by
      apply Expr.denote_eq_of_region_denote_eq op ty eff' args regArgs regArgs' hregArgs'⟩
termination_by (fuel + 1, 0)

/-- A peephole rewriter that recurses into regions, allowing
peephole rewriting into nested code. -/
def rewritePeepholeRecursively (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) :
    { out : Com d Γ₂ eff t₂ // out.denote = target.denote } :=
  match fuel with
  | 0 => ⟨target, rfl⟩
  | fuel + 1 =>
    let target' := rewritePeephole fuel pr target
    have htarget'_denote_eq_htarget : target'.denote = target.denote := by
      apply denote_rewritePeephole
    match htarget : target' with
    | .ret v => ⟨target', by
      simp [htarget, htarget'_denote_eq_htarget]⟩
    | .var (α := α) e body =>
      let ⟨e', he'⟩ := rewritePeepholeRecursivelyExpr fuel pr e
      let ⟨body', hbody'⟩ :=
        -- decreases because 'body' is smaller.
        rewritePeepholeRecursively fuel pr body
      ⟨.var e' body', by
        rw [← htarget'_denote_eq_htarget]
        simp [he', hbody']⟩
termination_by (fuel, 1)

end

/--
info: 'rewritePeepholeRecursively' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms rewritePeepholeRecursively

end SimpPeepholeApplier
