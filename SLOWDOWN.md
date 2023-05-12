# Reproducing Slowdown

```
lake build SSA.Examples.InstCombinePeepholeRewrites
rm ./build/lib/SSA/Examples/InstCombinePeepholeRewrites.* ./build/ir/SSA/Examples/InstCombinePeepholeRewrites.* ; time lake env lean --profile SSA/Examples/InstCombinePeepholeRewrites.lean > out 2> out2
```


```
~/Projects/ssa$ rm ./build/lib/SSA/Examples/InstCombinePeepholeRewrites.* ./build/ir/SSA/Examples/InstCombinePeepholeRewrites.* ; time lake env lean --profile SSA/Examples/InstCombinePeepholeRewrites.lean > out 2> out2
rm: cannot remove './build/lib/SSA/Examples/InstCombinePeepholeRewrites.*': No such file or directory
rm: cannot remove './build/ir/SSA/Examples/InstCombinePeepholeRewrites.*': No such file or directory

real    0m3.102s
user    0m2.880s
sys 0m0.224s
~/Projects/ssa$ cat out2
interpretation of Std.Linter.UnreachableTactic.initFn._@.Std.Linter.UnreachableTactic._hyg.1426 took 110ms
interpretation of Std.Tactic.Lint.stdLinterExt took 113ms
import took 354ms
simp took 524ms
type checking took 651ms
cumulative profiling times:
    attribute application 0.967ms
    compilation 16.5ms
    compilation new 32ms
    elaboration 46.7ms
    import 354ms
    initialization 24.7ms
    interpretation 593ms
    linting 2.11ms
    parsing 1.45ms
    simp 524ms
    tactic execution 1.47ms
    type checking 653ms
    typeclass inference 38.8ms
~/Projects/ssa$ wc out
  1247   6245 100617 out
```

