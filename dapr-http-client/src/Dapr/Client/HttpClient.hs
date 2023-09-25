{-# LANGUAGE TypeFamilies #-}
{-# OPTIONS_GHC -Wno-orphans #-}

-- |
-- Module      : Dapr.Client.HttpClient
-- Description :
-- Copyright   : (c)
-- License     : Apache-2.0
module Dapr.Client.HttpClient
  (
    withDaprHttpClient,
    -- module Req,
    -- module Configuration,
    -- module DistributedLock,
    -- module Health,
    -- module Metadata,
    -- module PubSub,
    -- module Secrets,
    -- module ServiceInvocation,
    -- module StateManagement,
    -- module OutputBinding,
    -- module Types,
    -- module Actor,
    -- runDaprHttpClient,
  )
where

-- import Dapr.Client.HttpClient.Actor as Actor
-- import Dapr.Client.HttpClient.Configuration as Configuration
-- import Dapr.Client.HttpClient.DistributedLock as DistributedLock
-- import Dapr.Client.HttpClient.Health as Health
-- import Dapr.Client.HttpClient.Metadata as Metadata
-- import Dapr.Client.HttpClient.OutputBinding as OutputBinding
-- import Dapr.Client.HttpClient.PubSub as PubSub
-- import Dapr.Client.HttpClient.Req as Req
-- import Dapr.Client.HttpClient.Secrets as Secrets
-- import Dapr.Client.HttpClient.ServiceInvocation as ServiceInvocation
-- import Dapr.Client.HttpClient.StateManagement as StateManagement

import Network.HTTP.Req (runReq, Req, HttpConfig)
import Dapr.Core.Types
import Dapr.Core.DaprClient
import Dapr.Client.HttpClient.Core
import Dapr.Client.HttpClient.ServiceInvocation (invokeServiceImpl)

withDaprHttpClient :: forall a. HttpConfig -> DaprConfig -> (DaprHttpClient -> Req a) -> IO a
withDaprHttpClient httpConfig config f = runReq httpConfig $ f (DaprHttpClient config)

instance DaprClient DaprHttpClient where
  type CustomMonad DaprHttpClient = Req
  invokeService = invokeServiceImpl
