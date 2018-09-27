# TrivialMIPS-Documents

本项目为 TrivialMIPS 项目的文档存放处。文档使用 LaTeX 撰写，并使用 GitLab-CI 调用 Docker 进行持续集成。

## 部署

先构建 Docker 镜像：

```bash
docker build -t your_container_name:tag .
```

向 GitLab 注册 Runner，并将 `.gitlab-ci.yml` 中的 `image` 属性更改为上面指定的名称。