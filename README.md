# pretty-error

Sometimes you need to assume something at runtime that you can't prove in the
type system. When you do that, you should make sure you get a good error
message if ever your assumption turns out to be wrong. That's what this
library is for.

Use the functions in here to get high quality error messages for when your
invariants don't hold at runtime. The functions all pretty print any Haskell
values given to them, which makes it easier to understand what's going on when
your code breaks.

## Examples

`assertRight` for a successful assertion:

```
>>> assertRight "Example message" (Right 42)
42
```

`assertRight` for a failed assertion:

```
>>> assertRight "Example message" (Left "unexpected error")
*** Exception: Example message: "unexpected error"
```

Using `fromRight` to unpack an `Either` that is actually a `Left`:

```
>>> fromRight (Left ["foo","bar","baz"])
*** Exception: [ "foo" , "bar" , "baz" ]
```
