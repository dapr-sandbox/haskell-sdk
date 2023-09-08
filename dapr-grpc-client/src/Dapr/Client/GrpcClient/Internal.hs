{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE PackageImports #-}
{-# OPTIONS_GHC -fno-warn-missing-export-lists #-}
{-# OPTIONS_GHC -fno-warn-name-shadowing #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# OPTIONS_GHC -fno-warn-unused-matches #-}

module Dapr.Client.GrpcClient.Internal where

import qualified Prelude as Hs
import qualified Control.Applicative as Hs
import Control.Applicative ((<*>), (<|>), (<$>))
import qualified Control.Monad as Hs
import qualified GHC.Generics as Hs

import Network.GRPC.HighLevel.Generated as HsGRPC
import Network.GRPC.HighLevel.Client as HsGRPC

import qualified Google.Protobuf.Any
import qualified Google.Protobuf.Empty
import qualified "dapr-proto" Google.Protobuf.Timestamp
import qualified Dapr.Proto.Common.V1.Common
import qualified Dapr.Proto.Runtime.V1.Dapr

data DaprService request response = DaprService {
                                  daprInvokeService ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.InvokeServiceRequest
                                    Dapr.Proto.Common.V1.Common.InvokeResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Common.V1.Common.InvokeResponse),
                                  daprGetState ::
                                  request 'HsGRPC.Normal Dapr.Proto.Runtime.V1.Dapr.GetStateRequest
                                    Dapr.Proto.Runtime.V1.Dapr.GetStateResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.GetStateResponse),
                                  daprGetBulkState ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.GetBulkStateRequest
                                    Dapr.Proto.Runtime.V1.Dapr.GetBulkStateResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.GetBulkStateResponse),
                                  daprSaveState ::
                                  request 'HsGRPC.Normal Dapr.Proto.Runtime.V1.Dapr.SaveStateRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprQueryStateAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.QueryStateRequest
                                    Dapr.Proto.Runtime.V1.Dapr.QueryStateResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.QueryStateResponse),
                                  daprDeleteState ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.DeleteStateRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprDeleteBulkState ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.DeleteBulkStateRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprExecuteStateTransaction ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.ExecuteStateTransactionRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprPublishEvent ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.PublishEventRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprBulkPublishEventAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.BulkPublishRequest
                                    Dapr.Proto.Runtime.V1.Dapr.BulkPublishResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.BulkPublishResponse),
                                  daprInvokeBinding ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.InvokeBindingRequest
                                    Dapr.Proto.Runtime.V1.Dapr.InvokeBindingResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.InvokeBindingResponse),
                                  daprGetSecret ::
                                  request 'HsGRPC.Normal Dapr.Proto.Runtime.V1.Dapr.GetSecretRequest
                                    Dapr.Proto.Runtime.V1.Dapr.GetSecretResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.GetSecretResponse),
                                  daprGetBulkSecret ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.GetBulkSecretRequest
                                    Dapr.Proto.Runtime.V1.Dapr.GetBulkSecretResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.GetBulkSecretResponse),
                                  daprRegisterActorTimer ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.RegisterActorTimerRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprUnregisterActorTimer ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.UnregisterActorTimerRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprRegisterActorReminder ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.RegisterActorReminderRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprUnregisterActorReminder ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.UnregisterActorReminderRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprRenameActorReminder ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.RenameActorReminderRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprGetActorState ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.GetActorStateRequest
                                    Dapr.Proto.Runtime.V1.Dapr.GetActorStateResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.GetActorStateResponse),
                                  daprExecuteActorStateTransaction ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.ExecuteActorStateTransactionRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprInvokeActor ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.InvokeActorRequest
                                    Dapr.Proto.Runtime.V1.Dapr.InvokeActorResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.InvokeActorResponse),
                                  daprGetConfigurationAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.GetConfigurationRequest
                                    Dapr.Proto.Runtime.V1.Dapr.GetConfigurationResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.GetConfigurationResponse),
                                  daprGetConfiguration ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.GetConfigurationRequest
                                    Dapr.Proto.Runtime.V1.Dapr.GetConfigurationResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.GetConfigurationResponse),
                                  daprSubscribeConfigurationAlpha1 ::
                                  request 'HsGRPC.ServerStreaming
                                    Dapr.Proto.Runtime.V1.Dapr.SubscribeConfigurationRequest
                                    Dapr.Proto.Runtime.V1.Dapr.SubscribeConfigurationResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.ServerStreaming
                                         Dapr.Proto.Runtime.V1.Dapr.SubscribeConfigurationResponse),
                                  daprSubscribeConfiguration ::
                                  request 'HsGRPC.ServerStreaming
                                    Dapr.Proto.Runtime.V1.Dapr.SubscribeConfigurationRequest
                                    Dapr.Proto.Runtime.V1.Dapr.SubscribeConfigurationResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.ServerStreaming
                                         Dapr.Proto.Runtime.V1.Dapr.SubscribeConfigurationResponse),
                                  daprUnsubscribeConfigurationAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.UnsubscribeConfigurationRequest
                                    Dapr.Proto.Runtime.V1.Dapr.UnsubscribeConfigurationResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.UnsubscribeConfigurationResponse),
                                  daprUnsubscribeConfiguration ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.UnsubscribeConfigurationRequest
                                    Dapr.Proto.Runtime.V1.Dapr.UnsubscribeConfigurationResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.UnsubscribeConfigurationResponse),
                                  daprTryLockAlpha1 ::
                                  request 'HsGRPC.Normal Dapr.Proto.Runtime.V1.Dapr.TryLockRequest
                                    Dapr.Proto.Runtime.V1.Dapr.TryLockResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.TryLockResponse),
                                  daprUnlockAlpha1 ::
                                  request 'HsGRPC.Normal Dapr.Proto.Runtime.V1.Dapr.UnlockRequest
                                    Dapr.Proto.Runtime.V1.Dapr.UnlockResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.UnlockResponse),
                                  daprEncryptAlpha1 ::
                                  request 'HsGRPC.BiDiStreaming
                                    Dapr.Proto.Runtime.V1.Dapr.EncryptRequest
                                    Dapr.Proto.Runtime.V1.Dapr.EncryptResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.BiDiStreaming
                                         Dapr.Proto.Runtime.V1.Dapr.EncryptResponse),
                                  daprDecryptAlpha1 ::
                                  request 'HsGRPC.BiDiStreaming
                                    Dapr.Proto.Runtime.V1.Dapr.DecryptRequest
                                    Dapr.Proto.Runtime.V1.Dapr.DecryptResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.BiDiStreaming
                                         Dapr.Proto.Runtime.V1.Dapr.DecryptResponse),
                                  daprGetMetadata ::
                                  request 'HsGRPC.Normal Google.Protobuf.Empty.Empty
                                    Dapr.Proto.Runtime.V1.Dapr.GetMetadataResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.GetMetadataResponse),
                                  daprSetMetadata ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.SetMetadataRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprSubtleGetKeyAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleGetKeyRequest
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleGetKeyResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.SubtleGetKeyResponse),
                                  daprSubtleEncryptAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleEncryptRequest
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleEncryptResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.SubtleEncryptResponse),
                                  daprSubtleDecryptAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleDecryptRequest
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleDecryptResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.SubtleDecryptResponse),
                                  daprSubtleWrapKeyAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleWrapKeyRequest
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleWrapKeyResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.SubtleWrapKeyResponse),
                                  daprSubtleUnwrapKeyAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleUnwrapKeyRequest
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleUnwrapKeyResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.SubtleUnwrapKeyResponse),
                                  daprSubtleSignAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleSignRequest
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleSignResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.SubtleSignResponse),
                                  daprSubtleVerifyAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleVerifyRequest
                                    Dapr.Proto.Runtime.V1.Dapr.SubtleVerifyResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.SubtleVerifyResponse),
                                  daprStartWorkflowAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.StartWorkflowRequest
                                    Dapr.Proto.Runtime.V1.Dapr.StartWorkflowResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.StartWorkflowResponse),
                                  daprGetWorkflowAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.GetWorkflowRequest
                                    Dapr.Proto.Runtime.V1.Dapr.GetWorkflowResponse
                                    ->
                                    Hs.IO
                                      (response 'HsGRPC.Normal
                                         Dapr.Proto.Runtime.V1.Dapr.GetWorkflowResponse),
                                  daprPurgeWorkflowAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.PurgeWorkflowRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprTerminateWorkflowAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.TerminateWorkflowRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprPauseWorkflowAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.PauseWorkflowRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprResumeWorkflowAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.ResumeWorkflowRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprRaiseEventWorkflowAlpha1 ::
                                  request 'HsGRPC.Normal
                                    Dapr.Proto.Runtime.V1.Dapr.RaiseEventWorkflowRequest
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty),
                                  daprShutdown ::
                                  request 'HsGRPC.Normal Google.Protobuf.Empty.Empty
                                    Google.Protobuf.Empty.Empty
                                    -> Hs.IO (response 'HsGRPC.Normal Google.Protobuf.Empty.Empty)}
                           deriving Hs.Generic

daprClient ::
             HsGRPC.Client ->
               Hs.IO (DaprService HsGRPC.ClientRequest HsGRPC.ClientResult)
daprClient client
  = (Hs.pure DaprService) <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/InvokeService")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/GetState")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/GetBulkState")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/SaveState")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/QueryStateAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/DeleteState")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/DeleteBulkState")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/ExecuteStateTransaction")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/PublishEvent")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/BulkPublishEventAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/InvokeBinding")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/GetSecret")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/GetBulkSecret")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/RegisterActorTimer")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/UnregisterActorTimer")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/RegisterActorReminder")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/UnregisterActorReminder")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/RenameActorReminder")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/GetActorState")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/ExecuteActorStateTransaction")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/InvokeActor")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/GetConfigurationAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/GetConfiguration")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/SubscribeConfigurationAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/SubscribeConfiguration")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/UnsubscribeConfigurationAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/UnsubscribeConfiguration")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/TryLockAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/UnlockAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/EncryptAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/DecryptAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/GetMetadata")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/SetMetadata")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/SubtleGetKeyAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/SubtleEncryptAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/SubtleDecryptAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/SubtleWrapKeyAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/SubtleUnwrapKeyAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/SubtleSignAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/SubtleVerifyAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/StartWorkflowAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/GetWorkflowAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/PurgeWorkflowAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/TerminateWorkflowAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/PauseWorkflowAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/ResumeWorkflowAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName
               "/dapr.proto.runtime.v1.Dapr/RaiseEventWorkflowAlpha1")))
      <*>
      ((Hs.pure (HsGRPC.clientRequest client)) <*>
         (HsGRPC.clientRegisterMethod client
            (HsGRPC.MethodName "/dapr.proto.runtime.v1.Dapr/Shutdown")))
