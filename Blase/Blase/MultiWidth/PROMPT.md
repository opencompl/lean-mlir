for the function Nondep.Term.toSingleWidthNondepTermGo, Nondep.Term.toSingleWidthNondepTerm ,
and related ones, edit these to change the translation, such that every width variable
in the original problem becomes a new bitvector variable in the translated problem,
whose denotation is the *actual* width value.

Then, when we want to create the mask associated to a width variable, we simply perform
`((1 << widthVar) - 1))`. This now means that width operations such as `+`, `-`, `*`, etc
become normal bitvector operations, so we don't need extra logic to handle them.
This should simplify the translation. 

Please do this modularly, and edit the `toSingleWidthMaskNondepTerm` function
to compute the value correctly based on the new representation of width variables.

