{-# LANGUAGE DataKinds, TypeOperators, TypeFamilies, GADTs, StandaloneDeriving #-}

import GHC.TypeLits
import Data.Type.Set

type instance Cmp (Natural n) (Natural m) = CmpNat n m

data Natural (a :: Nat) where
    Z :: Natural 0
    S :: Natural n -> Natural (n + 1)

deriving instance Show (Natural n)

-- foo :: Set '[Natural 0, Natural 1, Natural 3]
foo = asSet $ Ext (S Z) (Ext (S (S (S Z))) (Ext Z Empty))

-- bar :: Set '[Natural 1, Natural 2]
bar = asSet $ Ext (S (S Z)) (Ext (S Z) (Ext (S Z) Empty))

-- foobar :: Set '[Natural 0, Natural 1, Natural 2, Natural 3]
foobar = foo `union` bar
