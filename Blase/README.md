# Blase - **Bla**ter for **S**tr**E**ams

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

- Check if it is possible to entirely drop the dependent syntax, and just use the
  non-dependent AST.
- Add support for nat, int, bool sorts.
- Add a `w` and `2^w` constraint, where for a unary width, we can build the bitvector that is `2^w`
  or `2^w - 1`. 
- Check if a variable is used both as a width variable and a nat variable, and then complain about it.
