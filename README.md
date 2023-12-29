1. Terraform cluster deployment - main.tf
2. Bootstrap flux:
   
If you have **private key**:

```
flux bootstrap git --url=ssh://git@github.com/...git 
--branch=main
--path=./infrastructure
--private-key-file=/PATH
--toleration-keys="node-type"
--components-extra=image-reflector-controller,image-automation-controll
```

If you use **token**:

```
flux bootstrap github --owner=$GITHUB_OWNER --repository=cluster --branch=main --path=./clusters/my-cluster --personal
```
p.s. add dir charts for kustomize

3. Install helms: reloader and external secret
4. In the Google Cloud account, you need to activate the secrets API and create a secret that we will transfer to the cluster.
![image](https://github.com/popilmv/cluster/assets/115075056/b429b5a7-326a-41d7-9683-ddc035b62f81)
p.s. it will be in json - ![image](https://github.com/popilmv/cluster/assets/115075056/636dcb55-14b3-4432-b931-ab414201b5bf)

5. In the cluster, you need to describe the store - the storage where we create secrets (for us, this is Google) - secret-store.yaml
**p.s.** To connect to the store, you also need to specify the json key that we received - this is described as follows (create like secret or key.yaml:

```
apiVersion: v1
kind: Secret
metadata:
  name: gcpsm-secret #custom name
  labels:
    type: gcpsm
type: Opaque
stringData:
  secret-access-credentials: |-
    {
    }
```

*You can connect without a key - you need to use IAM roles

6. We describe what exactly we need to take from the storage - external-secret.yaml

Im k9s we can see our "secrets"  ![image](https://github.com/popilmv/cluster/assets/115075056/5b7e8d45-6f7a-4cc5-b17f-6cf2cbf4e3bd)
and in google account - ![image](https://github.com/popilmv/cluster/assets/115075056/0d2d7e0e-4fd8-4131-ba42-733996b413a4)

For export secret in some deployment - add:
```
spec:
  containers:
  - name: ubuntu-container
    image: ubuntu
    envFrom:
      - secretRef:
          name: passwd
```
