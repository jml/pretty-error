{-| Pretty runtime error messages

These functions can be used to raise clear, understandable error messages for
when your program violates an invariant at runtime.

In particular, 'assertRight' handles a common case where we "know" that a
particular 'Either' is going to be 'Right', and so we want to be able to
unpack the value but also provide a high-quality error message if the value
does somehow turn out to be a 'Left'.

-}

module PrettyError
       ( assertRight
       , fromRight
       , ppText
       , prettyError
       ) where

import BasicPrelude

import Data.ByteString.Char8 (pack)
import Text.Show.Pretty (ppShow)


-- | Assert that value is 'Right'. Throw error if it's 'Left'.
--
-- The first argument is a message which can be used to explain why this
-- error should not have happened.
--
-- Use 'fromRight' if you don't want to provide a message.
--
-- >>> assertRight "Artificial example" (Right 5)
-- 5
--
-- >>> assertRight "Artificial example" (Left "error message")
-- *** Exception: Artificial example: "error message"
assertRight :: Show a => Text -- ^ A message describing the assertion
            -> Either a b     -- ^ The 'Either' to unpack
            -> b              -- ^ The unpacked 'Right' value
assertRight _ (Right r) = r
assertRight message (Left e) = terror $ message ++ ": " ++ ppText e


-- | Extract the value out of a 'Right', or throw an error from a 'Left'
-- made up of the pretty-printed 'Left' value.
--
-- Most of the time you should use 'assertRight', since that allows you to
-- provide a message, which will help to debug the problem.
--
-- >>> fromRight (Right 5)
-- 5
--
-- >>> fromRight (Left 4)
-- *** Exception: 4
fromRight :: Show a => Either a b -> b
fromRight (Left e) = prettyError e
fromRight (Right r) = r


-- | Pretty print a variable to 'Text'
--
-- Although not strictly related to error messages, this is a handy function
-- to have around if you are using "Text.Show.Pretty" and 'OverloadedStrings'.
ppText :: Show a => a -> Text
ppText = decodeUtf8 . pack . ppShow


-- | Raise an error with a pretty-printed value.
--
-- >>> prettyError ["foo","bar","baz"]
-- *** Exception: [ "foo" , "bar" , "baz" ]
prettyError :: Show a => a ->  b
prettyError = error . ppShow
