module Dapr.Client.HttpClient.Metadata where

import Control.Monad.IO.Class (MonadIO)
import Dapr.Client.HttpClient.Req
import Dapr.Core.Types
import Data.Bifunctor (bimap)
import Data.Text.Encoding (encodeUtf8)
import Network.HTTP.Req

getMetadata :: MonadIO m => DaprConfig -> m (Either DaprClientError GetMetadataResponse)
getMetadata config = do
  response <- makeHttpRequest config GET ["metadata"] NoReqBody jsonResponse mempty
  return $ bimap DaprHttpException responseBody response

setMetadata :: MonadIO m => DaprConfig -> SetMetadataRequest -> m (Either DaprClientError ())
setMetadata config SetMetadataRequest{..} = do
  let url = ["metadata", key]
      options = header "Content-Type" "text/plain"
  response <- makeHttpRequest config PUT url (ReqBodyBs $ encodeUtf8 value) ignoreResponse options
  return $ bimap DaprHttpException (const ()) response
