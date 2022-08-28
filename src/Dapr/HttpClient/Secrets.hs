module Dapr.HttpClient.Secrets where

import Dapr.HttpClient.Core
import Dapr.HttpClient.Internal
import Network.HTTP.Req
import RIO

type Secrets = Map Text Text

type BulkSecrets = Map Text Secrets

getSecrets :: MonadIO m => DaprClientConfig -> Text -> Text -> Maybe Metadata -> m (Either DaprClientError Secrets)
getSecrets config store name metadata = do
  let url = ["secrets", store, name]
      options = mapMetadataToQueryParam metadata
  response <- makeRequest config GET url NoReqBody jsonResponse options
  return $ bimap DaprHttpException responseBody response

getBulkSecrets :: MonadIO m => DaprClientConfig -> Text -> Maybe Metadata -> m (Either DaprClientError Secrets)
getBulkSecrets config store metadata = do
  let url = ["secrets", store, "bulk"]
      options = mapMetadataToQueryParam metadata
  response <- makeRequest config GET url NoReqBody jsonResponse options
  return $ bimap DaprHttpException responseBody response