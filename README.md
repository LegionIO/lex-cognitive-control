# lex-cognitive-control

Cognitive control meta-controller for LegionIO. Models automatic vs. controlled processing, goal management, and effort allocation.

## What It Does

The cognitive control system models prefrontal cortex function: maintaining an active goal stack, monitoring for conflict, error, and novelty signals, and switching between automatic (low-effort) and controlled (deliberate, high-effort) processing modes. When override-level demand is detected, the system escalates to maximum controlled effort.

Goals have priority and progress. The controller evaluates control demand from incoming signals and adapts mode using slow EMA for stability.

## Usage

```ruby
client = Legion::Extensions::CognitiveControl::Client.new

goal = client.set_control_goal(
  description: 'complete architecture review',
  domain: :planning,
  priority: 0.8
)

client.evaluate_control(conflict: true, error: false, novelty: true)
client.current_control_mode
# => { mode: :controlled, should_override: false, should_control: true }

client.advance_control_goal(goal_id: goal[:goal_id], amount: 0.3)
client.top_control_goal
client.update_cognitive_control  # call each tick
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
