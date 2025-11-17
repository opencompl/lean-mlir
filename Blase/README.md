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


- [ ] Come up with a constant generalization algorithm that exploits our fragment to 
  be much faster (ie, avoid enumerative synthesis).
  The idea would be to recover relationships the constant needs to satisfy,
  and then use a regular language learning algorithm to find a regular language that satisfies these relationships.
  We should then be able to "read off" an expression for this constant from this regular language. This "reading off" would need us to develop an algorithm that can take a regular expression for a bitvector and produce a bitvector expression that realises it, which is interesting in its own. I don't know an algorithm off the top of my head, but I think it's doable and maybe not even too difficult, but definitely needs thought.
- [ ] Add support for `BitVec.cast`, as well as `decide : Prop -> Bool`, as well as `\b. b = true : Bool -> Prop`
- [ ] Write multi-width as a reduction from single-width, with a variable `v` such that `v & (v - 1) = 0`.
   This makes the multi-width version reducible, with the mask being created as `v - 1`.
- [x] Add support for a generalization mode that keeps width 1 and geneeralizes all other widths. This is useful for problems
      with boolean substructure.
- [x] Add support for left shift by constant which will give us much better multiplication encoding.
- [x] Add support for setWidth
- [x] Add support for min/max of width
- [ ] I think we can handle ROVER like problems, canonicalize multiplication via ac_nf, have rules for how to distribute multiplication wrt addition/zext/sext/subtraction/negation, and we are done?
- [x] Write a tactic that takes a goal state with BVs and generalizes them to an arbitrary width. 
      Call this `bv_abstract`.
- [x] Add evaluation from Sam Coward.
- [x] Add evaluation from Lean's bitvector suite.
- [ ] Add right shift and division support by eliminating into left-shift and multiplication.
- [ ] Model reconstruction for counterexamples.
- [x] Add support for Nat and Int sort by adding a fresh width variable that is universally quantified, and then rewriting along this fresh variable.
So to show `n = m`, show that `\forall w, BV.ofNat w n = BV.ofNat w m` for a fresh `w`. However, I don't think this works when it's behind an arrow. So we do need quantifier elimination for widths in that case? [Does not work, needs QE which is too expensive]
- [ ] So, relatedly, add quantifier elimination support for existentials.
- [x] Check if it is possible to entirely drop the dependent syntax, and just use the
  non-dependent AST. [Not possible, too finicky]
- [ ] Add support for nat, int sorts
- [x] Add support for bool, and Prop sorts [Added bool and Prop.
- Add a `w` and `2^w` constraint, where for a unary width, we can build the bitvector that is `2^w` or `2^w - 1`.
- Check if a variable is used both as a width variable and a nat variable, and then throw a user warning.
- Create a "stream differential equation" module that can compile down to FSMs.
