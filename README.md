# AKP Demo Repo

This repo is used as part of Akuity Platform Demo. 

## Manual Setup Instructions

1. Apply Argo CD manifests:

```
argocd proj create -f ./akp-demo/bootstrap/argocd/00-project.yaml
argocd app create -f ./akp-demo/bootstrap/argocd/01-argocd-apps.yaml
```

2. Apply Kargo manifests:

```
kargo apply -f ./akp-demo/bootstrap/kargo/
```
