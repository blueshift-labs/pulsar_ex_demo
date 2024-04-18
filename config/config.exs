import Config

config :logger,
  level: :info,
  truncate: :infinity,
  compile_time_purge_matching: [
    [level_lower_than: :info],
    [application: :tzdata]
  ]

config :pulsar_ex,
  brokers: ["localhost"],
  port: 6650,
  admin_port: 8080,
  producer_opts: [],
  consumer_opts: [],
  auto_setup: true,
  tenants: ["dlq", "demo", "demo1", "demo2"],
  namespaces: [
    "dlq/consumers",
    "demo/workers",
    "demo1/consumers1",
    "demo1/consumers2",
    "demo2/consumers1",
    "demo2/consumers2"
  ],
  topics: [
    "persistent://dlq/consumers/dlq",
    "persistent://dlq/consumers/with_dlq",
    {"persistent://demo/workers/demo", 3},
    "persistent://demo/workers/demo_dlq",
    "persistent://demo1/consumers1/batched1",
    {"persistent://demo1/consumers1/batched2", 3},
    "persistent://demo1/consumers2/batched1",
    {"persistent://demo1/consumers2/batched2", 3},
    "persistent://demo2/consumers1/batched1",
    {"persistent://demo2/consumers1/batched2", 3},
    "persistent://demo2/consumers2/batched1",
    {"persistent://demo2/consumers2/batched2", 3}
  ]
