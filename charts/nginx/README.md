# Chart Helm do Nginx

![Imagem do nginx](https://nginx.org/nginx.png)

Este Chart Helm implanta o Nginx no Kubernetes.

## Pré-requisitos

* Helm instalado (versão 3 ou superior recomendada)
* Kubernetes cluster em execução (testado em OpenShift local e OCP)
* `kubectl` configurado para interagir com o seu cluster (`oc`, no caso de OpenShift)

## Instalando o Chart

Para instalar o chart com um nome de release de `my-nginx`:

```bash
helm install my-nginx .
```

Ou, se o chart estiver em um repositório Helm:

```bash
helm repo add <nome-do-repositorio> https://nds-cprm.github.io/helm-charts/
helm repo update
helm install my-nginx <nome-do-repositorio>/nginx
```

## Desinstalando o Chart

Para desinstalar a release `my-nginx`:

```bash
helm uninstall my-nginx
```

# Configuração

A tabela abaixo lista os parâmetros configuráveis do chart Nginx e seus valores padrão. Você pode sobrescrever esses valores durante a instalação ou em um arquivo `values.yaml` personalizado.

### Parâmetros gerais

| Parâmetro                     | Descrição                                                                  | Valor Padrão           |
| :---------------------------- | :------------------------------------------------------------------------- | :--------------------- |
| `replicaCount`                | Número desejado de réplicas do Nginx.                                      | `1`                    |
| `image.repository`            | O repositório da imagem Docker do Nginx.                                   | `docker.io/nginxinc/nginx-unprivileged` |
| `image.pullPolicy`            | A política de pull da imagem Docker (`IfNotPresent`, `Always`, `Never`).    | `IfNotPresent`         |
| `image.tag`                   | Tag específica da imagem Docker do Nginx (deixa em branco para usar a tag padrão do chart). | `""`                   |
| `imagePullSecrets`            | Lista de segredos para pull de imagens de um registro privado.             | `[]`                   |
| `nameOverride`                | Nome para sobrescrever o nome padrão do chart.                             | `""`                   |
| `fullnameOverride`            | Nome completo para sobrescrever o nome gerado para os recursos.           | `""`                   |
| `serviceAccount.create`       | Indica se uma ServiceAccount deve ser criada.                             | `false`                |
| `serviceAccount.annotations`  | Anotações a serem adicionadas à ServiceAccount.                           | `{}`                   |
| `serviceAccount.name`         | Nome da ServiceAccount a ser usada (se não criado automaticamente).         | `""`                   |
| `podAnnotations`              | Anotações a serem adicionadas aos pods do Nginx.                           | `{}`                   |
| `podSecurityContext`          | Configurações de segurança para o contexto do pod do Nginx.               | `{}`                   |
| `securityContext`             | Configurações de segurança para os contêineres do Nginx.                   | `{}`                   |
| `service.type`                | Tipo do serviço Kubernetes para expor o Nginx (`ClusterIP`, `LoadBalancer`, `NodePort`). | `ClusterIP`            |
| `service.port`                | Porta do serviço do Nginx.                                                 | `8080`                 |
| `ingress.enabled`             | Indica se um recurso Ingress deve ser criado para o Nginx.                 | `false`                |
| `ingress.className`           | Classe do Ingress a ser usada.                                            | `""`                   |
| `ingress.annotations`         | Anotações a serem adicionadas ao Ingress do Nginx.                         | `{}`                   |
| `ingress.hosts`               | Lista de hosts para o Ingress do Nginx.                                    | `- host: nginx-unprivileged.apps-crc.testing...` |
| `ingress.tls`                 | Configurações de TLS para o Ingress do Nginx.                           | `[]`                   |
| `resources`                   | Requisições e limites de recursos para o pod do Nginx.                     | `{}`                   |
| `autoscaling.enabled`         | Indica se o Horizontal Pod Autoscaler deve ser habilitado.               | `false`                |
| `autoscaling.minReplicas`     | Número mínimo de réplicas para o autoscaling.                              | `1`                    |
| `autoscaling.maxReplicas`     | Número máximo de réplicas para o autoscaling.                              | `5`                    |
| `autoscaling.targetCPUUtilizationPercentage` | Percentual alvo de utilização da CPU para o autoscaling.                  | `80`                   |
| `nodeSelector`                | Seletor de nós para restringir em quais nós os pods podem ser agendados.   | `{}`                   |
| `tolerations`                 | Tolerâncias para permitir que os pods sejam agendados em nós com taints específicos. | `[]`                   |
| `affinity`                    | Regras de afinidade e anti-afinidade para controlar o agendamento de pods. | `{}`                   |


### Parâmetros específicos

| Parâmetro                     | Descrição                                                                  | Valor Padrão           |
| :---------------------------- | :------------------------------------------------------------------------- | :--------------------- |
| `overrides.html.type`         | Tipo de recurso para sobrescrever o HTML padrão (`configMap`, `secret`).   | `configMap`            |
| `overrides.html.name`         | Nome do ConfigMap ou Secret contendo o HTML personalizado.                | `nginx-html`           |
| `overrides.html.enabled`      | Indica se a sobrescrita de HTML está habilitada.                          | `false`                |
| `overrides.default.type`      | Tipo de recurso para sobrescrever a configuração padrão (`configMap`, `secret`). | `configMap`            |
| `overrides.default.name`     | Nome do ConfigMap ou Secret contendo a configuração padrão personalizada. | `nginx-default`        |
| `overrides.default.enabled`   | Indica se a sobrescrita da configuração padrão está habilitada.           | `false`                |

## Uso

Após a instalação, você pode acessar o Nginx através do serviço Kubernetes exposto na porta `8080` dentro do cluster. Se o Ingress estiver habilitado e configurado, você poderá acessar o Nginx através do hostname definido em `ingress.hosts`.

## Configuração Avançada

Você pode personalizar ainda mais a implantação do Nginx criando um arquivo `values.yaml` personalizado e fornecendo-o durante a instalação ou atualização do chart:

```bash
helm install -f my-values.yaml my-nginx .
# ou
helm upgrade -f my-values.yaml my-nginx .
```

Consulte o arquivo `values.yaml` para obter todos os parâmetros configuráveis.

## Contribuições

Sinta-se à vontade para contribuir com este chart através de pull requests no repositório.