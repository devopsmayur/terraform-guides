import "tfplan/v2" as tfplan

# Define a list of approved instance types
approved_instance_types = [
  "n1-standard-1",
  "n1-standard-2",
  "n1-standard-4"
]

main = rule {
  # Get the resource changes from the plan
  resource_changes = tfplan.resource_changes
  
  # Iterate through all resource changes
  all_resource_changes_approved = all resource_changes as _, rc {
    # Check if the resource is a google_compute_instance
    is_instance = rc.type is "google_compute_instance"
    
    # Check if the instance type is in the approved list
    instance_type_approved = is_instance and rc.attributes["machine_type"] in approved_instance_types
    
    # Return true if the instance type is approved, false otherwise
    instance_type_approved
  }
  
  # The main rule is true if all resource changes are approved
  all_resource_changes_approved
}
