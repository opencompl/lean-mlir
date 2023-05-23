# SSA

Theory of static single assignment development in the Lean
proof assistant.

- [Link to generated documentation](https://bollu.github.io/ssa/)


#### Directory Structure


- `SSA/Core`: Libraries for reusable components. Code is reviewed to
  engineering standards. Code is tested, covered by continuous integration, and
  should never be broken. Very low tolerance for tech debt.
    - Breaking changes to core code should be accompanied by fixes to affected
      project code. The project owner should assist in identifying potential
      breakage. No need to fix experimental code.
- `SSA/Projects`. A top-level folder for each major effort (rough criteria: a project represents 1-6 months of work).
    - Code is reviewed for correctness. Testing is recommended but optional, as
      is continuous integration.
    - No cross-project dependencies. If you need code from a different project,
      either go through the effort of polishing the code into core, or clone
      the code.
- `SSA/Experimental`. Anything goes. Recommend namespacing by time (e.g. a new
  directory every month).
    - Rubber-stamp approvals. Code review is optional and comments may be
      ignored without justification. Do not plug this into continuous
      integration.
    - The goal of this directory is to create a safe space for researchers so
      that they do not need to hide their work. By passively observing research
      code “in the wild”, engineers can understand research pain points.
- `related-work/`: Top-level folder for research dependencies.
