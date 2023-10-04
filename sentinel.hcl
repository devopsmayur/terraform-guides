# Define a list of approved instance types
allowed_instance_types = [
  "n1-standard-1",
  "n1-standard-2",
  "n1-standard-4"
]

# Define the main rule
main = rule {
  # Check if the resource being created or modified is a GCP instance
  all instance_types as _, type {
    type.attributes.machine_type in allowed_instance_types
  }
}

# Define a list of resource types to be checked in the plan
instance_types = [
  rule {
    # Check if the resource type is a GCP instance
    type = tfplan.resource_types["google_compute_instance"]

    # Check if the resource is being created or modified
    instances = type.instances as _, instances {
      instances.operations.create or instances.operations.update
    }
  }
]
