# Execution Protocol

## Required task contract

An executable task declares:

```text
task: TASK-000001-R001
role: Builder
startup_mode: fresh | resume
authority_source: <named durable source>
transport: local | github_relay
project: <project identity>
scope: <owned work>
forbidden: <actions and paths>
acceptance: <observable conditions>
inputs: <required project files and records>
report: REPORT-TASK-000001-R001-BUILDER-001.md
stop: <completion or block condition>
```

For `github_relay`, also require repository, task reference, base branch, work branch, full-sync profile, and explicit remote actions. A missing field is forbidden, not implied.

## Seven checks

Before execution confirm: role, entry, authority, access, current task, boundary, and current state. Report `BLOCKED` with the missing item when any check fails.

## Local transport

Read the named authority source and project inputs. Use an isolated writable project copy when a task changes files. Do not claim a durable result until the task-declared formal record has been written.

## GitHub relay transport

1. Refresh remote references before reading or changing the task.
2. Record the live default branch, live main branch when present, task reference, base branch, work branch, and local starting state in the formal report.
3. Materialize the complete declared project tree in an isolated clone or worktree. Do not use a partial checkout. Synchronize declared submodules and LFS content.
4. Confirm the task reference and baseline are current and explain any difference. If remote refresh fails, return `BLOCKED_REMOTE_SYNC`; if drift cannot be safely explained, return `BLOCKED_REMOTE_DRIFT`.
5. Perform only the assigned work.
6. Before returning, refresh the remote again. If the assigned work branch changed unexpectedly, stop; do not force-push or overwrite it.
7. Commit and push only the authorized task work branch. Then read the remote branch back and report the exact recoverable location.

Syncing a repository means synchronizing the declared project tree and authorized task result. It never authorizes replacement of another local workspace, a default branch, another work branch, merge, deploy, release, or destructive cleanup.

## Change and conflict

Stop and request a new revision when scope, forbidden actions, acceptance, authority, transport, baseline, required inputs, role, or report location changes. Stop on shared-interface, security, permission, or durable-state conflict. Do not self-resolve by expanding the task.

## Verification and closure

Evidence outranks self-report. State what was actually validated and what was not. A Builder, Researcher, Repairer, Runner, or Verifier submission is not task acceptance. Stop after the formal report unless the assigned role is Release with explicit human authorization.
