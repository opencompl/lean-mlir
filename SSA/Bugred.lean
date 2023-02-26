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

/-
Hoare triple assering partial correctness.
If the environment satisfies P and then program
runs successfully, then the final environment satisfies Q.
-/
def hoare_triple (P: assertion) (c: Command) (Q: assertion) : Prop :=
  ∀ (env: Env), P env →
    match (c.exec.run env) with
    | .none => True
    | .some ((), st) => Q st

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
    simp[EXPR_VAL];
    simp[TopM.updateEnv, set, StateT.set, StateT.run, StateT.pure, bind, StateT.bind, pure, liftM, monadLift, MonadLift.monadLift,
      StateT.lift, get, getThe, MonadStateOf.get, StateT.get];
    simp[Qenv'];
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
      simp[Option.bind];
      cases H: (exec c1 env);
      case none => {
        simp[H] at *;
      }
      case some unit_st => {
        have (unit, st) := unit_st;
        simp at *;
        simp[H] at IH1;
        specialize (IH2 _ _ IH1);
        exact IH2;
      }
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
| (Command.assign x e) => fun newenv =>
      ∃ (oldv : Option Nat),
      let oldenv : Env := fun (key :String) => if key = x
                          then oldv
                          else newenv key;
                          P oldenv /\ e.eval oldenv = newenv x
| (Command.seq c₁ c₂) =>
    let sp1 := c₁.sp P
    let sp2 := c₂.sp sp1
    sp2
| (Command.if_ e c₁ c₂) =>
  fun env => ∃ v,
    Expr.eval env e = .some v ∧ -- this is wrong, we should talk about the old environment! Jesus.
      (if v = 0 then Command.sp P c₂ env else Command.sp P c₁ env )


theorem Command.sp.skip.is_postcondition:
  ∀ (P: assertion), hoare_triple P Command.skip (Command.skip.sp P) := by {
    intros P;
    simp[hoare_triple, sp, exec, pure, StateT.run, StateT.pure];
}


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
    }
    case some val => {
      simp[EXPR_VAL];
      simp[Penv];
      let oldval := env name;
      exists oldval;
      suffices (fun key => if key = name then oldval else Env.set { name := name, val := val } env key) = env by {
        rw[this];
        simp[Penv, EXPR_VAL, Env.set];
      }
      funext needle;
      by_cases NEEDLE:needle = name <;> simp[Env.set, NEEDLE];
    }
}

theorem Command.sp.is_postcondition:
  ∀ (P: assertion) (c: Command), hoare_triple P c (c.sp P) := by {

    intros P c;
    revert P;
    induction c;
    case skip => {
      intros P;
      apply Command.sp.skip.is_postcondition;
    }
    case assign x e => {
      intros P;
      apply Command.sp.assign.is_postcondition (C := rfl)
    }
    /- Wow, copilot auto-generated the 'seq' case! -/
    case seq c1 c2 IH1 IH2 => {
      simp[sp];
      intros P;
      simp[hoare_triple, exec, pure, StateT.run, StateT.pure] at *;
      intros env Penv;
      simp[get, getThe, MonadStateOf.get, StateT.get, bind, StateT.bind, pure, liftM, monadLift, MonadLift.monadLift,
        StateT.lift];
      simp[hoare_triple] at IH1;
      specialize (IH1 _ _ Penv);
      simp[Option.bind];
      cases H: (exec c1 env);
      case none => {
        simp[H] at *;
      }
      case some unit_st => {
        have (unit, st) := unit_st;
        simp at *;
        simp[H] at IH1;
        specialize (IH2 _ _ IH1);
        exact IH2;
      }
    }
    case if_ e c1 c2 IH1 IH2 => {
      intros Q;
      simp[sp];
      simp[hoare_triple, exec, pure, StateT.run, StateT.pure] at *;
      intros env Qenv;
      simp[get, getThe, MonadStateOf.get, StateT.get, bind, StateT.bind, pure, liftM, monadLift, MonadLift.monadLift,
        StateT.lift];
      simp[wp] at Qenv;
      simp[Option.bind];
      cases EVAL: (Expr.eval env e) <;> simp[EVAL];
      case some val => {
        simp at *;
        by_cases (val = 0);
        case pos EVAL_0 => {
          simp[EVAL_0];
          cases C2VAL : (exec c2 env) <;> simp;
          case some unit_and_env' => {
              have (unit, env') := unit_and_env';
              specialize (IH2 _ _ Qenv);
              simp[C2VAL] at IH2;
              simp;
              exists val;
              simp[EVAL];
          }
        }
        case neg EVAL_1 => {
          simp[EVAL_1];
          cases C1VAL : (exec c1 env) <;> simp;
          case some unit_and_e1val => {
              have (unit, e1val) := unit_and_e1val;
              specialize (IH1 _ _ Qenv);
              simp[C1VAL] at IH1;
              simp;
              exact Exists.mk e1val IH1;
          }
        }
    }
  }
}

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