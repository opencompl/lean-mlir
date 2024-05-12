-- A port of https://github.com/frex-project/haskell-frex to Lean.
import Mathlib.Algebra.Group.Defs
import Mathlib.Data.List.Basic
namespace Printf
-- https://github.com/frex-project/haskell-frex/blob/master/test/Printf.hs

-- test/Printf.hs
-- Data/PartiallyStatic.hs
-- Data.Coproduct
--   Coproduct/Classes.hs
--   Coproduct/Instances.hs

class Format (f : Type → Type → Type) where
  Acc : (α : Type) → Type
  lit : String → f a a
  cat : f b a → f c b → f c a
  int : f a (Acc Int → a)
  str : f a (Acc String → a)
  sprintf : f (Acc String) a → a


/-- Unstaged printf -/
structure Fmt (r : Type) (a : Type) where
  fmt : (String → r) → (String → a)


/-
#  Data/Coproduct/Classes.hs

{-# LANGUAGE MultiParamTypeClasses, UndecidableSuperClasses #-}
{-# LANGUAGE ConstraintKinds, KindSignatures, TypeFamilies #-}

module Data.Coproduct.Classes where

import Data.Kind

{-- The coproduct interface --}
class (algebra α, algebra β, algebra (Coprod algebra α β)) ⇒ Coproduct algebra α β where
   data family Coprod algebra α β :: Type
   inl :: α → Coprod algebra α β
   inr :: β → Coprod algebra α β
   eva :: algebra δ ⇒ (α → δ) → (β → δ) → Coprod algebra α β → δ

{-- Free algebras with variables in var --}
class algebra (FreeA algebra var) ⇒ Free algebra var where
  data family FreeA algebra var :: Type

  pvar :: var → FreeA algebra var
  pbind :: algebra c ⇒ FreeA algebra var → (var → c) → c
-/

set_option checkBinderAnnotations false in
/-- The coproduct of `α` and `β` in the category of `algebra` is `carrier` -/
class Coproduct (algebra : Type → Type) (α β : Type)
    (carrier : outParam Type)  where
  algα : algebra α := by infer_instance
  algβ : algebra β := by infer_instance
  algCarrier : algebra carrier := by infer_instance
  inl : α → carrier
  inr : β → carrier
  eva {δ : Type} [algδ : algebra δ] : (α → δ) → (β → δ) → carrier → δ

set_option checkBinderAnnotations false in
class Free (algebra : Type → Type) (name : Type) (carrier : outParam Type) where -- free algebra with variables in var
  alg : algebra carrier := by infer_instance
  pvar : name → carrier
  pbind {c : Type} [algc: algebra c] : carrier → (name → c) → c



/-
# Data.PartiallyStatic

{-# LANGUAGE ConstraintKinds, FlexibleContexts #-}

module Data.PartiallyStatic where
import Data.Coproduct
import Language.Haskell.TH.Syntax hiding (Code)
import qualified Language.Haskell.TH.Syntax as TH
import Control.Monad (liftM)

type Code a = TH.Code Q a


type FreeExtCon algebra name α =
  Coproduct algebra α (FreeA algebra name) -- the coproduct constraint

sta :: (algebra α, FreeExtCon algebra name α) ⇒
       α → FreeExt algebra name α
sta = inl

-- Free extension
type FreeExt algebra name α =
  Coprod algebra α (FreeA algebra name) -- the data family

dyn :: (Free algebra name, FreeExtCon algebra name α) ⇒
       name → FreeExt algebra name α
dyn = inr . pvar

cd :: (Lift α, Free algebra (Code α), algebra (Code α),
       FreeExtCon algebra (Code α) α) ⇒
      FreeExt algebra (Code α) α → Code α
cd = eva tlift (`pbind` id)

tlift :: Lift α ⇒ α → Code α
tlift = liftCode . liftM TExp . lift
-/

/-- The free extension of an `algebra` structure over `α`,
  with variables indexed by `name` -/
class FreeExt (algebra : Type → Type) (name : Type) (α : Type) (freeExtCarrier : Type) where
  freeCarrier : Type
  [freeInstance : Free algebra name freeCarrier]
  [coprodInstance : Coproduct algebra α freeCarrier freeExtCarrier]

instance [Free algebra name freeCarier]
  [Coproduct algebra α freeCarier freeExtCarrier] :
  FreeExt algebra name α freeExtCarrier where
  freeCarrier := freeCarier


section PartiallyStatic
open Lean Meta

set_option checkBinderAnnotations false in
def sta {algebra : Type → Type} [algebra α]
[FE : FreeExt algebra name α freeExtCarrier] (a : α) : freeExtCarrier :=
  FE.coprodInstance.inl a

def dyn {algebra : Type → Type} [FE : FreeExt algebra name α freeExtCarrier]
(f : name) : freeExtCarrier :=
  FE.coprodInstance.inr (FE.freeInstance.pvar f)

/- A 'MetaM Expr' that produces an Expr of type α -/
-- abbrev Code (α : Type) := MetaM Expr
-- def Code.run {α : Type} (x : Code α) : MetaM Expr := x
-- def Code.mk {α : Type} (x : MetaM Expr) : Code α := x

class ToExprM (α : Type) where
  toExprM : α → MetaM Expr

instance [Lean.ToExpr α] : ToExprM α where
  toExprM := fun a => (pure <| Lean.toExpr a)

-- set_option checkBinderAnnotations false in
def cd {α : Type} {algebra : Type → Type} [ToExprM α]
    -- The below instance is a total hack, we should
    -- actually be saying that 'post evaluation',
    -- it obeys the algebra.
    (AME: algebra (MetaM Expr) := by infer_instance)
    [FE : FreeExt algebra (MetaM Expr) α freeExtCarrier]
    (x : freeExtCarrier) : MetaM Expr :=
  letI := FE.freeInstance
  letI := AME
  FE.coprodInstance.eva (algδ := AME) ToExprM.toExprM
    (fun v => by
      have h := FE.freeInstance.pbind (c := MetaM Expr) (algc := AME)
        v
        id -- WTF, the ENTIRE ABSTRACTION IS USELESS.
      exact h
    )
    x

end PartiallyStatic


/-
# Data/Coproduct/Instances.hs

{-# LANGUAGE GADTs #-}
{-# LANGUAGE DataKinds, ConstraintKinds, KindSignatures #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE MultiParamTypeClasses, FlexibleInstances, TypeFamilies #-}
{-# LANGUAGE PatternGuards #-}

module Data.Coproduct.Instances where
import Data.Coproduct.Classes
import qualified Data.Map as Map
import qualified Data.MultiSet as MultiSet
import qualified Data.Set as Set
import Data.Kind

import Data.CMonoid
import Data.CGroup
import Data.Ring
import Data.BoolRing
import Data.DLattice

-- cf.
-- http://hackage.haskell.org/package/monoid-extras-0.4.2/docs/Data-Monoid-Coproduct.html
-- https://hackage.haskell.org/package/comonad-4.2.7.2/docs/Data-Functor-Coproduct.html
-- https://hackage.haskell.org/package/data-category-0.6.0/docs/Data-Category-Coproduct.html

{-- Coproduct of monoids --}
data AorB = A | B

data Alternate :: AorB → Type → Type → Type where
   Empty :: Alternate any a b
   ConsA :: a → Alternate B a b → Alternate A a b
   ConsB :: b → Alternate A a b → Alternate B a b

instance (Monoid a, Monoid b) ⇒ Coproduct Monoid a b where
   data Coprod Monoid a b where
      M :: Alternate any a b → Coprod Monoid a b

   inl a = M (a `ConsA` Empty)
   inr b = M (b `ConsB` Empty)

   eva (f :: α → δ) (g :: β → δ) (M c) = eva' c
     where eva' :: Alternate start α β → δ
           eva' Empty = mempty
           eva' (a `ConsA` Empty) = f a
           eva' (b `ConsB` Empty) = g b
           eva' (a `ConsA` m) = f a `mappend` eva' m
           eva' (b `ConsB` m) = g b `mappend` eva' m

instance (Monoid α, Monoid β) ⇒ Semigroup (Coprod Monoid α β) where
  M l <> M r = l `mul` r
   where mul :: (Monoid a, Monoid b) ⇒
                 Alternate start a b → Alternate start' a b → Coprod Monoid a b
         l `mul` Empty = M l
         Empty `mul` r = M r
         ConsA a m `mul` r | M m' ← mul m r = M (a `consA` m')
         ConsB b m `mul` r | M m' ← mul m r = M (b `consB` m')

         consA :: Monoid a ⇒ a → Alternate start a b → Alternate A a b
         a `consA` Empty = a `ConsA` Empty
         a `consA` ConsA a' m = (a `mappend` a') `ConsA` m
         a `consA` r@(ConsB _ _) = a `ConsA` r

         consB :: Monoid b ⇒ b → Alternate start a b → Alternate B a b
         b `consB` Empty = b `ConsB` Empty
         b `consB` ConsB b' m =  (b `mappend` b') `ConsB` m
         b `consB` r@(ConsA _ _) = b `ConsB` r



instance (Monoid α, Monoid β) ⇒ Monoid (Coprod Monoid α β) where
  mempty = M Empty
-/

/-
{-- Coproduct of sets --}
class Set a
instance Set a
instance Coproduct Set a b where
  data Coprod Set a b = Inl a | Inr b
    deriving (Show)
  inl = Inl
  inr = Inr
  eva f g (Inl x) = f x ; eva f g (Inr y) = g y

instance Free Set x where
  newtype FreeA Set x = F { unF :: x }
    deriving (Show)
  pvar = F
  F x `pbind` k = k x
-/

class Set (α : Type) where
instance (α : Type) : Set α := ⟨⟩

instance : Coproduct Set α β (Sum α β) where
  inl a := Sum.inl a
  inr b := Sum.inr b
  eva f g x := Sum.casesOn x f g

instance : Free Set x x where
  pvar x := x
  pbind c k := k c


/-
instance (CMonoid a, CMonoid b) ⇒ Coproduct CMonoid a b where
  data Coprod CMonoid a b = C a b

  inl a = C a mempty
  inr b = C mempty b
  eva f g (C a b) = f a `mappend` g b

instance (CMonoid α, CMonoid β) ⇒ CMonoid (Coprod CMonoid α β) where

instance (CMonoid α, CMonoid β) ⇒ Semigroup (Coprod CMonoid α β) where
  C a b <> C a' b' = C (a `mappend` a') (b `mappend` b')

instance (CMonoid α, CMonoid β) ⇒ Monoid (Coprod CMonoid α β) where
  mempty = C mempty mempty
-/

instance [CommMonoid α] [CommMonoid β] : Coproduct CommMonoid α β (α × β) where
  algCarrier := sorry
  inl a := (a, 1)
  inr b := (1, b)
  eva
  | f, g, (a, b) => (f a) * (g b)

instance : Monoid (List x) where
  one := []
  mul := List.append
  one_mul := sorry
  mul_one := sorry
  mul_assoc := sorry


instance : Free Monoid x (List x) where
   pvar x := [x]
   pbind xs f :=
    match xs with
    | [] => 1
    | [x] => f x
    | xs =>  -- TODO: check if this is right.
        List.foldl (fun acc x => acc * (f x)) 1 xs

/-
{-- Coproduct of abelian groups --}
instance (CGroup a, CGroup b) ⇒ Coproduct CGroup a b where
   newtype Coprod CGroup a b = Cg { unCG :: Coprod CMonoid a b }
     deriving (Semigroup, CMonoid, Monoid)
   inl = Cg . inl
   inr = Cg . inr
   eva f g = eva f g . unCG

instance (CGroup α, CGroup β) ⇒ CGroup (Coprod CGroup α β) where
   cinv (Cg (C a b)) = Cg (C (cinv a) (cinv b))

-- Free monoids
instance Free Monoid x where
   newtype FreeA Monoid x = P [x] deriving (Semigroup, Monoid)
   pvar x = P [x]
   P [] `pbind` f = mempty
   P [x] `pbind` f = f x
   P xs `pbind` f = Prelude.foldr (mappend . f) mempty xs

-- Coproduct of commutative rings
instance (Ring α, Ord x) ⇒ Coproduct Ring α (FreeA Ring x) where
  newtype Coprod Ring α (FreeA Ring x) = CR { unCR :: Multinomial x α }
    deriving (Ring)

  inl a = CR (MN (Map.singleton MultiSet.empty a))
  inr (RingA (MN x)) = CR (MN (Map.map initMN x))
  eva f g = evalMN f (g . pvar) . unCR

-- Coproduct of Boolean rings
instance (BoolRing α, Ord x) ⇒ Coproduct BoolRing α (FreeA BoolRing x) where
  newtype Coprod BoolRing α (FreeA BoolRing x) = BR { unBR :: Polynomial x α }
    deriving (Ring, BoolRing)

  inl a = BR (PN (Map.singleton Set.empty a))
  inr (BoolRingA (PN x)) = BR (PN (Map.map initPN x))
  eva f g = evalPN f (g . pvar) . unBR

-- Coproduct of distributive lattices
instance (DLattice α, Ord x) ⇒ Coproduct DLattice α (FreeA DLattice x) where
  newtype Coprod DLattice α (FreeA DLattice x) = DL { unDL :: NormalForm x α }
    deriving (DLattice, Eq)

  inl a = DL (NF (Map.singleton Set.empty a))
  inr (DLatticeA (NF x)) = DL (NF (Map.map initNF x))
  eva f g = evalNF f (g . pvar) . unDL
-/

/-
# Data.Printf

{-# LANGUAGE TypeFamilies #-}
-- selection of sprintf implementation
{-# LANGUAGE PartialTypeSignatures #-}
{-# OPTIONS_GHC -Wno-partial-type-signatures #-}

module Printf where

import Data.PartiallyStatic
import Data.Coproduct
import InstanceLifting()

class Format f where
  type Acc f α :: ★
  lit :: String → f a a
  cat :: f b a → f c b → f c a
  int :: f a (Acc f Int → a)
  str :: f a (Acc f String → a)
  sprintf :: f (Acc f String) a → a

-- unstaged printf
newtype Fmt r a = Fmt {fmt :: (String → r) → (String → a)}

instance Format Fmt where
  type Acc Fmt α = α
  lit x = Fmt $ \k s → k (s ++ x)
  f `cat` g = Fmt (fmt f . fmt g)
  int = Fmt $ \k s x → k (s ++ show x)
  str = Fmt $ \k s x → k (s ++ x)
  sprintf p = fmt p id ""

-- staged printf
newtype FmtS r a = FmtS {fmtS :: (Code String → r) → (Code String → a)}

instance Format FmtS where
  type Acc FmtS α = Code α
  lit x = FmtS $ \k s → k [|| $$s ++ x ||]
  f `cat` g = FmtS (fmtS f . fmtS g)
  int = FmtS $ \k s x → k [|| $$s ++ show $$x ||]
  str = FmtS $ \k s x → k [|| $$s ++ $$x ||]
  sprintf p = fmtS p id [|| "" ||]

-- partially-static printf
newtype FmtPS r a = FmtPS { fmtPS :: (FreeExt Monoid (Code String) String → r) →
                                     (FreeExt Monoid (Code String) String → a) }

instance Format FmtPS where
  type Acc FmtPS α = Code α
  lit x = FmtPS $ \k s → k (s `mappend` sta x)
  f `cat` g = FmtPS (fmtPS f . fmtPS g)
  int = FmtPS $ \k s x → k (s `mappend` dyn [|| show $$x ||])
  str = FmtPS $ \k s x → k (s `mappend` dyn x)
  sprintf (FmtPS p) = p cd mempty

-- partially-static printf with n-ary destructor function
newtype FmtPS2 r a = FmtPS2 { fmtPS2 :: (FreeExt Monoid (Code String) String → r) →
                                        (FreeExt Monoid (Code String) String → a) }

instance Format FmtPS2 where
  type Acc FmtPS2 α = Code α
  lit x = FmtPS2 $ \k s → k (s `mappend` sta x)
  f `cat` g = FmtPS2 (fmtPS2 f . fmtPS2 g)
  int = FmtPS2 $ \k s x → k (s `mappend` dyn [|| show $$x ||])
  str = FmtPS2 $ \k s x → k (s `mappend` dyn x)
  sprintf (FmtPS2 p) = p cdStrings mempty

exampleFmt :: Format f ⇒ f a (Acc f Int → Acc f Int → a)
exampleFmt = (int `cat` lit "a") `cat` (lit "b" `cat` int)

unstagedExample :: Int → Int → String
unstagedExample = sprintf (exampleFmt :: Fmt _ _)

stagedCode :: Code (Int → Int → String)
stagedCode = [|| \x y → $$(sprintf (exampleFmt :: FmtS _ _) [||x||] [||y||]) ||]

psCode :: Code (Int → Int → String)
psCode = [|| \x y → $$(sprintf (exampleFmt :: FmtPS _ _) [||x||] [||y||]) ||]

-- a destructor for strings that generates a single n-ary concatenation
cdStrings :: FreeExt Monoid (Code String) String -> Code String
cdStrings m = [|| Prelude.concat $$(liftList (eva g h m)) ||]
  where g "" = []
        g s = [[||s||]]
        h (P s) = s

liftList :: [Code a] -> Code [a]
liftList [] = [||[]||]
liftList (x:xs) = [||$$x : $$(liftList xs)||]

sprintfN (FmtPS p) = p cdStrings mempty

psCodeN :: Code (Int → Int → String)
psCodeN = [|| \x y → $$(sprintfN exampleFmt [||x||] [||y||]) ||]

benchFmt :: Format f => f c (Acc f String
                          -> Acc f String
                          -> Acc f String
                          -> Acc f String
                          -> Acc f String
                          -> Acc f String
                          -> Acc f String
                          -> Acc f String
                          -> Acc f String
                          -> Acc f String
                          -> c)
benchFmt = (str `cat` lit "," `cat` lit " ")
           `cat`
           (str `cat` lit "," `cat` lit " ")
           `cat`
           (str `cat` lit "," `cat` lit " ")
           `cat`
           (str `cat` lit "," `cat` lit " ")
           `cat`
           (str `cat` lit "," `cat` lit " ")
           `cat`
           (str `cat` lit "," `cat` lit " ")
           `cat`
           (str `cat` lit "," `cat` lit " ")
           `cat`
           (str `cat` lit "," `cat` lit " ")
           `cat`
           (str `cat` lit "," `cat` lit " ")
           `cat`
           str
-/
end Printf
