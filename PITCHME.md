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

### [Step1] terraformの基本

- カレントディレクトリ内に所定の形式([HCL](https://www.terraform.io/docs/configuration/syntax.html))で書かれた *main.tf* を用意する。
- [provider](https://www.terraform.io/docs/providers/index.html) にどのPaaSへデプロイするかを指定する。今回はAWSとする。