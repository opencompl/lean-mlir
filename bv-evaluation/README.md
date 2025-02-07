# hacker's delight symbolic width

- have stuff in this organization: `~/paper-lean-bitvectors/`, followed by `~/lean-mlir`. The paths are used to index and directly write the CSV.

```
python3 compare-leansat-vs-bitwuzla-hdel-sym.py
python3 collect-data-hdel-symbolic.py
```


#### Useful Queries For Automata

```
sqlite> select distinct t1.fileTitle, t1.thmName, t1.goalStr from tests as t1 inner join tests as t2 where t1.fileTitle = t2.fileTitle and t1.thmName = t2.thmName and t1.goalStr = t2.goalStr and t1.tactic = "presburger" and t2.tactic="circuit" and t1.status != t2.status;
gaddhmask_proof| add_mask_sign_commute_i32_thm|case neg x✝ : BitVec 32 h✝¹ : ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) h✝ : ¬BitVec.ofBool (x✝ <ₛ 0#32) = 1#1 ⊢ x✝.sshiftRight' 31#32 + (x✝.sshiftRight' 31#32 &&& 8#32) = 0#32
gaddhmask_proof| add_mask_sign_commute_i32_thm|case pos x✝ : BitVec 32 h✝¹ : ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) h✝ : BitVec.ofBool (x✝ <ₛ 0#32) = 1#1 ⊢ x✝.sshiftRight' 31#32 + (x✝.sshiftRight' 31#32 &&& 8#32) = 7#32
gaddhmask_proof| add_mask_sign_i32_thm|case neg x✝ : BitVec 32 h✝¹ : ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) h✝ : ¬BitVec.ofBool (x✝ <ₛ 0#32) = 1#1 ⊢ (x✝.sshiftRight' 31#32 &&& 8#32) + x✝.sshiftRight' 31#32 = 0#32
gaddhmask_proof| add_mask_sign_i32_thm|case pos x✝ : BitVec 32 h✝¹ : ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) h✝ : BitVec.ofBool (x✝ <ₛ 0#32) = 1#1 ⊢ (x✝.sshiftRight' 31#32 &&& 8#32) + x✝.sshiftRight' 31#32 = 7#32
```
