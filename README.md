# ordermanagement-terraform

## Description

Minimal terraform configuration for configuring an environment in which to run
the ordermanagement-* projects.

## Running

In order to have access to create and destroy AWS resources terraform needs to
know the credentials for an AWS user with the necessary permissions. These will
be discovered automatically from your $HOME/.aws/credentials file alternatively
you can override them with environment variables (region is hardcoded in the
configuration to avoid problems with services not being available in other
regions, etc.)

```
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
```

Then it's just a case of running the following commands to test and then apply
the configuration.

```
$ terraform plan
$ terraform apply
```

Upon completion terraform will output the access-key-id and secret-access-key of
an IAM user with access to allow running the ordermanagement-* projects from a
local development machine.

Note: This is _not_ a secure method of creating users and keys but provides for
a simple demo setup.
