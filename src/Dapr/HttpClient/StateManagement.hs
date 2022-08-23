{-# LANGUAGE DataKinds #-}
{-# LANGUAGE RecordWildCards #-}

module Dapr.HttpClient.StateManagement where

import Dapr.HttpClient.Core
import Data.Aeson (FromJSON, KeyValue ((.=)), ToJSON (toJSON), object, eitherDecode, Value (..))
import Network.HTTP.Req
import RIO
import RIO.Map (foldlWithKey)
import qualified Data.Text as T

data ConcurrencyMode = FirstWrite | LastWrite deriving (Eq)

instance Show ConcurrencyMode where
  show FirstWrite = "first-write"
  show LastWrite = "last-write"

instance ToJSON ConcurrencyMode where
  toJSON = Data.Aeson.String . T.pack . show

data ConsistencyMode = Strong | Eventual deriving (Eq)

instance Show ConsistencyMode where
  show Strong = "strong"
  show Eventual = "eventual"

instance ToJSON ConsistencyMode where
  toJSON = Data.Aeson.String . T.pack . show

data SaveStateOptions = SaveStateOptions
  { ssoConcurrency :: Text,
    ssoConsistency :: ConsistencyMode
  }
  deriving (Eq, Show)

instance ToJSON SaveStateOptions where
  toJSON SaveStateOptions {..} =
    object
      [ "concurrency" .= ssoConcurrency,
        "consistency" .= ssoConsistency
      ]

data SaveStateReqBody a = SaveStateReqBody
  { ssrKey :: Text,
    ssrValue :: a,
    ssrEtag :: Maybe Text,
    ssrOptions :: Maybe SaveStateOptions,
    ssrMetadata :: Maybe (Map Text Text)
  }
  deriving (Eq, Show, Generic)

instance ToJSON a => ToJSON (SaveStateReqBody a) where
  toJSON (SaveStateReqBody k v etag opts meta) =
    object
      [ "key" .= k,
        "value" .= v,
        "etag" .= etag,
        "options" .= opts,
        "metadata" .= meta
      ]

mkSimleSaveStateReqBody :: Text -> a -> SaveStateReqBody a
mkSimleSaveStateReqBody key value = SaveStateReqBody key value Nothing Nothing Nothing

saveState :: (MonadIO m, ToJSON a) => DaprClientConfig -> Text -> [SaveStateReqBody a] -> m (Either Text ())
saveState config store body = do
  let url = "state/" <> store
      options = header "Content-Type" "application/json"
  response <- makeRequest config POST url (ReqBodyJson body) ignoreResponse options
  case responseStatusCode response of
    204 -> return $ Right ()
    400 -> return $ Left "State store is missing or misconfigured or malformed request"
    500 -> return $ Left "Failed to save state"
    _ -> return $ Left "Unknown response status code"

saveSingleState :: (MonadIO m, ToJSON a) => DaprClientConfig -> Text -> SaveStateReqBody a -> m (Either Text ())
saveSingleState config store body = saveState config store [body]

getState :: (MonadIO m, FromJSON a) => DaprClientConfig -> Text -> Text -> Maybe ConsistencyMode -> Maybe (Map Text Text) -> m (Either Text a)
getState config store key consistency metadata = do
  let url = "state" <> "/" <> store <> "/" <> key
      metadataQuery = maybe mempty (foldlWithKey (\query key' value -> query <> key' =: Just value) mempty) metadata
      options = metadataQuery <> "consistency" =: (show <$> consistency)
  response <- makeRequest config GET url NoReqBody lbsResponse options
  case responseStatusCode response of
    200 -> return $ mapLeft T.pack $ eitherDecode (responseBody response)
    204 -> return $ Left "Key is not found"
    400 -> return $ Left "State store is missing or misconfigured"
    500 -> return $ Left "Get state failed"
    _ -> return $ Left "Unknown response status code"

getStateSimple :: (MonadIO m, FromJSON a) => DaprClientConfig -> Text -> Text -> m (Either Text a)
getStateSimple config store key = getState config store key Nothing Nothing
