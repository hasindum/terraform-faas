To build and test the Terraform code by run:

make
Terraform runs { init, plan, apply and test } and creating resources in AWS.

Alternatively run:

make init 
make plan 
make apply
make test (still not completed)

To clean up all AWS resources, run:

make destroy

* Please export aws credential before run the make command.