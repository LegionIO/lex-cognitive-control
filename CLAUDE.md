# lex-cognitive-control

**Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Cognitive control meta-controller for LegionIO — automatic vs. controlled processing, goal management, and effort allocation. Models the prefrontal cortex function: managing active goals, evaluating control demand (conflict, error, novelty), and switching between automatic and controlled processing modes based on demand.

## Gem Info

- **Gem name**: `lex-cognitive-control`
- **Version**: `0.1.0`
- **Module**: `Legion::Extensions::CognitiveControl`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/cognitive_control/
  cognitive_control.rb
  version.rb
  client.rb
  helpers/
    constants.rb
    controller.rb
    goal.rb
    control_signal.rb
  runners/
    cognitive_control.rb
```

## Key Constants

From `helpers/constants.rb`:

- `CONTROL_MODES` — `%i[automatic controlled override]`
- `GOAL_STATES` — `%i[active suspended completed abandoned]`
- `MAX_GOALS` = `20`, `MAX_POLICIES` = `50`, `MAX_HISTORY` = `200`
- `DEFAULT_EFFORT` = `0.5`, `EFFORT_FLOOR` = `0.1`, `EFFORT_CEILING` = `1.0`
- `EFFORT_DECAY` = `0.02`, `EFFORT_RECOVERY` = `0.03`
- `AUTOMATIC_THRESHOLD` = `0.3`, `CONTROLLED_THRESHOLD` = `0.6`, `OVERRIDE_THRESHOLD` = `0.8`
- `CONFLICT_BOOST` = `0.2`, `ERROR_BOOST` = `0.15`, `NOVELTY_BOOST` = `0.1`
- `ADAPTATION_ALPHA` = `0.1` (EMA alpha for effort adaptation)
- `EFFORT_LABELS` — `0.8+` = `:maximal` through below `0.2` = `:automatic`

## Runners

All methods in `Runners::CognitiveControl`:

- `set_control_goal(description:, domain: :general, priority: 0.5)` — registers a new active goal; returns `goal_id`; enforces `MAX_GOALS` limit
- `advance_control_goal(goal_id:, amount: 0.1)` — increments goal progress
- `suspend_control_goal(goal_id:)` — moves goal to `:suspended` state
- `evaluate_control(conflict: false, error: false, novelty: false)` — computes current control demand and updates mode; returns demand level and mode
- `current_control_mode` — current mode, `should_override?`, `should_control?` flags
- `active_control_goals` — all active goals
- `top_control_goal` — highest-priority active goal
- `update_cognitive_control` — periodic tick: applies effort decay/recovery, updates mode
- `cognitive_control_stats` — full controller state

## Helpers

- `Controller` — manages goals, effort level, and current mode. `evaluate_control_demand` computes demand as weighted sum of conflict, error, and novelty signals; compares against thresholds to determine mode. `tick` applies `EFFORT_DECAY` and `EFFORT_RECOVERY` based on mode.
- `Goal` — has `description`, `domain`, `priority`, `progress`, `state`. `advance!(amount)` increments progress; completion auto-detected at progress 1.0.
- `ControlSignal` — records control evaluation events with demand level and mode transition.

## Integration Points

- Complements `lex-cognitive-autopilot`: autopilot manages familiarity-based mode switching (task-level); control manages goal-level effort allocation and conflict/error response.
- `lex-conflict` registrations should trigger `evaluate_control(conflict: true)` to escalate to controlled or override mode.
- `lex-tick` action selection uses control mode to decide processing depth — override mode implies a full 11-phase deliberate cycle.

## Development Notes

- Three control modes form a hierarchy: `automatic` (below `AUTOMATIC_THRESHOLD`) -> `controlled` (below `CONTROLLED_THRESHOLD`) -> `override` (above `OVERRIDE_THRESHOLD`).
- `MAX_GOALS = 20` is intentionally small — cognitive control requires focus; too many goals = diminished executive function.
- `ADAPTATION_ALPHA = 0.1` is a slow EMA — control demand adapts gradually, not reactively, to avoid thrashing.
- `should_override?` and `should_control?` are boolean helpers for callers that need binary mode decisions.
