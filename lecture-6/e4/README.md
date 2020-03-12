# Exercise 4
## 1. Study another QuickCheck framework of your choice (JavaScript, Python, C++, Scala, F#, Erlang, Haskell, ...).

Here are links to some relatively good ones:
 - Quviq QuickCheck (http://www.quviq.com/downloads/) for Erlang (There's a free 'mini' version for download + you can use the full commercial version on open source code via Travis/Jenkins/...)
 - Proper (https://proper-testing.github.io/) for Erlang
 - ScalaCheck (https://www.scalacheck.org/) for Scala
 - Hedgehog (https://github.com/hedgehogqa) for F#, Scala, Haskell, and R
 - FsCheck (https://fscheck.github.io/FsCheck/) for .NET (F# and C#)
 - Hypothesis (https://github.com/HypothesisWorks/hypothesis) for Python (Ruby and Java)
 - fast-check (https://github.com/dubzzz/fast-check) for JavaScript/TypeScript
 - JSVerify (http://jsverify.github.io/) for JavaScript
 - Lua-QuickCheck (https://github.com/luc-tielen/lua-quickcheck) for Lua
 - RapidCheck (https://github.com/emil-e/rapidcheck) for C++
    
but there is bound to be others:

try searching https://github.com for 'quickcheck' or 'property-based testing':  
http://lmgtfy.com/?q=property-based+testing

look at Wikipedia's entry:  
https://en.wikipedia.org/wiki/QuickCheck  
(potentially a good source - but not necessarily. The last time I looked the listed OCaml entry was very out of date.)  

Look at http://hypothesis.works/articles/quickcheck-in-every-language/
    
    
## 2. Install and use:
- Install it
- How easy is it to express some of the examples we have covered?
- How well does the builtin generators (int, list, ...) work?
- Does the framework support shrinking, statistics, ...?
- Does it have a state machine framework for model-based testing? If so: how easy is it/ho- well does it work?
- Prepare a short presentation of the framework based on your findings for next time
