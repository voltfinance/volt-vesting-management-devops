#!/bin/bash

# Here provided simple scripts to generate README.md for specific Terraform module

# Requirements:
#
# - AWS access to the ecosystem;
# - Pre - instaled: terraform-docs (https://github.com/terraform-docs/terraform-docs).

terraform-docs markdown table --output-file README.md --output-mode inject ./
