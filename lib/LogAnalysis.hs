{-# OPTIONS_GHC -Wall #-}
module LogAnalysis where

import Log

parseMessage :: String -> LogMessage
parseMessage str = 
  let wordList = words str in
  case wordList of
    ("I":ts:msg)     -> LogMessage Info (read ts) (unwords msg)
    ("W":ts:msg)     -> LogMessage Warning (read ts) (unwords msg)
    ("E":lvl:ts:msg) -> LogMessage (Error (read lvl)) (read ts) (unwords msg)
    _                -> Unknown (unwords wordList)

