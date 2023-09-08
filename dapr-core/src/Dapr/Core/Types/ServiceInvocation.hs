-- |
-- Module      : Dapr.Core.Types.ServiceInvocation
-- Description : Defines the types used by ServiceInvocation module
-- Copyright   : (c)
-- License     : Apache-2.0
-- Defines the types used by ServiceInvocation module.
module Dapr.Core.Types.ServiceInvocation where

import Dapr.Core.Types.Common (AppId)
import qualified Data.ByteString.Lazy as L
import Data.Text (Text)
import Network.HTTP.Types ( Query, StdMethod )

-- | 'InvokeServiceRequest' represents the request message for Service invocation.
data InvokeRequest = InvokeRequest
  { -- | Callee's app id.
    invokeRequestAppId :: AppId,

    -- | Http method, POST, PUT, GET, DELETE, etc
    invokeRequestHttpMethod :: StdMethod,

    -- | The path which will be invoked by caller.
    --
    -- >>> ["api", "method"] => /api/method
    invokeRequestEndpoint :: [Text],

    -- | The message which will be delivered to callee.
    invokeRequestData :: L.ByteString,

    -- | The type of data content.
    invokeRequestContentType :: Maybe Text,

    -- | Optional, query string
    invokeRequestQueryString :: Query
  }

-- | 'InvokeResponse' represents the response of Service invocation.
data InvokeResponse = InvokeResponse
  { -- | Response data as byte string
    invokeResponseData :: L.ByteString,
    -- | The content type of response data
    invokeResponseContentType :: Text
  }
