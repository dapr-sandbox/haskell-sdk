{-# LANGUAGE RecordWildCards #-}
module Dapr.Client.GrpcClient where

import Dapr.Core.Types
import Dapr.Core.DaprClient
import Dapr.Client.GrpcClient.Core
import Dapr.Client.GrpcClient.Internal
import Network.GRPC.HighLevel.Client
import Network.GRPC.HighLevel.Generated
import Network.GRPC.LowLevel.Call (Endpoint(..))
import Data.String (fromString)

withDaprGrpcClient :: DaprConfig -> (DaprGrpcClient -> IO a) -> IO a
withDaprGrpcClient daprConfig f = withGRPCClient clientConfig $ \client -> do
  DaprService{..} <- daprClient client
  f DaprGrpcClient

  where
    endpoint = show (daprHost daprConfig) ++ ":" ++ show (daprPort daprConfig)

    clientConfig :: ClientConfig
    clientConfig = ClientConfig { clientServerEndpoint = Endpoint $ fromString endpoint
                                , clientArgs = []
                                , clientSSLConfig = Nothing
                                , clientAuthority = Nothing
                                }
