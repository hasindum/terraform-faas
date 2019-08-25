To build

make 

*Terraform runs { init, plan, apply and test } and creating resources in AWS.

*Alternatively run:

make init 
make plan 
make apply
make test (still not completed)

*To clean up all AWS resources, run:

make destroy

* Please export aws credential before run the make command.

URL's 

openfaas endpoint

<NLB_DNS>:80

Grafana endpoint

<NLB_DNS>:8080
