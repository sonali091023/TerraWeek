locals {

  name_prefix = format(
    "%s-%s",
    var.environment,
    var.project_name
  )

  server_name = upper(local.name_prefix)

  merged_tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )

  joined_zones = join(
    ", ",
    var.availability_zones
  )

  zone_count = length(var.availability_zones)

  owner = lookup(
    var.tags,
    "Owner",
    "Unknown"
  )
}