{-# LANGUAGE TypeFamilies #-}

module Dapr.Core.DaprClient where

import Dapr.Core.Types
import Data.Kind (Type)

class DaprClient client where
  type CustomMonad client :: Type -> Type
  invokeService :: client -> InvokeRequest -> CustomMonad client (Either DaprClientError InvokeResponse)
