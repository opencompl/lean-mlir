# Blase - **Blas**ter for **S**tr**E**ams

A decision procedure that is sound and complete for parametric bitvector expressions
with linear arithmetic, bitwise operationrs, zeroExtend, signExtend, and bitwidth constraints.

To use the bleeding edge of `Blase` your project, add the following to your `lakefile.toml`:

```
[[require]]
name = "Blase"
git = { url = "https://github.com/opencompl/lean-mlir", subDir = "Blase/" }
rev = "main"
```

For stable releases, please change the `rev` to the desired version tag.

#### Algorithms Improvements TODO

- Model reconstruction for counterexamples.
- Add support for Nat and Int sort by adding a fresh width variable that is universally quantified, and then rewriting along this fresh variable.
Hm, but no, that doesn't actually work? Oh wait, maybe it does? Hm, not if it's behind an arrow.
- So, relatedly, add quantifier elimination support for existentials.
- Check if it is possible to entirely drop the dependent syntax, and just use the
  non-dependent AST.
- Add support for nat, int, bool, and Prop sorts.
- Add a `w` and `2^w` constraint, where for a unary width, we can build the bitvector that is `2^w` or `2^w - 1`.
- Check if a variable is used both as a width variable and a nat variable, and then throw a user warning.
- Create a "stream differential equation" module that can compile down to FSMs.
