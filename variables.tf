    variable "token" {
      description = "Your Linode API Personal Access Token. (required)"
      default = "fab5400902f4f5359c4a9057ec167253e2ed7cbbd36650c7bdefa8e34088fe3e"
    }

    variable "k8s_version" {
      description = "The Kubernetes version to use for this cluster. (required)"
      default = "1.21"
    }

    variable "label" {
      description = "The unique label to assign to this cluster. (required)"
      default = "default-lke-cluster"
    }

    variable "region" {
      description = "The region where your cluster will be located. (required)"
      default = "eu-west"
    }

    variable "tags" {
      description = "Tags to apply to your cluster for organizational purposes. (optional)"
      type = list(string)
      default = ["testing"]
    }

    variable "pools" {
      description = "The Node Pool specifications for the Kubernetes cluster. (required)"
      type = list(object({
        type = string
        count = number
      }))
      default = [
        {
          type = "g6-standard-1"
          count = 1
        }
      ]
    }
    