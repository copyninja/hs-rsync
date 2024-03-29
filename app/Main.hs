module Main where

import qualified Data.ByteString.Char8 as BS
import qualified Data.ByteString.Lazy as BL

import Lib

main :: IO ()
main = do
  let fileRemote    = "fasljlajljalfjlajfasdjkg;fdk;kqpitpk;k;asdk;kg;adskg"
      fileLocal     = "ljljalsjdgljadslfjlasjdfqporiuqplsadljfaljdf"
      -- generate signatures at block boundaries for the local file and send it to remote.
      fileLocalSigs = fileSignatures (BL.fromStrict (BS.pack fileLocal)) 5
      -- at remote, take the signatures from the other size and generate instructions.
      insns         = genInstructions fileLocalSigs 5 (BL.fromStrict (BS.pack fileRemote))
      -- at the local side, take those instructions and apply to fileLocal
      fileLocalNew  = recreate (BL.fromStrict (BS.pack fileLocal)) 5 insns
  putStrLn $ "remote: " ++ fileRemote
  putStrLn $ "local:  " ++ fileLocal
  BS.putStrLn $ (BS.pack "recreated: ") `BS.append` (BL.toStrict fileLocalNew)
