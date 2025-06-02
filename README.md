# AKP Demo Repo

This repo is used as part of Akuity Platform Demo. 

The demo bootrstrap logic will create an app pointing to the `bootstrap/` directory which will inturn create:

1. 3 Argocd Apps deploying the test/uat/prod env versions of the `base/` application
2. 1 App that bootstraps kargo instance resources foud inside `kargo/`, namely :
  a. Project
  b. Warehouse
  c. 2 Analysis templates
  d. 3 Stages that point to the 3 apps created for each env

The setup expects an argocd instance with a `demo` cluster connected and a kargo instance with 2 agents. 1 default agent and another self hosted agent named `demo` both of which are connected to akp remote argocd instance. 

The demo logic will create the following app using the ArgocdApply api which will auto sync and generate the other resources as mentioned above.

```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: akp-bootstrap
spec:
  destination:
    namespace: argocd
    server: https://kubernetes.default.svc
  source:
    path: bootstrap/
    repoURL: https://github.com/akuity/akp-demo
    targetRevision: HEAD
  project: default
  syncPolicy:
    automated:
      prune: true
```
