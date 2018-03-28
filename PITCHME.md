# terraform-hands-on

### 前提条件

- `Terraform v0.11.2`
- `macOS Sierra v10.12.3`
- `aws-cli` および `terraform` を使うために必要なアカウントは用意されてるものとします。
  - `terraform-hands-on` という `profile` で `~/.aws/credentials` が定義されている前提とします。

---

### [step1] リポジトリをcloneする。

```
git clone https://github.com/subuta/terraform-hands-on
```

---

### [step2] lambdaを書く。

```
git checkout -b steps/1-create-first-lambda
```