module Dapr.Client.GrpcClient.Utils where

import Dapr.Proto.Common.V1.Common
import Network.HTTP.Types ( StdMethod (GET, HEAD, PUT, DELETE, OPTIONS, PATCH, POST, TRACE, CONNECT) )
import qualified Proto3.Suite as HsProtobuf

mapHttpMethodToHttpVerb :: StdMethod -> HsProtobuf.Enumerated HTTPExtension_Verb
mapHttpMethodToHttpVerb CONNECT = HsProtobuf.Enumerated (Right HTTPExtension_VerbCONNECT)
mapHttpMethodToHttpVerb DELETE = HsProtobuf.Enumerated (Right HTTPExtension_VerbDELETE)
mapHttpMethodToHttpVerb GET = HsProtobuf.Enumerated (Right HTTPExtension_VerbGET)
mapHttpMethodToHttpVerb HEAD = HsProtobuf.Enumerated (Right HTTPExtension_VerbHEAD)
mapHttpMethodToHttpVerb OPTIONS = HsProtobuf.Enumerated (Right HTTPExtension_VerbOPTIONS)
mapHttpMethodToHttpVerb PATCH = HsProtobuf.Enumerated (Right HTTPExtension_VerbPATCH)
mapHttpMethodToHttpVerb POST = HsProtobuf.Enumerated (Right HTTPExtension_VerbPOST)
mapHttpMethodToHttpVerb PUT = HsProtobuf.Enumerated (Right HTTPExtension_VerbPUT)
mapHttpMethodToHttpVerb TRACE = HsProtobuf.Enumerated (Right HTTPExtension_VerbTRACE)


