/-#
The horn clause fragment of MBA [a /\ b /\ c /\ .. /\ k => l]

## Key Idea

We currently reduce the problem to a 0/1 ILP over the current bits.
In general, we can use the same insight as the automata, and feed the bits in 'vertical' slices.
But when we do so, it seems like we can also write in hypotheses, and convert the whole thing into an omega problem.

For example, consider:

```lean
a = 0 
  =>
(a &&& b) = 0
```

For this, we would build the following MBA problem:

```lean
ai.toInt = 0 
  =>
(ai && bi).toInt = 0
```

Can bitblast the 'ai : Bool' and check the proposition.
Actually, doesn't this work for any CNF formula?
I think so!

So we can decide any conjunction of (dis) equalities?

Can we decide disequalities?

a /= b <-> forall (ai bi : Bool), [ai] /= [bi] by the same MBA algorithm?
-/

