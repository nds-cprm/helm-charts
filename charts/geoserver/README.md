# Chart Helm do GeoServer

![Imagem do GeoServer](https://geoserver.org/img/geoserver-logo.png)

Este Chart Helm implanta o [Geoserver](https://www.geoserver.org/) no Kubernetes.

## Pré-requisitos

* Helm instalado (versão 3 ou superior recomendada)
* Kubernetes cluster em execução (testado em OpenShift local e OCP)
* `kubectl` configurado para interagir com o seu cluster (`oc`, no caso de OpenShift)

## Instalando o Chart

Para instalar o chart com um nome de release de `my-geoserver`:

```bash
helm repo add <nome-do-repositorio> https://nds-cprm.github.io/helm-charts/
helm repo update
helm install my-geoserver <nome-do-repositorio>/geoserver
```

## Desinstalando o chart

Para desinstalar a release my-geoserver:

```bash
helm uninstall my-geoserver
```

## Configuração

A tabela abaixo lista os parâmetros configuráveis do chart GeoServer e seus valores padrão. Você pode sobrescrever esses valores durante a instalação ou em um arquivo values.yaml personalizado.

| Parâmetro                     | Descrição                                                                  | Valor Padrão           |
| :---------------------------- | :------------------------------------------------------------------------- | :--------------------- |
| `replicaCount`                | Número desejado de réplicas do GeoServer.                                  | `1`                    |
| `image.repository`            | O repositório da imagem Docker do GeoServer.                               | `ndscprm/geoserver`      |
| `image.pullPolicy`            | A política de pull da imagem Docker (`IfNotPresent`, `Always`, `Never`).    | `IfNotPresent`         |
| `image.tag`                   | Tag específica da imagem Docker do GeoServer (deixa em branco para usar a tag padrão do chart). | `""`                   |
| `imagePullSecrets`            | Lista de segredos para pull de imagens de um registro privado.             | `[]`                   |
| `nameOverride`                | Nome para sobrescrever o nome padrão do chart.                             | `""`                   |
| `fullnameOverride`            | Nome completo para sobrescrever o nome gerado para os recursos.           | `""`                   |
| `serviceAccount.create`       | Indica se uma ServiceAccount deve ser criada.                             | `true`                 |
| `serviceAccount.annotations`  | Anotações a serem adicionadas à ServiceAccount.                           | `{}`                   |
| `serviceAccount.name`         | Nome da ServiceAccount a ser usada (se não criado automaticamente).         | `""`                   |
| `podAnnotations`              | Anotações a serem adicionadas aos pods do GeoServer.                       | `{}`                   |
| `podSecurityContext`          | Configurações de segurança para o contexto do pod do GeoServer.           | `{}`                   |
| `securityContext`             | Configurações de segurança para os contêineres do GeoServer.               | `{}`                   |
| `service.type`                | Tipo do serviço Kubernetes para expor o GeoServer (`ClusterIP`, `LoadBalancer`, `NodePort`). | `ClusterIP`            |
| `service.port`                | Porta do serviço do GeoServer.                                             | `8080`                 |
| `ingress.enabled`             | Indica se um recurso Ingress deve ser criado para o GeoServer.             | `false`                |
| `ingress.className`           | Classe do Ingress a ser usada.                                            | `""`                   |
| `ingress.annotations`         | Anotações a serem adicionadas ao Ingress do GeoServer.                     | `{}`                   |
| `ingress.hosts`               | Lista de hosts para o Ingress do GeoServer.                                | `- host: geoserver.apps-crc.testing...` |
| `ingress.tls`                 | Configurações de TLS para o Ingress do GeoServer.                           | `[]`                   |
| `pvc.data.enabled`            | Indica se um PersistentVolumeClaim (PVC) deve ser criado para os dados do GeoServer. | `false`                |
| `pvc.data.keep`               | Se o PVC de dados deve ser mantido ao desinstalar o chart.                 | `true`                 |
| `pvc.data.storage.className`  | Classe de armazenamento para o PVC de dados.                                | `""`                   |
| `pvc.data.storage.size`       | Tamanho do PVC de dados.                                                   | `5Gi`                  |
| `pvc.data.storage.mountPath`  | Caminho de montagem do volume de dados no contêiner.                       | `/srv/geoserver/data`  |
| `pvc.data.storage.accessModes`| Modos de acesso para o PVC de dados (`ReadWriteOnce`, `ReadOnlyMany`).      | `- ReadWriteOnce`      |
| `pvc.gwc.enabled`             | Indica se um PersistentVolumeClaim (PVC) deve ser criado para o GeoWebCache (GWC). | `false`                |
| `pvc.gwc.keep`                | Se o PVC do GWC deve ser mantido ao desinstalar o chart.                  | `true`                 |
| `pvc.gwc.storage.className`   | Classe de armazenamento para o PVC do GWC.                                 | `""`                   |
| `pvc.gwc.storage.size`        | Tamanho do PVC do GWC.                                                    | `5Gi`                  |
| `pvc.gwc.storage.mountPath`   | Caminho de montagem do volume do GWC no contêiner.                        | `/srv/geoserver/gwc`   |
| `pvc.gwc.storage.accessModes` | Modos de acesso para o PVC do GWC (`ReadWriteOnce`, `ReadOnlyMany`).       | `- ReadWriteOnce`\<br\>`- ReadOnlyMany` |
| `resources`                   | Requisições e limites de recursos para o pod do GeoServer.                 | `{}`                   |
| `autoscaling.enabled`         | Indica se o Horizontal Pod Autoscaler deve ser habilitado.               | `false`                |
| `autoscaling.minReplicas`     | Número mínimo de réplicas para o autoscaling.                              | `1`                    |
| `autoscaling.maxReplicas`     | Número máximo de réplicas para o autoscaling.                              | `3`                    |
| `autoscaling.targetCPUUtilizationPercentage` | Percentual alvo de utilização da CPU para o autoscaling.                  | `80`                   |
| `nodeSelector`                | Seletor de nós para restringir em quais nós os pods podem ser agendados.   | `{}`                   |
| `tolerations`                 | Tolerâncias para permitir que os pods sejam agendados em nós com taints específicos. | `[]`                   |
| `affinity`                    | Regras de afinidade e anti-afinidade para controlar o agendamento de pods. | `{}`                   |
| `config.jvm.JAVA_OPTS`        | Opções personalizadas para a JVM do GeoServer.                            | `""`                   |
| `config.jvm.CATALINA_OPTS`    | Opções personalizadas para o Tomcat (Catalina).                           | `""`                   |
| `config.jvm.GEOSERVER_OPTS`   | Opções personalizadas específicas do GeoServer.                           | `""`                   |
| `config.proxyBaseURL`         | URL base para configurar o GeoServer quando executado atrás de um proxy. | `""`                   |
| `config.console.disabled`     | Desabilita o acesso à console administrativa do GeoServer.                 | `false`                |
| `config.cors.allowedOrigins`  | Lista de origens permitidas para CORS.                                    | `[]`                   |
| `config.csrf.disabled`        | Desabilita a proteção CSRF. **Use com cautela.** | `false`                |
| `config.csrf.whitelist`       | Lista de origens na whitelist para CSRF (se habilitado).                  | `[]`                   |
| `config.marlinRenderer.disabled`| Desabilita o renderizador Marlin (pode resolver alguns problemas de renderização). | `false`                |
| `config.appSchema.propertiesFile`| Caminho para um arquivo de propriedades para configuração do App-Schema. | `""`                   |

Consulte o arquivo values.yaml para obter todos os parâmetros configuráveis.

## Uso

Após a instalação, você pode acessar o GeoServer através do serviço Kubernetes exposto na porta 8080 dentro do cluster. Se o Ingress estiver habilitado e configurado, você poderá acessar o GeoServer através do hostname definido em `ingress.hosts`.

Para acessar a interface administrativa do GeoServer, navegue até `/geoserver` no seu browser. As credenciais padrão são `admin/geoserver` (é altamente recomendável alterar essas credenciais após a instalação).

## Configuração Avançada

Você pode personalizar ainda mais a implantação do GeoServer criando um arquivo values.yaml personalizado e fornecendo-o durante a instalação ou atualização do chart:

```bash 
helm install -f my-values.yaml my-geoserver .
# ou
helm upgrade -f my-values.yaml my-geoserver .
```

Consulte o arquivo values.yaml para obter todos os parâmetros configuráveis.

## Contribuições

Sinta-se à vontade para contribuir com este chart através de pull requests no repositório.