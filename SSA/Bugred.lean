/-
A file used purely for bug reduction
-/
import Mathlib.Algebra.Group

namespace BoringKleisli

abbrev Val := Nat
abbrev Env := Nat → Nat
abbrev TopM := (ReaderT Env (Except String))

instance : LawfulMonad TopM := sorry

def repeatM: Nat → (Val → TopM Val) → Val → TopM Val
| 0, _ => pure
| .succ n, f => f >=> repeatM n f

#print mul_left_comm

theorem repeatM.peel_left: ∀ (n: Nat) (f: Val → TopM Val),
  repeatM (n+1) f = f >=> repeatM n f := by {
  intros n f;
  induction n <;> funext <;>
    simp[Bind.kleisliRight, bind, ReaderT.bind,
          repeatM];
}

-- kleisli arrow is associative.
theorem kleisliRight.assoc {m: Type → Type}
  [M: Monad m] [LM: LawfulMonad m]
  {α β γ δ: Type}
  (f: α → m β) (g: β → m γ) (h: γ → m δ) :
  (f >=> g) >=> h = f >=> (g >=> h) := by {
  funext x;
  simp[Bind.kleisliRight];
}

-- pure is left identity
@[simp]
theorem kleisliRight.pure_id_left {m: Type → Type}
  [M: Monad m] [LM: LawfulMonad m]
  {α β: Type}
  (f: α → m β) :
  pure >=> f = f := by {
  funext x;
  simp[Bind.kleisliRight];
}

-- pure is left identity
@[simp]
theorem kleisliRight.pure_id_right {m: Type → Type}
  [M: Monad m] [LM: LawfulMonad m]
  {α β: Type}
  (f: α → m β) :
  f >=> pure = f:= by {
  funext x;
  simp[Bind.kleisliRight];
}

-- The above shows that (>=>, pure) forms a category.

-- repeatM commutes with f;
theorem repeatM.commute_f: ∀ (n: Nat) (f: Val → TopM Val),
  repeatM n f >=> f = f >=> repeatM n f := by {
  intros n;
  induction n;
  case zero => {
    intros f; funext x env;
    simp[repeatM, pure, ReaderT.pure, Except.pure,
     Bind.kleisliRight, bind, ReaderT.bind, Except.bind];
     cases H:( f x env) <;> simp;
  }
  case succ n' IH => {
    intros f;
    rw[repeatM.peel_left];
    rw[kleisliRight.assoc];
    rw[IH];
  }
}

-- repeatM allows an 'f' to be extracted to the right.
theorem repeatM.peel_right: ∀ (n: Nat) (f: Val → TopM Val),
  repeatM (n+1) f = repeatM n f >=> f := by {
  intros n;
  induction n <;> intros f;
  case zero => {
    funext x env;
    simp[repeatM, pure, ReaderT.pure, Except.pure,
     Bind.kleisliRight, bind, ReaderT.bind, Except.bind];
     cases (f x env) <;> simp
  }
  case succ m IH => {
    simp;
    rw[IH];
    rw[repeatM.peel_left]
    rw[IH];
    rw[repeatM.commute_f];
    rw[kleisliRight.assoc];
    rw[repeatM.commute_f];
  }
}

-- composing repeatM is the same as adding the repeat
-- counter.
theorem repeatM.compose (f: Val → TopM Val) (n : Nat) :
  ∀ (m: Nat),
  (repeatM n f) >=> (repeatM m f) = repeatM (n+m) f := by {
  induction n;
  case zero => {
  intros m; simp[repeatM];
  }
  case succ n' IH => {
    intros m;
    rw[repeatM.peel_left];
    rw[kleisliRight.assoc];
    rw[IH];
    rw[<- repeatM.peel_left];
    suffices : n' + m + 1 = Nat.succ n' + m;
    simp[this];
    linarith;
  }
}


-- pull a function that commutes with f to the left of repeatM
@[simp] -- pull simple stuff to the left.
theorem repeatM.commuting_pull_left
  (f: Val → TopM Val) (g: Val → TopM Val)
  (COMMUTES: f >=> g = g >=> f) :
  (repeatM n f) >=> g = g >=> repeatM n f := by {
  induction n;
  case zero => { simp[repeatM]; }
  case succ n' IH => {
    simp[repeatM];
    rw[kleisliRight.assoc];
    rw[IH];
    rw[<- kleisliRight.assoc];
    rw[COMMUTES];
    rw[kleisliRight.assoc];
  }

}

theorem repeatM.commuting_pull_right
  (f: Val → TopM Val) (g: Val → TopM Val)
  (COMMUTES: f >=> g = g >=> f) :
  g >=> (repeatM n f) = repeatM n f >=> g := by {
    simp[repeatM.commuting_pull_left, COMMUTES];
}


-- TODO: decision procedure for free theory of
-- commuting functions?
theorem repeatM.commuting_commute
  (f: Val → TopM Val) (g: Val → TopM Val)
  (COMMUTES: f >=> g = g >=> f) :
  repeatM n f >=> repeatM m g = repeatM m g >=> repeatM n f := by {
    induction n;
    case zero => {
      simp[repeatM];
    }
    case succ n' IH => {
      simp[repeatM];
      rw[kleisliRight.assoc]
      rw[IH];
      rw[<- kleisliRight.assoc]
      rw[repeatM.commuting_pull_right (g := f) (f := g) (n := m)
        (COMMUTES := by simp[COMMUTES])];
      rw[kleisliRight.assoc];
    }
}

-- to show (f >=> k) = (f >=> h), it suffices to show that k = h
theorem kleisli.cancel_left [M: Monad m] (f: α → m β) (k h : β → m γ) (H: k = h) :
  f >=> k = f >=> h := by {
    rw[H];
}

-- Use `match goal` to move terms to the left.
theorem repeatM.commuting_compose
  (f: Val → TopM Val) (g: Val → TopM Val)
  (n: Nat)
  (COMMUTES: f >=> g = g >=> f) :
  (repeatM n f) >=> repeatM n g =
  repeatM n (f >=> g) := by {
  induction n;
  case zero => { simp[repeatM]; }
  case succ n' IH => {
    conv in (_ >=> _) => { repeat rw[repeatM.peel_left]; }
    conv in (f >=> repeatM n' f) >=> g >=> repeatM n' g
    rw[repeatM.peel_left];
  }
  simp[repeatM, COMMUTES];
  case succ n' IH => {
    calc repeatM (Nat.succ n') f >=> repeatM (Nat.succ n') g =
          f >=> repeatM n' f >=> repeatM (Nat.succ n') g  := by {
            simp[repeatM.peel_left];
            simp[kleisliRight.assoc];
          }
    _ = f >=> repeatM n' f >=> g >=> repeatM n' g := by {
          simp[repeatM.peel_left];
    }
    _ = f >=> g >=> repeatM n' f >=> repeatM n' g := by {
      apply kleisli.cancel_left;
      rw[repeatM.commuting_pull_left];
      simp[kleisliRight.assoc];
      apply kleisli.cancel_left;
      apply repeatM.commuting_commute;
      simp[COMMUTES];

    }
    _ = f >=> g >=> repeatM n' (f >=> g) := by {
      simp[IH];
    }
    _ = repeatM (Nat.succ n') (f >=> g) := by {
      simp[<- repeatM.peel_left];
    }


  }
}

end BoringKleisli