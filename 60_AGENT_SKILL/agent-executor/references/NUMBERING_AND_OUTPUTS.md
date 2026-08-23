# Numbering and Outputs

Use fixed-width identifiers. Do not generate random names, timestamp names, content digests, or alternate aliases.

```text
PROJECT-0001
TASK-000001-R001
DISPATCH-TASK-000001-R001
WORK-TASK-000001-R001-BUILDER-001
REPORT-TASK-000001-R001-BUILDER-001.md
DECISION-000001-R001
EVIDENCE-TASK-000001-R001-001
```

Rules:

- The primary Project Architect allocates project, task, revision, and submission numbers.
- A revision changes only when the task contract changes. Do not edit an active revision in place.
- A role submission number increments only for a new formal submission under the same task revision.
- An agent may use only identifiers already assigned in its task.
- A report contains, in order: task identifier and revision; 结果; 交付; 验证; 剩余风险; 下一步.

For GitHub relay, use the assigned exact branch names. A common form is:

```text
task/TASK-000001-R001
work/TASK-000001-R001-BUILDER-001
```

These names are protocol identities. Do not replace them with a branch nickname or an inferred issue title.
