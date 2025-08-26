## This is day 01 of my Terraform journey

I will be learning and sharing the basics of terrafom with AWS (Amazon Web Sevices) cloud platform.

---

**Terraform workflow:**

- It will initialize the terrafrom.
    ```
    Terrafrom init
    ```

- Below command willl show you what resource will be create by terrafom. command shown below is like a dry run.
    ```
    Terraform plan
    ```

- Below shown command willl apply all the written resource in your selected cloud provider, in my case it is AWS.
    ```
    Terraform apply
    ```

- Below shown command willl destroy all the written resource in your selected cloud provider, in my case it is AWS.
    ```
    Terraform destroy
    ```

---
**As part of my AWS learning day-01, I will be writing basic AWS EC2 creation from Terrafom.**