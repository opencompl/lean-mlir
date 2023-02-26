import Aesop

namespace Hoare

abbrev Val := Nat

structure NamedVal where
  name : String
  val : Val

abbrev Env := String → Option Nat
abbrev TopM := StateT Env Option


inductive Expr
| const (n : Nat) : Expr
| var (x : String) : Expr
| add (e₁ e₂ : Expr) : Expr
| sub (e₁ e₂ : Expr) : Expr
| mul (e₁ e₂ : Expr) : Expr
| div (e₁ e₂ : Expr) : Expr

def Expr.eval (env: Env): Expr → Option Val
| (Expr.const n) => pure n
| (Expr.var x) => do
  env x
| (Expr.add e₁ e₂) => do
  let v₁ ← Expr.eval env e₁
  let v₂ ← Expr.eval env e₂
  pure (v₁ + v₂)
| (Expr.sub e₁ e₂) => do
  let v₁ ← Expr.eval env e₁
  let v₂ ← Expr.eval env e₂
  pure (v₁ - v₂)
| (Expr.mul e₁ e₂) => do
  let v₁ ← Expr.eval env e₁
  let v₂ ← Expr.eval env e₂
  pure (v₁ * v₂)
| (Expr.div e₁ e₂) => do
  let v₁ ← Expr.eval env e₁
  let v₂ ← Expr.eval env e₂
  if v₂ = 0 then
    .none
  else
    pure (v₁ / v₂)


inductive Command
| skip: Command
| assign (x : String) (e : Expr) : Command
| seq (c₁ c₂ : Command) : Command
| if_ (e : Expr) (c₁ c₂ : Command) : Command


def TopM.updateEnv (f : Env → Env) : TopM Unit := do
  let env ← get
  let env' := f env
  set env'

def Env.set (nv: NamedVal) (env: Env) : Env :=
  fun x => if x = nv.name then nv.val else env x

theorem Env.get_set_eq (env: Env) (n: String) (v: Nat): (Env.set ⟨n, v⟩ env) n = .some v :=
  by simp[Env.set]

theorem Env.get_set_neq (env: Env)
  (lookupk setk: String) (NEQ: lookupk ≠ setk)
  (v: Nat): (Env.set ⟨setk, v⟩ env) lookupk = env lookupk := by {
    simp[Env.set];
    rw[if_neg NEQ];
  }

def Command.exec : Command → TopM Unit
| Command.skip => return ()
| (Command.assign x e) => do
  let v ← Expr.eval (← get) e
  TopM.updateEnv (Env.set ⟨x, v⟩)
| (Command.seq c₁ c₂) => do
  Command.exec c₁
  (Command.exec c₂)
| (Command.if_ e c₁ c₂) => do
  let v ← Expr.eval (← get) e
  if v = 0 then Command.exec c₂ else Command.exec c₁



def assertion  := Env → Prop

def hoare_triple (P: assertion) (c: Command) (Q: assertion) : Prop :=
  ∀ (env: Env), P env → ∃ st , c.exec.run env = .some ⟨(), st⟩ ∧ Q st

-- weakest precondition
def Command.wp (Q: assertion): Command → assertion
| Command.skip => Q
| (Command.assign x e) => fun env => ∃ v, Expr.eval env e = .some v ∧ Q (env.set ⟨x, v⟩)
| (Command.seq c₁ c₂) =>
    let wp2 := c₂.wp Q
    let wp1 := c₁.wp wp2
    wp1
| (Command.if_ e c₁ c₂) =>
  fun env => ∃ v, Expr.eval env e = .some v ∧
  (if v = 0 then Command.wp Q c₂ else Command.wp Q c₁) env


def assertion.implies (P Q: assertion) : Prop := ∀ env, P env → Q env

/-
Prove that the weakest precondition is a precondition.
-/
theorem Command.wp.skip.is_precondition:
  ∀ (Q: assertion), hoare_triple (Command.skip.wp Q) Command.skip Q := by {
    intros Q;
    simp[hoare_triple, wp, exec, pure, StateT.run, StateT.pure];
}

