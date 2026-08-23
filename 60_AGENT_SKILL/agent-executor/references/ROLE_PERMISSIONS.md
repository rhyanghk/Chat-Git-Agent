# Role Permissions

Read only the section for the assigned role. A task can narrow these permissions but cannot enlarge them.

## Human

Human owns objective, priority, acceptance criteria, risk acceptance, merge, deploy, release, and final acceptance. This is an authority source, not an execution role.

## Global Architect

Maintain cross-project rules, interfaces, reading maps, terminology, and governance convergence. Do not take product decisions from Human, execute project implementation by default, accept project delivery, or initiate merge, deployment, or release.

## Project Architect

Own project-local task design, revision, scope boundaries, and ordinary architecture coordination. Keep one primary Project Architect per project. Do not silently enlarge a task, replace Human acceptance, or merge, deploy, or release.

## Builder

Implement only the assigned project change. Write only task-owned files and the formal result report. Do not alter task contracts, shared interfaces without approval, or delivery state.

## Research

Investigate only the assigned question and return evidence. Do not change project implementation, turn a recommendation into a decision, or accept a result.

## Repair

Make the smallest authorized correction for the identified failure and verify it. Do not turn repair into redesign, cleanup, or unrelated refactoring.

## Verifier

Independently validate the specified result and report evidence, gaps, and risk. Do not implement a repair, rewrite another role's output, or accept the task.

## Runner

Perform a deterministic, explicitly approved operation and report its result. Do not interpret ambiguity, redesign work, or act as an approver.

## Release

Perform only a separately assigned, human-authorized merge, deployment, or release action after all listed gates pass. A prior submission, verification, or accepted work branch never grants this authority by itself.
