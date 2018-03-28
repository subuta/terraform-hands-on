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

### [Step1] lambdaのデプロイ

シンプルなlambdaを作ります。

1. lambdaを作る。
2. lambdaのデプロイの設定(terraform)を書く。
3. lambdaをデプロイする。

---

### [Step1] ブランチの切り替え

```bash
git checkout -b steps/1-lambda-basics
```

---

### [Step1] terraformの基本

- カレントディレクトリ内に所定の形式([HCL](https://www.terraform.io/docs/configuration/syntax.html))で書かれた *main.tf* を用意する。
- [provider](https://www.terraform.io/docs/providers/index.html) にどのPaaSへデプロイするか(&認証情報)を指定する。今回はAWSとする。

---

### [Step1] 1. lambdaを作る

- 今回は *lambda/functions/terraform-hands-on* にlambdaの実装(index.js)は置いてある。
- lambdaをデプロイするためには、[ディレクトリ構造を抜いたzipにする必要がある](https://stackoverflow.com/questions/41750026/aws-lambda-error-cannot-find-module-var-task-index)ので、以下のコマンドでzip化する。

```
cd lambda
./zip.js
```

---

### [Step1] 2. lambdaのデプロイの設定(terraform)を書く。

- *resource "リソース種別" "リソース名" {}* と書く事で作る設定を定義する。
- lambdaの場合は *resource "aws_lambda_function" "test_lambda" {}* のように書くことで定義できる。
- [main.tf](./main.tf) にこんな感じで書く。
  - *aws_iam_role* -> lambdaの実行用のIAMロールの定義
  - *aws_lambda_function* -> 登録されるlambdaの定義

---

### [step1] 2.1 lambdaのデプロイを検証する。

以下のコマンドを実行する。

```
# terraformの実行に必要なモジュールをfetchする。
terraform init

# terraform実行による差分(行われる変更内容)を確かめる
terraform plan
```

---

### [step1] 2.2 workspaceの切り替え

そのままだとlambdaの名前が被っちゃうので、workspaceを切り替えて対応する。

```
# workspaceを *hoge* へ切り替える。
terraform workspace new hoge

# terraform実行による差分(行われる変更内容)を確かめる
terraform plan
```

---

### [step1] 3. lambdaをデプロイする。

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

---

### [Step2] lambdaのデプロイ+S3

S3 Bucket上にファイルを置くlambdaを作ります。

1. S3 Bucketを作る設定(terraform)を書く。
2. ファイルを置く処理をlambdaに書く。
3. lambdaをデプロイする。

---

### [Step2] ブランチの切り替え

```bash
git checkout -b steps/2-advanced-lambda
```

---

### [Step2] 1. S3 Bucketを作る設定(terraform)を書く。

- S3 Bucketの場合は *resource "aws_s3_bucket" "default" {}* のように書くことで定義できる。
- [main.tf](./main.tf) を追記する。
  - *aws_s3_bucket* -> S3 Bucketの定義

---

### [Step2] 2. ファイルを置く処理をlambdaに書く。

こんな流れで実装済み。

1. *aws-sdk* を読み込む。
2. s3.putObject で任意の内容をBucketに置く(書き込む)

ファイルを更新したら、以下のコマンドでzipしなおす。

```
cd lambda
./zip.js
```

---

### [Step2] 3. lambdaをデプロイする。

以下のコマンドを実行する。

```
# terraformを実行する。
terraform apply
```

---

### [Step2] lambdaを実行してみる。

...と分かるように、適切な実行権限(IAMRole)を設定してやらないと、
S3 Bucketへのアクセスが拒否(Access Denied)されます。
次のStepではこちらの対応をしていきます。

---

### [Step3] lambdaのIAMRoleを修正する。

1. IAMRoleに適切な権限を付与する設定(terraform)を書く。
2. IAMRoleの修正をデプロイする。

---

### [Step3] ブランチの切り替え

```bash
git checkout -b steps/3-fix-lambda-iam-role
```

---

### [Step3] 1. IAMRoleに適切な権限を付与する設定(terraform)を書く。

- IAMRoleの設定(*aws_iam_role*)は既に存在する。
- 今回は権限が足りないので、IAMRoleに権限を付与(*aws_iam_role_policy_attachment*)してやることで解決する。
- [main.tf](./main.tf) を追記する。
  - *aws_iam_role_policy_attachment* -> IAMRoleへIAMPolicyを付与する設定
  - *AmazonS3FullAccess* -> S3へのフルアクセスを許可するポリシー(AWSの組み込み定義)

---

### [Step3] 2. lambdaをデプロイする。

以下のコマンドを実行する。

```
# terraformを実行する。
terraform apply
```

---

### [Step3] lambdaを実行してみる。

直った！(はず

---

### まとめ

- 当たり前ではありますが、変更履歴をterraformに残せるのは便利
- 便利なものの複雑な構成を作ると色々落とし穴はあるので、頑張りましょう 🤤

---

### おわり

以上です。ご静聴ありがとうございました! 🙇