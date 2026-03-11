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

#### Table to Support 

```
# Integer arithmetic signature  Σ_IA

symbol        | smt-lib     | arity
--------------+-------------+-------------------
≈_Int         | =           | Int × Int → Bool
≉_Int         | distinct    | Int × Int → Bool
0,1,2,...     | literals    | Int
+             | +           | Int × Int → Int
-             | -           | Int × Int → Int
·             | *           | Int × Int → Int
div           | div         | Int × Int → Int
mod           | mod         | Int × Int → Int
≤             | <=          | Int × Int → Bool
≥             | >=          | Int × Int → Bool
<             | <           | Int × Int → Bool
>             | >           | Int × Int → Bool


# Bitvector (PBV) operators

symbol        | smt-lib        | arity
--------------+----------------+-----------------------
≈_PBV         | =              | PBV × PBV → Bool
≉_PBV         | distinct       | PBV × PBV → Bool

<u            | bvult          | PBV × PBV → Bool
>u            | bvugt          | PBV × PBV → Bool
<s            | bvslt          | PBV × PBV → Bool
>s            | bvsgt          | PBV × PBV → Bool

≤u            | bvule          | PBV × PBV → Bool
≥u            | bvuge          | PBV × PBV → Bool
≤s            | bvsle          | PBV × PBV → Bool
≥s            | bvsge          | PBV × PBV → Bool

~             | bvnot          | PBV → PBV
-_B           | bvneg          | PBV → PBV

&             | bvand          | PBV × PBV → PBV
|             | bvor           | PBV × PBV → PBV
⊕             | bvxor          | PBV × PBV → PBV

<<            | bvshl          | PBV × PBV → PBV
>>            | bvlshr         | PBV × PBV → PBV
>>a           | bvashr         | PBV × PBV → PBV

+_B           | bvadd          | PBV × PBV → PBV
-_B           | bvsub          | PBV × PBV → PBV

·_B           | bvmul          | PBV × PBV → PBV
mod_B         | bvurem         | PBV × PBV → PBV
div_B         | bvudiv         | PBV × PBV → PBV

extract       | pextract       | PBV × Int × Int → PBV
concat        | concat         | PBV × PBV → PBV

ext_z         | pzero_extend   | Int × PBV → PBV
ext_s         | psign_extend   | Int × PBV → PBV

|·|           | bvsize         | PBV → Int
to-pbv        | int_to_pbv     | Int × Int → PBV


# Extension  Σ_IA(pow2, &^N)

symbol        | smt-lib   | arity
--------------+-----------+------------------------
&^N           | piand     | Int × Int × Int → Int
pow2          | pow2      | Int → Int
```

#### Algorithms Improvements TODO

- [ ] Add two options: one that adds the subtraction preconditions, and one that eliminates the subtraction by introducing 
      fresh variables plus addition. For naive BMC, we just want to add the preconditions, since it's cheapter to enumerate and check.
      For k-induction and other solvers, we want to eliminate the subtraction, since our solvers only natively support addition.
- [ ] Finish implementing new cases in 'toSingleWidthNondepTermGo'.
- [ ] Remove redundancy in parser; Don't need to store bitvector widths, can just compute it if needed.
- [ ] Add an error printer of Term that prints only upto k level and then prints '..' for the rest.
- [x] add slt/sle support into QF_BV translation
- [x] Add a Nondep to BVExpr conversion
- [x] Use Nondep -> BV to implement naive enumerative bitblasting.
- [x] Use SingleWidth -> Nondep -> BV to implement single width bounded bitblasting.
- [ ] Come up with a constant generalization algorithm that exploits our fragment to 
  be much faster (ie, avoid enumerative synthesis).
  The idea would be to recover relationships the constant needs to satisfy,
  and then use a regular language learning algorithm to find a regular language that satisfies these relationships.
  We should then be able to "read off" an expression for this constant from this regular language. This "reading off" would need us to develop an algorithm that can take a regular expression for a bitvector and produce a bitvector expression that realises it, which is interesting in its own. I don't know an algorithm off the top of my head, but I think it's doable and maybe not even too difficult, but definitely needs thought.
- [ ] Add support for `BitVec.cast`, as well as `decide : Prop -> Bool`, as well as `\b. b = true : Bool -> Prop`
- [x] Write multi-width as a reduction from single-width, with a variable `v` such that `v & (v - 1) = 0`.
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
