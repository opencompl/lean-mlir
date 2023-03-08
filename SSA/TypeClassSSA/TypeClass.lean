structure SSA : Type 1 :=
  ( Kind : Type )
  ( Context : Type )
  ( Expr : Context → Kind → Type )
  ( Var : Context → Kind → Type )
  ( Decl : Kind → Type )
  ( snoc : Context → Kind → Context )
  ( Var0 : ∀ {Γ : Context} {k : Kind}, Var (snoc Γ k) k )
  ( VarS : ∀ {Γ : Context} {k k' : Kind}, Var Γ k → Var (snoc Γ k') k )
  ( ret : ∀ {Γ : Context} {k : Kind}, Var Γ k → Expr Γ k )
  ( lett : ∀ {Γ : Context} {k : Kind},  )



