-- |
-- Module      : Dapr.Client.HttpClient.ServiceInvocation
-- Description : Lets you perform service invocations
-- Copyright   : (c)
-- License     : Apache-2.0
-- This module lets you perform service invocations
module Dapr.Client.HttpClient.ServiceInvocation where

import Dapr.Client.HttpClient.Internal
import Dapr.Client.HttpClient.Core
import Dapr.Core.Types
import Data.Bifunctor (bimap)
import Data.CaseInsensitive (CI (original))
import Data.Text.Encoding (decodeUtf8, encodeUtf8)
import Network.HTTP.Req
import Network.HTTP.Types (hContentType)
import qualified Network.HTTP.Types.Method as Network
import Data.ByteString.Lazy ( ByteString )
import Data.Text (Text)

-- | Invoke a method on a remote dapr app
invokeServiceImpl :: DaprHttpClient -> InvokeRequest -> Req (Either DaprClientError InvokeResponse)
invokeServiceImpl client InvokeRequest {..} = do
  let url = ["invoke", getAppId invokeRequestAppId, "method"] <> invokeRequestEndpoint
      options = maybe mempty (header (original hContentType) . encodeUtf8) invokeRequestContentType <> mapQueryToParam invokeRequestQueryString
  response <- makeHttpRequest' invokeRequestHttpMethod url invokeRequestData options
  return $ bimap DaprHttpException getInvokeResponse response
  where
    getInvokeResponse :: LbsResponse -> InvokeResponse
    getInvokeResponse response =
      let content = responseBody response
          contentType = responseHeader response (original hContentType)
       in InvokeResponse content (maybe "text/plain" decodeUtf8 contentType)

    makeHttpRequest' :: Network.StdMethod -> [Text] -> ByteString -> Option 'Http -> Req (Either HttpException LbsResponse)
    makeHttpRequest' Network.CONNECT url _ options = makeHttpRequest client CONNECT url NoReqBody lbsResponse options
    makeHttpRequest' Network.DELETE url _ options = makeHttpRequest client DELETE url NoReqBody lbsResponse options
    makeHttpRequest' Network.GET url _ options = makeHttpRequest client GET url NoReqBody lbsResponse options
    makeHttpRequest' Network.HEAD url _ options = makeHttpRequest client HEAD url NoReqBody lbsResponse options
    makeHttpRequest' Network.OPTIONS url _ options = makeHttpRequest client OPTIONS url NoReqBody lbsResponse options
    makeHttpRequest' Network.PATCH url _ options = makeHttpRequest client PATCH url NoReqBody lbsResponse options
    makeHttpRequest' Network.POST url body options = makeHttpRequest client POST url (ReqBodyLbs body) lbsResponse options
    makeHttpRequest' Network.PUT url body options = makeHttpRequest client PUT url (ReqBodyLbs body) lbsResponse options
    makeHttpRequest' Network.TRACE url _ options = makeHttpRequest client TRACE url NoReqBody lbsResponse options
