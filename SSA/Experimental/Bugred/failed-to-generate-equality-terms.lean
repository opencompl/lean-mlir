/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
inductive Op where
| op (name : String)

def sem: (o: Op) → Unit
| .op "a" => ()
| .op "b" => ()
| .op "c" => ()
| .op "d" => ()
| .op "e" => ()
| .op "f" => ()
| .op "g" => ()
| .op "h" => ()
| .op "i" => ()
| _ => ()

theorem Fail: sem (.op "x") = output  := by {
  -- failed to generate equality theorems for `match` expression `sem.match_1`
  simp only[sem];
}

-- The failure disappears with the following changes
-- x remove '.op "i"' case