theorem Command.wp.assign.is_precondition:
  ∀ {c: Command} {name: String} {val: Expr} {C: c = Command.assign name val}
    {Q: assertion}, hoare_triple (c.wp Q) c Q := by {
    intros c name expr C Q;
    simp[C];
    simp[hoare_triple, wp, exec, pure, StateT.run, StateT.pure];
    intros env expr_val EXPR_VAL Qenv';
    simp[get, getThe, MonadStateOf.get, StateT.get, bind, StateT.bind, pure, liftM, monadLift, MonadLift.monadLift,
      StateT.lift];
    exists (Env.set { name := name, val := expr_val } env);
    simp[Qenv'];
    exists (expr_val, env);
    simp[EXPR_VAL];
    simp[TopM.updateEnv, set, StateT.set, StateT.run, StateT.pure, bind, StateT.bind, pure, liftM, monadLift, MonadLift.monadLift,
      StateT.lift, get, getThe, MonadStateOf.get, StateT.get];
}


theorem Command.wp.is_precondition:
  ∀ (Q: assertion) (c: Command), hoare_triple (c.wp Q) c Q := by {

    intros Q c;
    revert Q;
    induction c;
    case skip => {
      intros Q;
      apply Command.wp.skip.is_precondition;
    }
    case assign x e => {
      intros Q;
      apply Command.wp.assign.is_precondition (C := rfl)
    }
    case seq c1 c2 IH1 IH2 => {
      simp[wp];
      intros Q;
      simp[hoare_triple, exec, pure, StateT.run, StateT.pure] at *;
      intros env Penv;
      simp[get, getThe, MonadStateOf.get, StateT.get, bind, StateT.bind, pure, liftM, monadLift, MonadLift.monadLift,
        StateT.lift];
      simp[hoare_triple] at IH1;
      specialize (IH1 _ _ Penv);
      have ⟨st', EXEC_C1, Pst'⟩ := IH1;
      specialize (IH2 _ _ Pst');
      have ⟨st'', EXEC_C2, Qst''⟩ := IH2;
      exists st'';
      simp[EXEC_C1, EXEC_C2];
      exact Qst'';
    }
    case if_ e c1 c2 IH1 IH2 => {
      intros Q;
      simp[hoare_triple, exec, pure, StateT.run, StateT.pure] at *;
      intros env Penv;
      simp[get, getThe, MonadStateOf.get, StateT.get, bind, StateT.bind, pure, liftM, monadLift, MonadLift.monadLift,
        StateT.lift];
      simp[wp] at Penv;
      have ⟨eval, EVAL, Penv'⟩ := Penv;
      by_cases (eval = 0);
      case pos EVAL_0 => {
        simp[EVAL];
        simp[EVAL_0] at *;
        apply IH2;
        exact Penv';
      }
      case neg EVAL_0 => {
        simp[EVAL];
        simp[EVAL_0] at *;
        apply IH1;
        exact Penv';
      }
    }
  }

-- strongest postcondition
def Command.sp (P: assertion): Command → assertion
| Command.skip => P
| (Command.assign x e) => fun env =>
      ((e.eval env).isSome = True) ->
          ∃ oldv, let oldenv := env.set ⟨x, oldv⟩; P oldenv /\ e.eval env = .some oldv
| (Command.seq c₁ c₂) =>
    let sp1 := c₁.sp P
    let sp2 := c₂.sp sp1
    sp2
| (Command.if_ e c₁ c₂) =>
  fun env => ∃ v,
    (Expr.eval env e = .some v ∧
      (v = 0 ∧ Command.sp P c₁ env) ∨ (v ≠ 0 ∧ Command.sp P c₂ env))


theorem Command.sp.skip.is_postcondition:
  ∀ (P: assertion), hoare_triple P Command.skip (Command.skip.sp P) := by {
    intros P;
    simp[hoare_triple, sp, exec, pure, StateT.run, StateT.pure];
}

/-
TODO: how to prove strongest post-condition for assignment?
-/
theorem Command.sp.assign.is_postcondition:
  ∀ {c: Command} {name: String} {val: Expr} {C: c = Command.assign name val}
    {P: assertion}, hoare_triple P c (c.sp P) := by {
    intros c name expr C P;
    simp[C];
    simp[hoare_triple, sp, exec, pure, StateT.run, StateT.pure];
    intros env Penv;
    simp[get, getThe, MonadStateOf.get, StateT.get, bind, StateT.bind, pure, liftM, monadLift, MonadLift.monadLift,
      StateT.lift];
    simp[sp] at Penv;
    simp[TopM.updateEnv, set, StateT.set, StateT.run, StateT.pure, bind, StateT.bind, pure, liftM, monadLift, MonadLift.monadLift,
      StateT.lift, get, getThe, MonadStateOf.get, StateT.get];
    cases EXPR_VAL:(Expr.eval env expr);
    case none => {
      simp[EXPR_VAL];
      contradiction;
    }
}

theorem Command.sp.is_postcondition:
  ∀ (P: assertion) (c: Command), hoare_triple P c (c.sp P) := by { sorry }

structure Rewrite where
  find: Command
  replace : Command
  correct: ∀ (post: assertion), (replace.sp (find.wp post)).implies post


def rewriteSubSubXEqZero : Rewrite :=
  {
    find := Command.assign "out" (Expr.sub (Expr.var "y") (Expr.var "y")),
    replace := Command.assign "out" (Expr.const 0),
    correct := fun post => by {
      simp[Command.wp, Command.sp, assertion.implies];
      intros env;
      intros ENV_EVAL_0;
      simp[Expr.eval] at ENV_EVAL_0;
      have ⟨y_val, ⟨zerov, ZEROVAL⟩, ENV_EVAL_0'⟩ := ENV_EVAL_0;
      clear ENV_EVAL_0;
      simp[Env.set] at ZEROVAL;
      sorry

    }
  }

end Hoare