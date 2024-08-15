## [Unreleased]

## [0.1.0] - 2024-08-15

- Initial release
- `emit_event` matcher accepts a string or a regex. Will listen to such events
  via the `ActiveSupport::Notifications` event bus and count matches. By
  default it'll match once, but it can be extended with `#exactly`,
  `#at_least`, `#at_most` modifiers.

