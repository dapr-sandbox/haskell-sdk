{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}

module Dapr.Client.GrpcClient.Core where

import Dapr.Core.Types
import Dapr.Core.DaprClient ( DaprClient(..) )
import Dapr.Client.GrpcClient.Internal ( DaprService(..) )
import Dapr.Client.GrpcClient.Utils (mapHttpMethodToHttpVerb)
import qualified Dapr.Proto.Runtime.V1.Dapr as Proto
import qualified Dapr.Proto.Common.V1.Common as Proto
import qualified Google.Protobuf.Any as GoogleProto
import Network.GRPC.HighLevel.Client
    ( ClientRequest (ClientNormalRequest), ClientResult (..) )
import qualified Proto3.Suite.Class as HsProtobuf
import qualified Proto3.Suite.Types as HsProtobuf
import qualified Data.Text.Lazy as LT
import qualified Data.Text.Encoding as T
import qualified Data.ByteString.Lazy as LB
import Network.HTTP.Types (renderQuery)
import Data.Maybe (fromMaybe)
import Network.GRPC.HighLevel (StatusCode(..))

newtype DaprGrpcClient = DaprGrpcClient
  { daprService :: DaprService ClientRequest ClientResult
  }

instance DaprClient DaprGrpcClient where
  type CustomMonad DaprGrpcClient = IO
  invokeService (DaprGrpcClient DaprService{..}) appId request =
    let endpoint = LT.intercalate "/" $ map LT.fromStrict (invokeRequestEndpoint request)
        query = LT.fromStrict $ T.decodeUtf8 $ renderQuery False (invokeRequestQueryString request)
        data' = GoogleProto.Any "" (LB.toStrict $ invokeRequestData request)
        contentType = maybe "" LT.fromStrict (invokeRequestContentType request)
        httpExtension = Just $ Proto.HTTPExtension (mapHttpMethodToHttpVerb $ invokeRequestHttpMethod request) query
        invokeRequest' = Proto.InvokeRequest endpoint (Just data') contentType httpExtension
    in
      daprInvokeService (ClientNormalRequest (Proto.InvokeServiceRequest (LT.fromStrict (getAppId appId)) (Just invokeRequest')) 10 mempty) >>= \case
      ClientNormalResponse rsp _ _ StatusOk _ -> rsp
      ClientNormalResponse _ _ _ st _ -> fail $ "Got unexpected status " ++ show st ++ " from call, expecting StatusOk"
      ClientErrorResponse e           -> fail $ "Got client error: " ++ show e
