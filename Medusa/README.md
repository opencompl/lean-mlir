# Medusa - A Librarized Hydra


#### Considerations

- Consider changing the index type of `Nat` to an arbitrary `α`.
  This allows us to perform generalization wrt any "parameter".
- Rename `BvGeneralize` and `FpGeneralize` to `Generalize`.
- Move much of the shared infra directly into `Generalize`,
  there seem to be typeclasses which could instead very well live at the top-level.
