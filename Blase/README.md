# Blase - **Bla**ter for **S**tr**E**ams

A decision procedure that is sound and complete for parametric bitvector expressions
with linear arithmetic, bitwise operationrs, zeroExtend, signExtend, and bitwidth constraints.

#### Algorithms Improvements TODO

- Add a `w` and `2^w` constraint, where for a unary width, we can build the bitvector that is `2^w`
  or `2^w - 1`. 
- Check if a variable is used both as a width variable and a nat variable,
  and then complain about it.
