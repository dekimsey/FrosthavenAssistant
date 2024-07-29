# Special target: https://github.com/docker/metadata-action#bake-definition
target "docker-metadata-action" {}

# By default, we'll only build the current system's image (useful for development).
group "default" {
  targets = ["server-local"]
}

# Used by both local and CI, simply sets the build context
target "server" {
  inherits = ["docker-metadata-action"]
  context = "./frosthaven_assistant_server"
  dockerfile = "Dockerfile"
}

# Used by the local builds
target "server-local" {
  tags = ["frosthavenassistant:local"]
  inherits = ["server"]
  output = ["type=docker"]
}

# Used by CI to build all targets.
target "server-all" {
  inherits = ["server"]
  platforms = [
    "linux/amd64",
    "linux/arm/v7",
    "linux/arm64"
  ]
}