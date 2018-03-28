# terraform-hands-on

---

### 前提条件

- *Terraform v0.11.2*
- *macOS Sierra v10.12.3*
- *aws-cli* および *terraform* を使うために必要なアカウントは用意されてるものとします。
  - *terraform-hands-on* という *profile* で *~/.aws/credentials* が定義されている前提とします。

---

### リポジトリをcloneする。

```bash
git clone https://github.com/subuta/terraform-hands-on
```

---

### [Step1] ブランチの切り替え

```bash
git checkout -b steps/1-terraform-basics
```

---

### [Step1] terraformの基本

- カレントディレクトリ内に所定の形式([HCL](https://www.terraform.io/docs/configuration/syntax.html))で書かれた *main.tf* を用意する。
- [provider](https://www.terraform.io/docs/providers/index.html) にどのPaaSへデプロイするか(&認証情報)を指定する。今回はAWSとする。

---

### [Step1] lambdaを作る

- *resource "リソース種別" "リソース名" {}* と書く事で作る設定を定義する。
- lambdaの場合は *resource "aws_lambda_function" "test_lambda" {}* のように書くことで定義できる。
- 現状の [main.tf](./main.tf) にはこんな定義がある。
  - *aws_iam_role* -> lambdaの実行用のIAMロールの定義
  - *aws_lambda_function* -> 登録されるlambdaの定義

---

### [Step1] lambdaのデプロイの準備をする。

- *lambda/functions/terraform-hands-on* にlambdaの実装(index.js)が置いてある。
- lambdaをデプロイするためには、ディレクトリ構造毎zipにする必要があるので、以下のコマンドでzip化する。
  -> 今回は `functions/zip.js` でzip化しますが、好きな方法でやっていただいて良いです。

```
cd lambda
./zip.js
```

---

### [step1] lambdaのデプロイを検証する。

以下のコマンドを実行する。

```
# terraformの実行に必要なモジュールをfetchする。
terraform init

# terraform実行による差分(行われる変更内容)を確かめる
terraform plan
```

---

### [step1] workspaceの切り替え

そのままだとlambdaの名前が被っちゃうので、workspaceを切り替えて対応する。

```
# workspaceを *hoge* へ切り替える。
terraform workspace new hoge

# terraform実行による差分(行われる変更内容)を確かめる
terraform plan
```

---

### [step1] lambdaをデプロイする。

以下のコマンドを実行する。

```
# terraformを実行する。
terraform apply
```

---

### [step1] lambdaを削除する。

以下のコマンドを実行する。

```
# terraform実行による差分(行われる変更内容)を確かめる
terraform plan --destroy

# terraformによる削除を実行する。
terraform destroy
```